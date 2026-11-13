import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

@injectable
class const CountCustomPracticeUseCase(
  final VocabularyRepository _vocabularyRepository,
) {
  Future<AppResult<Map<Language, CustomPracticeCounts>>> call({
    required List<Language> languages,
    required Set<String> tagIds,
  }) async {
    final dueBy = DateTime.now().toUtc();
    final counts = <Language, CustomPracticeCounts>{};
    for (final language in languages) {
      final (due, started, waiting) = await (
        _vocabularyRepository.countDueItems(languages: {language}, dueBy: dueBy, tagIds: tagIds),
        _vocabularyRepository.countStartedItems(languages: {language}, tagIds: tagIds),
        _vocabularyRepository.countWaitingItems(language: language, tagIds: tagIds),
      ).wait;
      switch ((due, started, waiting)) {
        case (Success(data: final due), Success(data: final started), Success(data: final waiting)):
          counts[language] = CustomPracticeCounts(
            dueCount: due,
            startedCount: started,
            waitingCount: waiting,
          );
        case (Failure(:final error), _, _) ||
            (_, Failure(:final error), _) ||
            (_, _, Failure(:final error)):
          return Failure(error);
      }
    }
    return Success(counts);
  }
}
