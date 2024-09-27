import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final schedulePractiseNotificationUseCaseProvider = Provider((ref) {
  return SchedulePractiseNotificationUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class SchedulePractiseNotificationUseCase {
  final NotificationRepository _notificationRepository;
  final VocabularyRepository _vocabularyRepository;

  const SchedulePractiseNotificationUseCase({
    required NotificationRepository notificationRepository,
    required VocabularyRepository vocabularyRepository,
  })  : _notificationRepository = notificationRepository,
        _vocabularyRepository = vocabularyRepository;

  void call() async {
    // TODO: Does this even make sense? The number won't be recent (or will it?)
    final vocabulariesToPractise = await _vocabularyRepository.getVocabulariesToPractise();
    _notificationRepository.schedulePractiseNotification(
      numberOfVocabularies: vocabulariesToPractise.length,
    );
  }
}
