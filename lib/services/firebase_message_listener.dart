import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/controllers/utils_controller.dart';
import 'package:cheetukaliapp/services/local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationListenerProvider {
  void registerNotification() async {
    //Declare and Initialize Controller
    final kaliListController = Get.find<CheetuKaliController>();
    //Declare and Initialize Controller
    final utilsController = Get.put(UtilsController());

    // Terminated State - Background message
    FirebaseMessaging.instance.getInitialMessage();
    //.then((message) {
    //  if (message != null) {
    //setState(() {
    //  notificationMsg =
    //      "${message.notification!.title} ${message.notification!.body} I am coming from terminated state";
    //});
    //  }
    //});

    // Foreground State
    FirebaseMessaging.onMessage.listen((message) {
      LocalNotificationService.showNotificationOnForeground(message);
      //Once data changed, update all lists for cheetukali data
      kaliListController.dataHasChanged();
      //print(" This is message when Foreground State");
    });

    // background State
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      //Once data changed, update all lists for cheetukali data
      //if app is logged in
      //kaliListController.dataHasChanged();
      //print(" This is message when background State");
    });
  }
}
