import 'package:shared/data/models/local_backup.dart';
import 'package:shared/data/models/local_language_pair_setting.dart';
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
      source: source,
      target: target,
      sourceLanguageCode: sourceLanguageCode,
      targetLanguageCode: targetLanguageCode,
      tagIds: tagIds,
      level: level,
      isNovice: isNovice,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
      createdAt: createdAt.toUtc(),
      image: switch ((image, imageEntryPath)) {
        (CustomImage(), final String path) => LocalBackupImage(
          kind: _imageKindCustom,
          path: path,
          pexelsId: null,
          url: null,
          thumbUrl: null,
          photographer: null,
          photographerUrl: null,
        ),
        (
          StockImage(:final id, :final url, :final thumbUrl, :final photographer, :final photographerUrl),
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
      source: source,
      target: target,
      sourceLanguageCode: sourceLanguageCode,
      targetLanguageCode: targetLanguageCode,
      level: level,
      isNovice: isNovice,
      intervalMinutes: intervalMinutes,
      ease: ease,
      nextReviewAt: nextReviewAt.toUtc(),
      image: image,
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
      LocalBackupActivity(localDate: localDate, type: type);
}

extension LocalBackupActivityMappers on LocalBackupActivity {
  LocalActivity toLocalActivity({
    required UuidValue id,
  }) {
    return LocalActivity(
      id: id,
      type: type,
      localDate: localDate,
      occurredAt: DateTime.parse(localDate).toUtc(),
    );
  }
}

extension LocalBackupSettingsMappers on LocalBackupSettings {
  LocalLanguagePairSetting toLocalLanguagePairSetting() {
    return LocalLanguagePairSetting(source: sourceLanguageCode, target: targetLanguageCode);
  }
}

extension LocalLanguagePairSettingBackupMappers on LocalLanguagePairSetting {
  LocalBackupSettings toLocalBackupSettings() {
    return LocalBackupSettings(sourceLanguageCode: source, targetLanguageCode: target);
  }
}
