import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

abstract interface class NotificationRepository {
  void initCloudNotifications();
  void initLocalNotifications();
  void scheduleGatherNotification({required TimeOfDay time, required Language targetLanguage});
  void schedulePractiseNotification({required TimeOfDay time, int? numberOfVocabularies});
}
