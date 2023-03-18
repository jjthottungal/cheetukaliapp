// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
          requestCriticalPermission: true,
          onDidReceiveLocalNotification: (id, title, body, payload) async {});

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
    //final http.Response response =
    //    await http.get(Uri.parse(Urls.notificationImageUrl));

    //final ByteArrayAndroidBitmap largeIconbigPicture =
    //    ByteArrayAndroidBitmap(response.bodyBytes);

    final attachmentPicturePath = await _downloadAndSaveFile(
        Urls.notificationImageUrl,
        'attachment_img.jpg'); //FilePathAndroidBitmap(attachmentPicturePath),

    //print(attachmentPicturePath);
    final FilePathAndroidBitmap largeIconbigPicture =
        FilePathAndroidBitmap(attachmentPicturePath);

    final styleInfo = BigPictureStyleInformation(
      largeIconbigPicture,
      hideExpandedLargeIcon: true,
    );

    final notificationDetail = NotificationDetails(
      android: AndroidNotificationDetails(
          "WGpushnotification", "WGpushnotificationchannel",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          largeIcon:
              largeIconbigPicture, //DrawableResourceAndroidBitmap("wg_notification"),
          channelShowBadge: true,
          styleInformation: styleInfo),
      iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          attachments: [DarwinNotificationAttachment(attachmentPicturePath)]),
    );

    await _notificationsPlugin.show(
        0, //DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetail,
        payload: message.data["message"]);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    if (await File(filePath).exists()) {
      return filePath;
    } else {
      final http.Response response = await http.get(Uri.parse(url));
      final File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    }
  }
}
