import 'dart:io';
// ignore: unused_import
import 'dart:ui';
import 'package:cheetukaliapp/controllers/utils_controller.dart';
import 'package:cheetukaliapp/screens/screen_addevent.dart';
import 'package:cheetukaliapp/screens/screen_addwinner.dart';
import 'package:cheetukaliapp/screens/screen_cheetukalidtls.dart';
import 'package:cheetukaliapp/screens/screen_home.dart';
import 'package:cheetukaliapp/screens/screen_login.dart';
import 'package:cheetukaliapp/screens/screen_splash.dart';
import 'package:cheetukaliapp/services/local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

//Define background message handler
Future<void> backgroundHandler(RemoteMessage message) async {
  //print(" This is message from background");
  //print(message.data.toString());
  //print(message.notification!.title);
  //print(message.notification!.body);
}

void main() async {
  //Just resolve http certificate issues
  HttpOverrides.global = MyHttpOverrides();

  // ignore: unused_local_variable
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize firebase messaging service
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  LocalNotificationService.initilize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  //Declare and Initialize Controller
  final utilsController = Get.put(UtilsController());

  Future<void> getDeviceToken() async {
    final FirebaseMessaging fcm = FirebaseMessaging.instance;
    var token = await fcm.getToken();
    utilsController.deviceToken.value = token.toString();
    //print(token);
  }

  @override
  Widget build(BuildContext context) {
    getDeviceToken(); //Receive device token
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weekly Gathering',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                fontSize: 20,
              ),
            ),
        appBarTheme: ThemeData.light().appBarTheme.copyWith(
            elevation: 12,
            centerTitle: true,
            titleTextStyle: const TextStyle(fontSize: 22)),
        primarySwatch: Colors.blue,
      ),
      getPages: [
        /*GetPage(
              name: '/logintest',
              page: () => const ScreenLoginTest(),
              transition: Transition.noTransition), */
        GetPage(
            name: '/splash',
            page: () => const ScreenSplash(),
            transition: Transition.noTransition),
        GetPage(
            name: '/login',
            page: () => const ScreenLogin(),
            transition: Transition.noTransition),
        GetPage(
            name: '/home',
            page: () => ScreenHome(),
            transition: Transition.noTransition),
        /*      GetPage(
              name: '/test',
              page: () => const TestScreen(),
              transition: Transition.noTransition),
          */
        GetPage(
            name: '/detail',
            page: () => ScreenCheetukaliDtls(),
            transition: Transition.leftToRight),
        GetPage(
            name: '/addevent',
            page: () => const ScreenAddEvent(),
            transition: Transition.leftToRight),
        GetPage(
            name: '/addwinner',
            page: () => const ScreenAddWinner(),
            transition: Transition.leftToRight)
      ],
      initialRoute: '/splash',
      //home: const ScreenHome(),
      //The below code for making consistent font size regardless mobile font size
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(0.9, 1.2);
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
            child: child!);
      },
    );
  }
}
