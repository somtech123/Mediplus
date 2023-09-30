import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: const AndroidInitializationSettings("mipmap/ic_launcher"),
            iOS: initializationSettingsIOS);

    _notificationsPlugin.initialize(initializationSettings);
  }

  static void notifyUser(
      {required String title, required String body, String? payload}) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("mediplus", "mediplus channel",
              channelDescription: 'mediplus description',
              importance: Importance.max,
              priority: Priority.high,
              styleInformation: BigTextStyleInformation('')));

      await _notificationsPlugin.show(
        id,
        title,
        body,
        notificationDetails,
        payload: payload,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
