enum LocalReminderKind {
  practice(channelId: "practice_reminders", firstNotificationId: 1000),
  streak(channelId: "streak_reminders", firstNotificationId: 2000);

  const LocalReminderKind({
    required this.channelId,
    required this.firstNotificationId,
  });

  final String channelId;
  final int firstNotificationId;
}
