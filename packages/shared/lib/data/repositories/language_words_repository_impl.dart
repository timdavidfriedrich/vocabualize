import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/vocabulary_local_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/data/extensions/stream_extensions.dart';
import 'package:shared/data/mappers/language_mappers.dart';
import 'package:shared/data/mappers/tag_mappers.dart';
import 'package:shared/data/mappers/vocabulary_mappers.dart';
import 'package:shared/data/models/local_language_membership.dart';
import 'package:shared/data/models/local_translation_origin.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_coverage.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/repositories/language_words_repository.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

typedef _Plan = ({Set<UuidValue> added, Set<UuidValue> removed, int removedAlsoElsewhere});

@Injectable(as: LanguageWordsRepository)
class const LanguageWordsRepositoryImpl(
  final VocabularyLocalDataSource _localDataSource,
) implements LanguageWordsRepository {
  @override
  Stream<AppResult<LanguageCoverage>> watchLanguageCoverage(Language language) {
    return _localDataSource
        .watchLanguageMembership(language.toLanguageCode())
        .map(_coverageOf)
        .toAppResult();
  }

  @override
  Future<AppResult<LanguageWordsPreview>> previewChange(
    Language language,
    LanguageWordsChange change,
  ) async {
    try {
      final plan = _planOf(
        await _localDataSource.readLanguageMembership(language.toLanguageCode()),
        change,
      );
      return Success(
        LanguageWordsPreview(
          addedCount: plan.added.length,
          removedCount: plan.removed.length,
          removedAlsoElsewhereCount: plan.removedAlsoElsewhere,
        ),
      );
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> applyChange(Language language, LanguageWordsChange change) async {
    try {
      final languageCode = language.toLanguageCode();
      final plan = _planOf(await _localDataSource.readLanguageMembership(languageCode), change);
      final now = DateTime.now().toUtc();
      await _localDataSource.insertMissingProgress([
        for (final vocabularyId in plan.added)
          language
              .toNewProgress(ProgressStage.waiting, at: now)
              .toLocalProgress(vocabularyId: vocabularyId),
      ]);
      await _localDataSource.deleteProgress(
        languageCode: languageCode,
        vocabularyIds: plan.removed,
      );
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> restartLanguage(Language language) async {
    try {
      final now = DateTime.now().toUtc();
      final rows = await _localDataSource.findProgress(language.toLanguageCode());
      await _localDataSource.resetProgress([
        for (final row in rows)
          row.toProgress().restarted(at: now).toLocalProgress(vocabularyId: row.vocabularyId),
      ]);
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  @override
  Future<AppResult<()>> deleteLanguageWords(
    Language language, {
    required bool keepsTranslations,
  }) async {
    try {
      final languageCode = language.toLanguageCode();
      await _localDataSource.deleteProgress(languageCode: languageCode, vocabularyIds: null);
      if (!keepsTranslations) {
        await _localDataSource.deleteTranslations(
          languageCode: languageCode,
          keptOrigins: {LocalTranslationOrigin.entered.value},
        );
      }
      return const Success(());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }

  LanguageCoverage _coverageOf(LocalLanguageMembership membership) {
    final membersByTag = _membersByTag(membership);
    final untagged = _untagged(membership);
    return LanguageCoverage(
      totalCount: membership.vocabularyIds.length,
      inLanguageCount: membership.inLanguage.intersection(membership.vocabularyIds).length,
      collections: [
        for (final tag in membership.tags)
          if (tag.id case final tagId?)
            CollectionCoverage(
              tag: tag.toTag(),
              totalCount: membersByTag[tagId]?.length ?? 0,
              inLanguageCount: membersByTag[tagId]?.intersection(membership.inLanguage).length ?? 0,
            ),
      ],
      untaggedCount: untagged.length,
      untaggedInLanguageCount: untagged.intersection(membership.inLanguage).length,
    );
  }

  _Plan _planOf(LocalLanguageMembership membership, LanguageWordsChange change) {
    final membersByTag = _membersByTag(membership);
    final untagged = _untagged(membership);
    Set<UuidValue> membersOf(Set<String> tagIds, {required bool withUntagged}) => {
      for (final tagId in tagIds) ...?membersByTag[UuidValue.withValidation(tagId)],
      if (withUntagged) ...untagged,
    };
    final removed = membersOf(
      change.removedTagIds,
      withUntagged: change.removesUntagged,
    ).intersection(membership.inLanguage);
    final added =
        (change.addsAll
                ? membership.vocabularyIds
                : membersOf(change.addedTagIds, withUntagged: change.addsUntagged))
            .difference(membership.inLanguage)
            .difference(removed);
    final keptTagMembers = {
      for (final MapEntry(key: tagId, value: members) in membersByTag.entries)
        if (!change.removedTagIds.contains(tagId.uuid)) ...members,
    };
    return (
      added: added,
      removed: removed,
      removedAlsoElsewhere: removed.intersection(keptTagMembers).length,
    );
  }

  Map<UuidValue, Set<UuidValue>> _membersByTag(LocalLanguageMembership membership) {
    final membersByTag = <UuidValue, Set<UuidValue>>{};
    for (final link in membership.tagLinks) {
      membersByTag.putIfAbsent(link.tagId, () => {}).add(link.vocabularyId);
    }
    return membersByTag;
  }

  Set<UuidValue> _untagged(LocalLanguageMembership membership) {
    return membership.vocabularyIds.difference({
      for (final link in membership.tagLinks) link.vocabularyId,
    });
  }
}
