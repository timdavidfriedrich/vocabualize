import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/data/data_sources/cloud_notification_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/local_notification_data_source.dart';
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
  void initLocalNotifications() {
    _localNotificaionDataSource.init();
  }

  @override
  void scheduleGatherNotification() {
    _localNotificaionDataSource.scheduleGatherNotification();
  }

  @override
  void schedulePractiseNotification({int? numberOfVocabularies, TimeOfDay? timeOfDay}) {
    _localNotificaionDataSource.schedulePractiseNotification(
      numberOfVocabularies: numberOfVocabularies,
      timeOfDay: timeOfDay,
    );
  }
}
