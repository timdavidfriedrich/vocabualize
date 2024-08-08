abstract interface class NotificationRepository {
  void initCloudNotifications();
  void initLocalNotifications();
  void scheduleGatherNotification();
  void schedulePractiseNotification();
}
