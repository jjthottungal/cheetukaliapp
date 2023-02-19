import 'dart:async';
import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/models/loginmodel.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:cheetukaliapp/utils/palette.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:status_bar_control/status_bar_control.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final formkey = GlobalKey<FormState>();
  late String _pin;
  final _pinController = TextEditingController();
  late LoginModel loginModel;
  //Declare and Initialize Controller
  final apiManager = Get.put(ApiManagerController());

  //Check Internet connection
  late StreamSubscription subscription;
  bool isDeviceConnected = false;

  @override
  void initState() {
    super.initState();
    //Hide top status bar
    StatusBarControl.setHidden(true, animation: StatusBarAnimation.SLIDE);

    loginModel = LoginModel(userId: 'Guest', password: '');
    //Check Interconnectvity
    _getConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    //Show stausbar
    StatusBarControl.setHidden(false);

    if (!_pinController.isBlank!) {
      _pinController.dispose();
    }
    subscription.cancel();
  }

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
            apiManager.isInternetAlertSet.value = true;
          } else {
            if (apiManager.isInternetAlertSet.value) {
              apiManager.isInternetAlertSet.value = false;
              //Close the internet check dialog box
              Get.back();
            }
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        /*
        appBar: AppBar(
          //elevation: 10,
          title: const Text('Weekly Gathering'),
          //centerTitle: true,
        ),
        */
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: EdgeInsets.only(top: screenHeight * 0.04),
                color: Colors.black,
                child: Container(
                  height: 300,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Background.jpg"),
                          fit: BoxFit.fill)),
                  child: Container(
                    padding: const EdgeInsets.only(top: 55, left: 20),
                    //color: const Color(0xFF3b5999).withOpacity(.75),
                    //color: Color.fromARGB(255, 183, 165, 61).withOpacity(.6),
                    color: Colors.black12.withOpacity(.1),
                    //color: Colors.green.shade100.withOpacity(.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                              text: "Welcome to ",
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 2,
                                color: Colors.yellow[700],
                                //color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: 'WG',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[700],
                                  ),
                                )
                              ]),
                        ),
                        const SizedBox(
                          height: 9,
                        ),
                        const Text(
                          'Sign-in to Continue',
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            buildBottomHalfContainer(true),
            Positioned(
              top: 240,
              child: Container(
                height: 200,
                padding: const EdgeInsets.all(20),
                width: Get.size.width - 120,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5),
                    ]),
                child: Column(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                        child: const Text(
                      'SIGN-IN',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    )),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      height: 1,
                      width: 59,
                      color: Colors.orange,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 85,
                      //color: Colors.black12,
                      padding: const EdgeInsets.only(left: 15, right: 15),
                      child: Form(
                        key: formkey,
                        child: TextFormField(
                          controller: _pinController,
                          //readOnly: true,
                          autofocus: false,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            //prefixIconColor: Colors.blue,
                            counterText: '',
                            contentPadding: const EdgeInsets.only(
                                top: 20, left: 15, bottom: 20, right: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            labelText: 'Pin Number',
                            hintText: 'Enter pin',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            //floatingLabelAlignment: FloatingLabelAlignment.center,
                            labelStyle: const TextStyle(
                                fontSize: 17, color: Colors.blue),
                          ),
                          validator: ((value) {
                            if (value == null || value == '') {
                              return 'Enter pin';
                            } else if (value.length < 4) {
                              return 'Pin must be 4 digit ';
                            }
                            return null;
                          }),
                          onSaved: (newValue) {
                            setState(() {
                              _pin = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildBottomHalfContainer(false),
            Flexible(
                flex: 15,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.copyright_rounded,
                        size: 20,
                      ),
                      Text(
                        'www.thottungal.net.in',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        )),
      ),
    );
  }

  bool dataValidate() {
    final bool isvalidate = formkey.currentState!.validate();

    if (isvalidate) {
      formkey.currentState!.save();
    }
    return isvalidate;
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return Positioned(
      top: 400,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1))
                      ]),
                  child: IconButton(
                      onPressed: () {
                        //ocusScope.of(context).unfocus();

                        if (dataValidate()) {
                          //Saving routine
                          //Fille the values to the model
                          loginModel.password = _pin;

                          apiManager.login(loginModel).then(
                            (value) {
                              //Clear controls
                              setState(() {
                                _pinController.clear();
                              });

                              if (value == 'Logged') {
                                //Sucessfully Login

                                //DialogHelper.okcancelDialog(
                                //    true, 'Login Successfull');

                                Get.offNamed('/home');
                              } else {
                                //Alerts
                                DialogHelper.okcancelDialog(true, value);
                              }
                            },
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )),
                )
              : const Center(),
        ),
      ),
    );
  }
}
