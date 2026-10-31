import 'package:dart_mappable/dart_mappable.dart';

part 'local_backup.mapper.dart';

@MappableClass()
class const LocalBackupManifest({
  required final String format,
  required final int version,
  required final String source,
  required final DateTime createdAt,
  required final Map<String, int> counts,
  required final List<String> missingImages,
  required final LocalBackupLanguages? languages,
}) with LocalBackupManifestMappable;

@MappableClass()
class const LocalBackupLanguages({
  required final String? mainLanguage,
  required final String? selectedLanguage,
  required final List<String> learnedLanguages,
}) with LocalBackupLanguagesMappable;

@MappableClass()
class const LocalBackupVocabulary({
  required final String id,
  required final List<LocalBackupTranslation> translations,
  required final List<LocalBackupProgress> progress,
  required final List<String> tagIds,
  required final DateTime createdAt,
  required final LocalBackupImage? image,
}) with LocalBackupVocabularyMappable;

@MappableClass()
class const LocalBackupTranslation({
  required final String language,
  required final String text,
  required final String origin,
}) with LocalBackupTranslationMappable;

@MappableClass()
class const LocalBackupProgress({
  required final String language,
  required final String stage,
  required final double level,
  required final int intervalMinutes,
  required final double ease,
  required final DateTime nextReviewAt,
  required final DateTime createdAt,
}) with LocalBackupProgressMappable;

@MappableClass()
class const LocalBackupImage({
  required final String kind,
  required final String? path,
  required final String? pexelsId,
  required final String? url,
  required final String? thumbUrl,
  required final String? photographer,
  required final String? photographerUrl,
}) with LocalBackupImageMappable;

@MappableClass()
class const LocalBackupTag({
  required final String id,
  required final String name,
}) with LocalBackupTagMappable;

@MappableClass()
class const LocalBackupActivity({
  required final String localDate,
  required final int? practicedCount,
}) with LocalBackupActivityMappable;

class const LocalBackupContents({
  required final List<LocalBackupVocabulary> vocabularies,
  required final List<LocalBackupTag> tags,
  required final List<LocalBackupActivity> activities,
});

class const LocalBackupArchive({
  required final String directoryPath,
  required final LocalBackupManifest manifest,
  required final LocalBackupContents contents,
});
