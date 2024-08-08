import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/cloud_notification_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/local_notification_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final _cloudNotificationDataSource = sl.get<CloudNotificationDataSource>();
  final _localNotificaionDataSource = sl.get<LocalNotificationDataSource>();

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
  void schedulePractiseNotification() {
    _localNotificaionDataSource.schedulePractiseNotification();
  }
}
