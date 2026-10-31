import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/setting_local_data_source.dart';
import 'package:shared/data/data_sources/translation_remote_data_source.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/language_setup_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/models/local_translation_origin.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/repositories/translation_fill_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _batchSize = 50;

typedef _FillTask = ({Language target, Language? scope});

@Injectable(as: TranslationFillRepository)
class const TranslationFillRepositoryImpl(
  final VocabularyLocalDataSource _localDataSource,
  final SettingLocalDataSource _settingDataSource,
  final TranslationRemoteDataSource _remoteDataSource,
) implements TranslationFillRepository {
  @override
  Future<AppResult<int>> fillMissingTranslations() async {
    try {
      final setup = (await _settingDataSource.readLanguageSettings()).toLanguageSetup();
      if (setup == null) return const Success(0);
      for (final task in _tasksOf(setup)) {
        final vocabularies = await _localDataSource.findVocabulariesMissingTranslation(
          languageCode: task.target.toLanguageCode(),
          progressLanguageCode: task.scope?.toLanguageCode(),
          limit: _batchSize,
        );
        if (vocabularies.isNotEmpty) return Success(await _fill(vocabularies, task.target));
      }
      return const Success(0);
    } on Object catch (error) {
      return Failure(error.toServiceError());
    }
  }

  List<_FillTask> _tasksOf(LanguageSetup setup) {
    return [
      for (final learned in setup.active) (target: learned.language, scope: learned.language),
      (target: setup.main, scope: null),
      for (final learned in setup.learned)
        if (learned.askMeIn case final askMeIn?
            when !setup.isLearning(askMeIn) && askMeIn != setup.main)
          (target: askMeIn, scope: learned.language),
      for (final learned in setup.paused) (target: learned.language, scope: learned.language),
    ];
  }

  Future<int> _fill(List<LocalVocabulary> vocabularies, Language target) async {
    final entered = [
      for (final vocabulary in vocabularies)
        ?vocabulary.translations
            ?.where((translation) => translation.origin == LocalTranslationOrigin.entered.value)
            .firstOrNull,
    ];
    if (entered.isEmpty) return 0;
    final source = entered.first.languageCode;
    final batch = [
      for (final translation in entered)
        if (translation.languageCode == source) translation,
    ];
    final texts = [for (final translation in batch) translation.text];
    final translated = source.toLanguage().isSameLanguageAs(target)
        ? texts
        : await _remoteDataSource.translateBatch(
            texts: texts,
            sourceLanguage: source,
            targetLanguage: target.toLanguageCode(),
          );
    await _localDataSource.insertMissingTranslations([
      for (final (index, text) in translated.indexed)
        Translation(
          language: target,
          text: text,
          origin: TranslationOrigin.translated,
        ).toLocalTranslation(vocabularyId: batch[index].vocabularyId),
    ]);
    return translated.length;
  }
}
