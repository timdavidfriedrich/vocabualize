import 'dart:async';

import 'package:core/error/app_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/repositories/language_repository.dart';

@injectable
class LanguageSetupCubit extends Cubit<LanguageSetup?> {
  LanguageSetupCubit(this._languageRepository) : super(null);

  final LanguageRepository _languageRepository;
  StreamSubscription<AppResult<LanguageSetup?>>? _subscription;

  void start() {
    _subscription ??= _languageRepository.watchLanguageSetup().listen((result) {
      if (result case Success(:final data)) emit(data);
    });
  }

  Future<void> select(Language language) async {
    await _languageRepository.selectLanguage(language);
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
