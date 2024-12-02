import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/data/data_sources/cloud_notification_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/local_notification_data_source.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

final notificationRepositoryProvider = Provider((ref) {
  return NotificationRepositoryImpl(
    cloudNotificationDataSource: ref.watch(cloudNotificationDataSourceProvider),
    localNotificationDataSource: ref.watch(localNotificationDataSourceProvider),
  );
});

class NotificationRepositoryImpl implements NotificationRepository {
  final CloudNotificationDataSource _cloudNotificationDataSource;
  final LocalNotificationDataSource _localNotificaionDataSource;

  const NotificationRepositoryImpl({
    required CloudNotificationDataSource cloudNotificationDataSource,
    required LocalNotificationDataSource localNotificationDataSource,
  })  : _cloudNotificationDataSource = cloudNotificationDataSource,
        _localNotificaionDataSource = localNotificationDataSource;

  @override
  void initCloudNotifications() {
    _cloudNotificationDataSource.init();
  }

  @override
  Future<void> initLocalNotifications() async {
    await _localNotificaionDataSource.init();
  }

  @override
  void scheduleGatherNotification({required TimeOfDay time, required Language targetLanguage}) {
    _localNotificaionDataSource.scheduleGatherNotification(
      time: time,
      targetLanguage: targetLanguage,
    );
  }

  @override
  void schedulePractiseNotification({required TimeOfDay time, int? numberOfVocabularies}) {
    _localNotificaionDataSource.schedulePractiseNotification(
      time: time,
      numberOfVocabularies: numberOfVocabularies,
    );
  }
}
