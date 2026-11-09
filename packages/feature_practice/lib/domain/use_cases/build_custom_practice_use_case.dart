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
    final dueLanguages = {
      for (final language in plan.languages)
        if (language.words == PracticeWords.due) language.language,
    };
    final allLanguages = {
      for (final language in plan.languages)
        if (language.words == PracticeWords.all) language.language,
    };
    final reviews = <PracticeItem>[];
    if (dueLanguages.isNotEmpty) {
      final due = await _vocabularyRepository.findDueItems(
        languages: dueLanguages,
        dueBy: DateTime.now().toUtc(),
        limit: null,
        tagIds: plan.tagIds,
      );
      switch (due) {
        case Success(:final data):
          reviews.addAll(data);
        case Failure(:final error):
          return Failure(error);
      }
    }
    if (allLanguages.isNotEmpty) {
      final started = await _vocabularyRepository.findStartedItems(
        languages: allLanguages,
        tagIds: plan.tagIds,
      );
      switch (started) {
        case Success(:final data):
          reviews.addAll(data);
        case Failure(:final error):
          return Failure(error);
      }
    }
    reviews.sort(_byNextReview);
    final chosenReviews = [
      for (final language in plan.languages)
        ...reviews
            .where((item) => item.language == language.language)
            .take(language.reviewWordCount),
    ]..sort(_byNextReview);
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
      for (final item in [...chosenReviews, ...newItems])
        PracticeItemKey(vocabularyId: item.vocabulary.id, language: item.language),
    ]);
  }

  int _byNextReview(PracticeItem first, PracticeItem second) =>
      _nextReviewOf(first).compareTo(_nextReviewOf(second));

  DateTime _nextReviewOf(PracticeItem item) =>
      item.vocabulary.progress[item.language]?.nextReviewAt ??
      DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
}
