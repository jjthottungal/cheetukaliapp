import 'dart:io';
// ignore: unused_import
import 'dart:ui';
import 'package:cheetukaliapp/screens/screen_addevent.dart';
import 'package:cheetukaliapp/screens/screen_addwinner.dart';
import 'package:cheetukaliapp/screens/screen_cheetukalidtls.dart';
import 'package:cheetukaliapp/screens/screen_home.dart';
//import 'package:cheetukaliapp/screens/screen_logintest.dart';
import 'package:cheetukaliapp/screens/screen_login.dart';
import 'package:cheetukaliapp/screens/screen_splash.dart';
//import 'package:cheetukaliapp/screens/test.dart';
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

void main() {
  //Just resolve http certificate issues
  HttpOverrides.global = MyHttpOverrides();

  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.clear
  @override
  Widget build(BuildContext context) {
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
