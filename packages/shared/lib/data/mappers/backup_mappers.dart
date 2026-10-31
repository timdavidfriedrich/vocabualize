import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/models/local_backup.dart';
import 'package:shared/data/models/local_language_settings.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _imageKindCustom = "custom";
const _imageKindStock = "stock";

extension VocabularyBackupMappers on Vocabulary {
  LocalBackupVocabulary toLocalBackupVocabulary({
    required List<String> tagIds,
    required String? imageEntryPath,
  }) {
    return LocalBackupVocabulary(
      id: id,
      translations: [
        for (final translation in translations.values)
          LocalBackupTranslation(
            language: translation.language.toLanguageCode(),
            text: translation.text,
            origin: translation.origin.value,
          ),
      ],
      progress: [
        for (final row in progress.values)
          LocalBackupProgress(
            language: row.language.toLanguageCode(),
            stage: row.stage.value,
            level: row.level,
            intervalMinutes: row.intervalMinutes,
            ease: row.ease,
            nextReviewAt: row.nextReviewAt.toUtc(),
            createdAt: row.createdAt.toUtc(),
          ),
      ],
      tagIds: tagIds,
      createdAt: createdAt.toUtc(),
      image: switch ((image, imageEntryPath)) {
        (CustomImage(:final photographer, :final photographerUrl), final String path) =>
          LocalBackupImage(
            kind: _imageKindCustom,
            path: path,
            pexelsId: null,
            url: null,
            thumbUrl: null,
            photographer: photographer,
            photographerUrl: photographerUrl,
          ),
        (
          StockImage(
            :final id,
            :final url,
            :final thumbUrl,
            :final photographer,
            :final photographerUrl,
          ),
          _,
        ) =>
          LocalBackupImage(
            kind: _imageKindStock,
            path: null,
            pexelsId: id,
            url: url,
            thumbUrl: thumbUrl,
            photographer: photographer,
            photographerUrl: photographerUrl,
          ),
        (CustomImage() || NoImage(), _) => null,
      },
    );
  }
}

extension LocalBackupVocabularyMappers on LocalBackupVocabulary {
  Vocabulary toVocabulary({
    required String id,
    required VocabularyImage image,
  }) {
    return Vocabulary(
      id: id,
      translations: {
        for (final translation in translations)
          if (translation.language.toLanguage() case final language
              when language != Language.unknown)
            language: Translation(
              language: language,
              text: translation.text,
              origin: translation.origin.toTranslationOrigin(),
            ),
      },
      progress: {
        for (final row in progress)
          if (row.language.toLanguage() case final language when language != Language.unknown)
            language: Progress(
              language: language,
              stage: row.stage.toProgressStage(),
              level: row.level,
              intervalMinutes: row.intervalMinutes,
              ease: row.ease,
              nextReviewAt: row.nextReviewAt.toUtc(),
              createdAt: row.createdAt.toUtc(),
            ),
      },
      image: image,
      tagIds: const {},
      createdAt: createdAt.toUtc(),
    );
  }
}

extension LocalBackupImageMappers on LocalBackupImage {
  String? get customImagePath => kind == _imageKindCustom ? path : null;

  VocabularyImage toVocabularyImage() {
    return switch ((kind, pexelsId, url, thumbUrl)) {
      (_imageKindStock, final String id, final String url, final String thumbUrl) => StockImage(
        id: id,
        url: url,
        thumbUrl: thumbUrl,
        photographer: photographer,
        photographerUrl: photographerUrl,
      ),
      _ => const NoImage(),
    };
  }
}

extension LocalTagBackupMappers on LocalTag {
  LocalBackupTag toLocalBackupTag() => LocalBackupTag(id: id.toString(), name: name);
}

extension LocalBackupTagMappers on LocalBackupTag {
  LocalTag toLocalTag({
    required UuidValue id,
    required DateTime createdAt,
  }) {
    return LocalTag(id: id, name: name, createdAt: createdAt);
  }
}

extension LocalActivityBackupMappers on LocalActivity {
  LocalBackupActivity toLocalBackupActivity() =>
      LocalBackupActivity(localDate: localDate, practicedCount: practicedCount);
}

extension LocalBackupActivityMappers on LocalBackupActivity {
  LocalActivity toLocalActivity({
    required UuidValue id,
  }) {
    return LocalActivity(
      id: id,
      localDate: localDate,
      deviceId: null,
      practicedCount: practicedCount ?? 0,
    );
  }
}

extension LocalLanguageSettingsBackupMappers on LocalLanguageSettings {
  LocalBackupLanguages toLocalBackupLanguages() {
    return LocalBackupLanguages(
      mainLanguage: mainLanguage,
      selectedLanguage: selectedLanguage,
      learnedLanguages: learnedLanguages,
    );
  }
}
