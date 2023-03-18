import 'package:onesignal_flutter/onesignal_flutter.dart';

class OnesignalNotificationListenerProvider {
  void onesignalRegisterNotification() async {
    OneSignal.shared.setLogLevel(OSLogLevel.debug, OSLogLevel.none);

    //Set the App ID
    await OneSignal.shared.setAppId('f80e933f-f880-4d2b-b801-464ab423cba5');

    //Forgroud meesage event handler
    OneSignal.shared.setNotificationWillShowInForegroundHandler((event) {
      OSNotificationDisplayType.notification;
    });
  }
}
