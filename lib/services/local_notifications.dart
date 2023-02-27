// ignore_for_file: prefer_const_constructors
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

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

//Bigpictire extract from URL from server
//Future<Uint8List> getByteArrayFromUrl(String url) async {
//    final http.Response response = await http.get(Uri.parse(url));
//    return response.bodyBytes;
//  }

  static void showNotificationOnForeground(RemoteMessage message) async {
    final http.Response response =
        await http.get(Uri.parse(Urls.notificationImageUrl));

    final ByteArrayAndroidBitmap largeIcon =
        ByteArrayAndroidBitmap(response.bodyBytes);
    //final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
    //    await _getByteArrayFromUrl('https://dummyimage.com/400x800'));

    final styleInfo = BigPictureStyleInformation(
      largeIcon,
      hideExpandedLargeIcon: true,
    );

    final notificationDetail = NotificationDetails(
      android: AndroidNotificationDetails(
          "WGpushnotification", "WGpushnotificationchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          largeIcon:
              largeIcon, //DrawableResourceAndroidBitmap("wg_notification"),
          channelShowBadge: true,
          styleInformation: styleInfo),
      iOS: DarwinNotificationDetails(
          presentAlert: true, presentBadge: true, presentSound: true),
    );

    await _notificationsPlugin.show(
        0, //DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetail,
        payload: message.data["message"]);
  }
}
