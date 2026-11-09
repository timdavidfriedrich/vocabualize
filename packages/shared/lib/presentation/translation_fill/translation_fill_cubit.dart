import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_overview.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/translation_fill_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';
import 'package:shared/presentation/translation_fill/translation_fill_state.dart';

@injectable
class TranslationFillCubit extends Cubit<TranslationFillState> {
  TranslationFillCubit(
    this._translationFillRepository,
    this._languageRepository,
    this._connectivityRepository,
    this._vocabularyRepository,
  ) : super(TranslationFillState.idle);

  final TranslationFillRepository _translationFillRepository;
  final LanguageRepository _languageRepository;
  final ConnectivityRepository _connectivityRepository;
  final VocabularyRepository _vocabularyRepository;
  final _subscriptions = <StreamSubscription<Object?>>[];
  StreamSubscription<AppResult<VocabularyOverview>>? _changeSubscription;
  AppLifecycleListener? _lifecycleListener;
  Set<Language>? _languages;
  var _isRunning = false;
  var _isRequested = false;
  var _isPaused = false;

  void start() {
    if (_subscriptions.isNotEmpty) return;
    _lifecycleListener = AppLifecycleListener(onResume: () => _request(isFresh: true));
    _subscriptions.addAll([
      _languageRepository.watchLanguageSetup().listen((result) {
        if (result case Success(:final data)) {
          _watchChanges(data);
          _request(isFresh: true);
        }
      }),
      _connectivityRepository.watchIsConnected().listen((result) {
        if (result case Success(data: true)) _request(isFresh: true);
      }),
    ]);
  }

  void _watchChanges(LanguageSetup? setup) {
    final languages = {
      for (final learned in setup?.learned ?? const <LearnedLanguage>[]) learned.language,
    };
    if (setEquals(languages, _languages)) return;
    _languages = languages;
    unawaited(_changeSubscription?.cancel());
    _changeSubscription = _vocabularyRepository
        .watchVocabularyOverview(languages: languages)
        .listen((_) => _request(isFresh: false));
  }

  void _request({required bool isFresh}) {
    if (isFresh) _isPaused = false;
    if (_isPaused || isClosed) return;
    if (_isRunning) {
      _isRequested = true;
      return;
    }
    unawaited(_run());
  }

  Future<void> _run() async {
    _isRunning = true;
    AppResult<int>? last;
    do {
      _isRequested = false;
      while (!isClosed) {
        last = await _translationFillRepository.fillMissingTranslations();
        if (last case Failure()) _isPaused = true;
        if (last case Failure() || Success(data: 0)) break;
      }
    } while (_isRequested && !_isPaused && !isClosed);
    _isRunning = false;
    if (isClosed) return;
    switch (last) {
      case Failure(error: TranslationQuotaExceededError()):
        emit(TranslationFillState.limitReached);
      case Success():
        emit(TranslationFillState.idle);
      case Failure() || null:
        break;
    }
  }

  @override
  Future<void> close() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
    await _changeSubscription?.cancel();
    _lifecycleListener?.dispose();
    return super.close();
  }
}
