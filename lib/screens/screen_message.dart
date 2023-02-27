// ignore_for_file: avoid_print
import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:cheetukaliapp/models/pushmessagemodel.dart';

class ScreenMessage extends StatelessWidget {
  ScreenMessage({super.key});

//Declare and Initialize Controller
  final apiManager = Get.put(ApiManagerController());

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        //Call firebase push notification events
        //NotificationListenerProvider().registerNotification();
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                apiManager.sendPushNotification().then((value) {
                  if (value == 'Sucess') {
                    //DialogHelper.okcancelDialog(true, 'Message Sent');
                  } else {
                    DialogHelper.okcancelDialog(true, value);
                  }
                });
              },
              child: const Text('Send Notification'),
            )
          ],
        ),
      ),
    );
  }
}
