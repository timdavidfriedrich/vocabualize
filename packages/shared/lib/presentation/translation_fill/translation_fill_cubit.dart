import 'dart:async';

import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/translation_fill_trigger.dart';
import 'package:shared/domain/use_cases/fill_missing_translations_use_case.dart';
import 'package:shared/domain/use_cases/watch_translation_fill_triggers_use_case.dart';
import 'package:shared/presentation/translation_fill/translation_fill_state.dart';

@injectable
class TranslationFillCubit extends Cubit<TranslationFillState> {
  TranslationFillCubit(
    this._watchTranslationFillTriggers,
    this._fillMissingTranslations,
  ) : super(TranslationFillState.idle);

  final WatchTranslationFillTriggersUseCase _watchTranslationFillTriggers;
  final FillMissingTranslationsUseCase _fillMissingTranslations;
  StreamSubscription<AppResult<TranslationFillTrigger>>? _subscription;
  var _isRunning = false;
  var _isRequested = false;
  var _isPaused = false;

  void start() {
    _subscription ??= _watchTranslationFillTriggers().listen((result) {
      switch (result) {
        case Success(data: TranslationFillTrigger.conditionsChanged):
          _request(isFresh: true);
        case Success(data: TranslationFillTrigger.wordsChanged):
          _request(isFresh: false);
        case Failure():
          break;
      }
    });
  }

  void resume() => _request(isFresh: true);

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
    AppResult<()> last;
    do {
      _isRequested = false;
      last = await _fillMissingTranslations();
      if (last case Failure()) _isPaused = true;
    } while (_isRequested && !_isPaused && !isClosed);
    _isRunning = false;
    if (isClosed) return;
    switch (last) {
      case Failure(error: TranslationQuotaExceededError()):
        emit(TranslationFillState.limitReached);
      case Success():
        emit(TranslationFillState.idle);
      case Failure():
        break;
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
