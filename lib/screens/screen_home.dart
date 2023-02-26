import 'dart:async';
import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/screens/screen_cheetukalilist.dart';
import 'package:cheetukaliapp/screens/screen_fam_chart.dart';
import 'package:cheetukaliapp/screens/screen_message.dart';
import 'package:cheetukaliapp/screens/screen_player_chart.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:cheetukaliapp/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';
import 'package:cheetukaliapp/utils/urls.dart';

// ignore: must_be_immutable
class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  //Declare and Initialize Controller
  final kaliListController = Get.put(CheetuKaliController());

  //static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  //Check Internet connection
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  //bool isAlertSet = false;

  final _pages = [
    ScreenCheetukaliList(),
    ScreenPlayerChart(),
    ScreenFamChart()
  ];

  final _pagesAdmin = [
    ScreenCheetukaliList(),
    ScreenPlayerChart(),
    ScreenFamChart(),
    ScreenMessage()
  ];

  void _getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          //&& apiManager.isAlertSet.value == false
          if (!isDeviceConnected) {
            // ignore: use_build_context_synchronously
            //DialogHelper.showInternetBottomModalBox1(context);
            DialogHelper.showInternetBottomModalBox();
            //setState(() => isAlertSet = true);
            kaliListController.isInternetAlertSet.value = true;
          } else {
            if (kaliListController.isInternetAlertSet.value) {
              kaliListController.isInternetAlertSet.value = false;
              //Close the internet check dialog box
              Get.back();
            }
          }
        },
      );

  //Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforlogOut() {
    Urls.isLoggedIn = false; //Set logged out
    Get.offAllNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        _getConnectivity();
      },
      onDelete: () {
        subscription.cancel();
      },
      child: WillPopScope(
        onWillPop: () async {
          DialogHelper.okcancelDialog(false, 'Do you want to exit?', 'Logout',
              _dialogOkButtonPressedforlogOut);
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            //elevation: 10,
            title: const Text(
              'Weekly Gathering',
              style: TextStyle(fontSize: 20),
            ),
            //centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    DialogHelper.okcancelDialog(false, 'Do you want to exit?',
                        'Logout', _dialogOkButtonPressedforlogOut);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          floatingActionButton: GetX<CheetuKaliController>(
            builder: (controller) {
              return Visibility(
                visible: (controller.selectedIndexNotifier.value == 0),
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    await Get.toNamed('/addevent');
                    if (kaliListController.eventChanged.value) {
                      //Event added or removed
                      // kaliListController.GetCheetukaliList();
                      kaliListController.GetCheetukaliListMonthly();
                      kaliListController.eventChanged.value = false;
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Event'),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigation(),
          body: SafeArea(child: GetX<CheetuKaliController>(
            builder: (controller) {
              if (Urls.isAdminRole) {
                return _pagesAdmin[controller.selectedIndexNotifier.value];
              } else {
                return _pages[controller.selectedIndexNotifier.value];
              }
            },
          )),
        ),
      ),
    );
  }
}
