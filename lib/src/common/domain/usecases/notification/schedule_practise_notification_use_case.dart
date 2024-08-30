import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

class SchedulePractiseNotificationUseCase {
  final _notificationRepository = sl.get<NotificationRepository>();
  final _vocabularyRepository = sl.get<VocabularyRepository>();
  // TODO: add settings repo and get the time of day from there

  void call() async {
    // TODO: Does this even make sense? The number won't be recent
    final vocabulariesToPractise = await _vocabularyRepository.getVocabulariesToPractise();
    _notificationRepository.schedulePractiseNotification(
      numberOfVocabularies: vocabulariesToPractise.length,
    );
  }
}
