import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/progress.dart';
import 'package:shared/domain/repositories/vocabulary_repository.dart';

const _firstIntervalMinutes = 5;

@injectable
class const IntroduceVocabularyUseCase(
  final VocabularyRepository _vocabularyRepository,
) {
  Future<AppResult<()>> call(PracticeItem item) async {
    final progress = item.vocabulary.progress[item.language];
    if (progress == null) return const Failure(NotFoundError());
    final now = DateTime.now().toUtc();
    return _vocabularyRepository.saveReview(
      vocabularyId: item.vocabulary.id,
      progress: progress.copyWith(
        stage: ProgressStage.shortTerm,
        intervalMinutes: _firstIntervalMinutes,
        nextReviewAt: now.add(const Duration(minutes: _firstIntervalMinutes)),
      ),
    );
  }
}
