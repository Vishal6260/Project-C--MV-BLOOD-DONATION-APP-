import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('flutter_logo');

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationPlugin.show(
        id, title, body, await notificationDetails());
  }

  // only for Android
  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          styleInformation: BigTextStyleInformation(""),
          importance: Importance.max),
    );
  }
}
