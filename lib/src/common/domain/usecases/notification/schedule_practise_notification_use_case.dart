import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/repositories/notification_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/settings_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/settings_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/get_vocabularies_to_practise_use_case.dart';

final schedulePractiseNotificationUseCaseProvider = AutoDisposeProvider((ref) {
  // TODO: Refactor schedulePractiseNotificationUseCaseProvider to not use getVocabulariesToPractiseUseCaseProvider (don't mix use cases)
  final vocabulariesToPracise = ref.watch(getVocabulariesToPractiseUseCaseProvider(null));
  return SchedulePractiseNotificationUseCase(
    numberOfVocabulariesToPractise: vocabulariesToPracise.length,
    notificationRepository: ref.watch(notificationRepositoryProvider),
    settingsRepository: ref.watch(settingsRepositoryProvider),
  );
});

class SchedulePractiseNotificationUseCase {
  final int _numberOfVocabulariesToPractise;
  final NotificationRepository _notificationRepository;
  final SettingsRepository _settingsRepository;

  const SchedulePractiseNotificationUseCase({
    required int numberOfVocabulariesToPractise,
    required NotificationRepository notificationRepository,
    required SettingsRepository settingsRepository,
  })  : _numberOfVocabulariesToPractise = numberOfVocabulariesToPractise,
        _notificationRepository = notificationRepository,
        _settingsRepository = settingsRepository;

  void call() async {
    // TODO: Does this even make sense? The number won't be recent (or will it?)
    final timeOfDay = await _settingsRepository.getGatherNotificationTime();
    _notificationRepository.schedulePractiseNotification(
      time: timeOfDay,
      numberOfVocabularies: _numberOfVocabulariesToPractise,
    );
  }
}
