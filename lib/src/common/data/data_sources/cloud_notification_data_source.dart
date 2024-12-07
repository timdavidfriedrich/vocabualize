import 'package:flutter_riverpod/flutter_riverpod.dart';

final cloudNotificationDataSourceProvider =
    Provider((ref) => CloudNotificationDataSource());

class CloudNotificationDataSource {
  void init() {
    //FirebaseMessaging.onBackgroundMessage(_cloudNotificationBackgroundHandler);
  }
}

/*
// * Must be top-level (outside of any class)
Future<void> _cloudNotificationBackgroundHandler(RemoteMessage message) async {
  Log.hint(
    "Received a background message with id=${message.messageId}."
    "\n\tdata: ${message.data}"
    "\n\tnotification: ${message.notification ?? "-"}",
  );
}
*/
