import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DialogHelper {
//show loading
  static void showLoading([String? message]) {
    Get.dialog(
        Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.symmetric(horizontal: 155),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              const SpinKitCircle(
                color: Colors.white,
                size: 40.0,
              ),
              const SizedBox(height: 8),
              Text(
                message ?? 'Loading...',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        barrierColor: Colors.black12);
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  //show loading
  static void okcancelDialog(bool isAlertDIalog, String middleText,
      [String? titleText, VoidCallback? onClickOkButton]) {
    Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            //backgroundColor: Colors.black,
            //insetPadding: const EdgeInsets.symmetric(horizontal: 165),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            // ignore: sized_box_for_whitespace
            child: Container(
              height: isAlertDIalog ? 150 : 160,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 25, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          isAlertDIalog ? 'Alert' : titleText ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                        isAlertDIalog
                            ? Container()
                            : CircleAvatar(
                                radius: 18,
                                child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(left: 25),
                    child:
                        Text(middleText, style: const TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: Container(
                      //height: 50,
                      color: Colors.blue,
                      child: SizedBox.expand(
                          child: TextButton(
                              onPressed: () {
                                if (isAlertDIalog) {
                                  Get.back();
                                } else {
                                  if (onClickOkButton != null) {
                                    Get.back();
                                    onClickOkButton();
                                  }
                                }
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ))),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        barrierColor: Colors.black12,
        barrierDismissible: false);
  }

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required String title,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        barrierColor: Colors.black12,
        context: context,
        builder: (context) => CupertinoActionSheet(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20, color: Colors.blue),
          ),
          actions: [child],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: const Text('Done'),
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: const TextStyle(fontSize: 24)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

//Internet connection issues
  static void showInternetBottomModalBox() {
    Get.bottomSheet(
      WillPopScope(
        onWillPop: () async => false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'No Internet',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Internet.png"),
              )),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Please check your network and try again',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      enableDrag: false,
      isDismissible: false,
      barrierColor: Colors.black12,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      //constraints: BoxConstraints(maxWidth: Get.width - 30),
    );
  }

/*   static void showInternetBottomModalBox1(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      enableDrag: false,
      isDismissible: false,
      barrierColor: Colors.black12,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      constraints: BoxConstraints(maxWidth: Get.width - 30),
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'No Internet',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
              ),
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/Internet.png"),
              )),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'Please check your network and try again',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
              ),
            ),
            const SizedBox(height: 25),
          ],
        );
      },
    );
  } */
}
