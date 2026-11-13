import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

@injectable
class const BuildCustomPracticeUseCase(
  final VocabularyRepository _vocabularyRepository,
) {
  Future<AppResult<List<PracticeItemKey>>> call(CustomPracticePlan plan) async {
    final dueBy = DateTime.now().toUtc();
    final reviews = <PracticeItem>[];
    for (final language in plan.languages) {
      if (language.reviewWordCount <= 0) continue;
      final found = await switch (language.words) {
        PracticeWords.due => _vocabularyRepository.findDueItems(
          languages: {language.language},
          dueBy: dueBy,
          limit: language.reviewWordCount,
          tagIds: plan.tagIds,
        ),
        PracticeWords.all => _vocabularyRepository.findStartedItems(
          languages: {language.language},
          limit: language.reviewWordCount,
          tagIds: plan.tagIds,
        ),
      };
      switch (found) {
        case Success(:final data):
          reviews.addAll(data);
        case Failure(:final error):
          return Failure(error);
      }
    }
    reviews.sort(_byNextReview);
    final newItems = <PracticeItem>[];
    for (final language in plan.languages) {
      if (language.newWordCount <= 0) continue;
      final waiting = await _vocabularyRepository.findWaitingItems(
        language: language.language,
        limit: language.newWordCount,
        tagIds: plan.tagIds,
      );
      switch (waiting) {
        case Success(:final data):
          newItems.addAll(data);
        case Failure(:final error):
          return Failure(error);
      }
    }
    return Success([
      for (final item in [...reviews, ...newItems])
        PracticeItemKey(vocabularyId: item.vocabulary.id, language: item.language),
    ]);
  }

  int _byNextReview(PracticeItem first, PracticeItem second) =>
      _nextReviewOf(first).compareTo(_nextReviewOf(second));

  DateTime _nextReviewOf(PracticeItem item) =>
      item.vocabulary.progress[item.language]?.nextReviewAt ??
      DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
}
