import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/translation_fill_trigger.dart';
import 'package:shared/domain/extensions/language_setup_stream_extensions.dart';
import 'package:shared/domain/extensions/stream_extensions.dart';
import 'package:shared/domain/repositories/connectivity_repository.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

@injectable
class const WatchTranslationFillTriggersUseCase(
  final LanguageRepository _languageRepository,
  final ConnectivityRepository _connectivityRepository,
  final VocabularyRepository _vocabularyRepository,
) {
  Stream<AppResult<TranslationFillTrigger>> call() {
    return _watchLanguageChanges().mergeWith(_watchReconnects()).mergeWith(_watchWordChanges());
  }

  Stream<AppResult<TranslationFillTrigger>> _watchLanguageChanges() {
    return _languageRepository.watchLanguageSetup().map(
      (result) => switch (result) {
        Success() => const Success(TranslationFillTrigger.conditionsChanged),
        Failure(:final error) => Failure(error),
      },
    );
  }

  Stream<AppResult<TranslationFillTrigger>> _watchReconnects() async* {
    await for (final result in _connectivityRepository.watchIsConnected()) {
      switch (result) {
        case Success(data: true):
          yield const Success(TranslationFillTrigger.conditionsChanged);
        case Success(data: false):
          break;
        case Failure(:final error):
          yield Failure(error);
      }
    }
  }

  Stream<AppResult<TranslationFillTrigger>> _watchWordChanges() {
    return _languageRepository
        .watchLanguageSetup()
        .toDistinctLanguages((setup) => setup.learned)
        .switchMap(
          (result) => switch (result) {
            Success(:final data) =>
              _vocabularyRepository
                  .watchVocabularyOverview(languages: data)
                  .map<AppResult<TranslationFillTrigger>>(
                    (overview) => switch (overview) {
                      Success() => const Success(TranslationFillTrigger.wordsChanged),
                      Failure(:final error) => Failure(error),
                    },
                  ),
            Failure(:final error) => Stream.value(Failure(error)),
          },
        );
  }
}
