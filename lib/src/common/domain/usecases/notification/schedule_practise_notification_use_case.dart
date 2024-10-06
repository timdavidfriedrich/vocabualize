import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/vocabulary_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/vocabulary_repository.dart';

final schedulePractiseNotificationUseCaseProvider = AutoDisposeProvider((ref) {
  return SchedulePractiseNotificationUseCase(
    notificationRepository: ref.watch(notificationRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
    vocabularyRepository: ref.watch(vocabularyRepositoryProvider),
  );
});

class SchedulePractiseNotificationUseCase {
  final NotificationRepository _notificationRepository;
  final SettingsRepository _settingsRepository;
  final VocabularyRepository _vocabularyRepository;

  const SchedulePractiseNotificationUseCase({
    required NotificationRepository notificationRepository,
    required SettingsRepository settingsRepository,
    required VocabularyRepository vocabularyRepository,
  })  : _notificationRepository = notificationRepository,
        _settingsRepository = settingsRepository,
        _vocabularyRepository = vocabularyRepository;

  void call() async {
    // TODO: Does this even make sense? The number won't be recent (or will it?)
    final timeOfDay = await _settingsRepository.getGatherNotificationTime();
    final vocabulariesToPractise = await _vocabularyRepository.getVocabulariesToPractise();
    _notificationRepository.schedulePractiseNotification(
      time: timeOfDay,
      numberOfVocabularies: vocabulariesToPractise.length,
    );
  }
}
