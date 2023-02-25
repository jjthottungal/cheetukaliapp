// ignore_for_file: prefer_const_constructors
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings("@mipmap/ic_launcher");
  static final DarwinInitializationSettings iosSettings =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          requestCriticalPermission: true);

  static void initilize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {},
    );
  }

  static void showNotificationOnForeground(RemoteMessage message) async {
    final notificationDetail = NotificationDetails(
      android: AndroidNotificationDetails(
          "WGpushnotification", "WGpushnotificationchannel",
          importance: Importance.max, priority: Priority.high, playSound: true),
      iOS: DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true),
    );

    await _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetail,
        payload: message.data["message"]);
  }
}
