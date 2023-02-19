import 'package:flutter/material.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';
import 'package:get/get.dart';
import 'package:status_bar_control/status_bar_control.dart';

class ScreenSplash extends StatelessWidget {
  const ScreenSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        //initialization();
        //Hide top status bar
        StatusBarControl.setHidden(true, animation: StatusBarAnimation.SLIDE);

        Future.delayed(const Duration(seconds: 2)).then((value) {
          Get.offNamed('/login');
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(image: AssetImage("assets/images/SplashLogo.jpg")),
              SizedBox(height: 50),
              Text(
                'Weekly Gathering',
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
