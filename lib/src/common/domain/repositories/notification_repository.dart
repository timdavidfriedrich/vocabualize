import 'package:vocabualize/constants/common_imports.dart';

abstract interface class NotificationRepository {
  void initCloudNotifications();
  void initLocalNotifications();
  void scheduleGatherNotification();
  void schedulePractiseNotification({int? numberOfVocabularies, TimeOfDay? timeOfDay});
}
