import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/language_repository.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

@injectable
class const BuildCustomPracticeUseCase(
  final VocabularyRepository _vocabularyRepository,
  final LanguageRepository _languageRepository,
) {
  Future<AppResult<List<PracticeItemKey>>> call(CustomPracticeFilter filter) async {
    if (filter.languages.isEmpty) return const Success([]);
    final setupResult = await _languageRepository.readLanguageSetup();
    if (setupResult case Failure(:final error)) return Failure(error);
    final setup = switch (setupResult) {
      Success(:final data) => data,
      Failure() => null,
    };
    final reviews = switch (filter.words) {
      PracticeWords.due => await _vocabularyRepository.findDueItems(
        languages: filter.languages,
        dueBy: DateTime.now().toUtc(),
        limit: null,
        tagIds: filter.tagIds,
      ),
      PracticeWords.all => await _vocabularyRepository.findStartedItems(
        languages: filter.languages,
        tagIds: filter.tagIds,
      ),
    };
    if (reviews case Failure(:final error)) return Failure(error);
    final reviewItems = switch (reviews) {
      Success(:final data) => data,
      Failure() => const <PracticeItem>[],
    };
    final newItems = <PracticeItem>[];
    if (filter.newWords != PracticeNewWords.none) {
      for (final language in filter.languages) {
        final waiting = await _vocabularyRepository.findWaitingItems(
          language: language,
          limit: switch ((filter.newWords, setup?.learnedOf(language)?.newWords)) {
            (PracticeNewWords.upToCap, NewWordsUpTo(:final count)) => count,
            _ => null,
          },
          tagIds: filter.tagIds,
        );
        switch (waiting) {
          case Success(:final data):
            newItems.addAll(data);
          case Failure(:final error):
            return Failure(error);
        }
      }
    }
    return Success([
      for (final item in [...reviewItems, ...newItems])
        PracticeItemKey(vocabularyId: item.vocabulary.id, language: item.language),
    ]);
  }
}
