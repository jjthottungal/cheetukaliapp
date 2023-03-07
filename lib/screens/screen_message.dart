// ignore_for_file: avoid_print
import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/services/aes_encryption.dart';
//import 'package:cheetukaliapp/services/local_notifications.dart';
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
                //LocalNotificationService.showLocalNotification();

                apiManager.sendPushNotification().then((value) {
                  if (value == 'Sucess') {
                    //DialogHelper.okcancelDialog(true, 'Message Sent');
                  } else {
                    DialogHelper.okcancelDialog(true, value);
                  }
                });
              },
              child: const Text('Send Notification'),
            ),
            const SizedBox(
              height: 50,
            )
            /*
            ,
            ElevatedButton(
              onPressed: () {
                //LocalNotificationService.showLocalNotification();
                final encrypted = AesDecryption.encryp('Jecko Johny');
                print(encrypted);
                final nodemsg =
                    'Pthf9e7sNeUvBpROfRtKRmcYSNB1kfEBIiQWyLp7U7Tj0N+YLYEsEWKkByHq8VgFuuEU1OjEmCvi0jcm744WMDY4Aimh1mQ89bIm8uAnfCoipOGNpNo/l4yvzKm6hn37hVQjE1Lg6GDWWu+prA42QrFJHpZud2SasQrGpXQkktaiOeC1jsvtSUAwDEeLxIKxGCVg0IphGwFMVPRGy2an64oY6gX3XgQYpnXinlFkEHYh/m91WenEzdtCyoOIw7ILt/iYa6jm6Czv3EVnnJAf+lrW0aGk5CMBNdFDDIVqTr66lhYPkrsTQeaEDJ6g7Z81exW0PYjrhBl2p0s7xj2Lt9aP933XzHr/OrmvsNloazamdWzGxpXm+gy8Uqgg01xEniGIfRovzMtfoV7jKEjiUWSEvRZSx3ylDi8IFDGtLBj/37qjJ2981/cNnNAfo1MVww8FVmea7a8BG9uu0Ou8jC0yEKoggKiToOXHyztbCMlGbxTOcK9+M0+1/nTEuzOdlOLWVty3v0FwIbBPlY+2bIPt/6lUiYTDsfTet8D7N4I=';
                final decrypted = AesDecryption.decryp(nodemsg);
                print(decrypted);
              },
              child: const Text('Encryption'),
            )
            */
          ],
        ),
      ),
    );
  }
}
