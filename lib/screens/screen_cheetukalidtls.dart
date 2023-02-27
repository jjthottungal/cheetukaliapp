import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/models/delwinnermodel.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:cheetukaliapp/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';

enum Actions { delete }

// ignore: must_be_immutable
class ScreenCheetukaliDtls extends StatelessWidget {
  ScreenCheetukaliDtls({super.key});

  var arguments = Get.arguments;
  final kaliListController = Get.find<CheetuKaliController>();
  //Declare and Initialize Controller
  final apiManager = Get.put(ApiManagerController());
  late DelWinnerModel delWinnerModel;

  //Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforlogOut() {
    Get.offAllNamed('/login');
  }

  void goBack() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        delWinnerModel = DelWinnerModel(wgId: arguments[0], playerId: 0);
        kaliListController.GetCheetukaliDtlsPerEvent(arguments[0]);
      },
      child: WillPopScope(
        onWillPop: () async {
          goBack();
          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Weekly Gathering'),
            //centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  goBack();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.until((route) => Get.currentRoute == '/home');
                  },
                  icon: const Icon(Icons.home)),
              IconButton(
                  onPressed: () {
                    DialogHelper.okcancelDialog(false, 'Do you want to exit?',
                        'Logout', _dialogOkButtonPressedforlogOut);
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          floatingActionButton: Visibility(
            visible: (arguments[0] == kaliListController.lastEventId.value &&
                Urls.isAdminRole),
            child: FloatingActionButton.extended(
              onPressed: () async {
                await Get.toNamed('/addwinner', arguments: [arguments[0]]);
                if (kaliListController.winnerChanged.value) {
                  //Winner added or removed
                  kaliListController.GetCheetukaliDtlsAll().then((value) {
                    if (value == 200) {
                      kaliListController.GetCheetukaliDtlsPerEvent(
                          arguments[0]);
                      kaliListController.cheetukaliDtliperEventCount.value =
                          kaliListController.cheetukalidtlsperevent.length;
                    }
                  });

                  kaliListController.winnerChanged.value = false;
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Winner'),
            ),
          ),
          body: SafeArea(
            // ignore: avoid_unnecessary_containers
            child: Container(
              //color: Colors.white,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: arguments[0].toString(),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 20, left: 10, bottom: 20, right: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Event ID',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            const TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: arguments[1],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            top: 20, left: 10, bottom: 20, right: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: 'Host Name',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle:
                            const TextStyle(fontSize: 17, color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                      width: Get.width,
                      padding: const EdgeInsets.only(left: 25),
                      child: const Text(
                        'Winner Details',
                        style: TextStyle(fontSize: 15, color: Colors.blue),
                      )),
                  const Divider(thickness: 4),
                  Expanded(
                    //child: Center(child: Text('Listview Details')),
                    child: GetX<CheetuKaliController>(
                      builder: (controller) {
                        if (!controller.isListLoading.value) {
                          return SlidableAutoCloseBehavior(
                            closeWhenOpened: true,
                            child: ListView.separated(
                              //padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                              itemCount:
                                  controller.cheetukaliDtliperEventCount.value,
                              itemBuilder: (ctx, index) {
                                return Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  shadowColor: const Color(0x802196F3),
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Slidable(
                                    enabled: arguments[0] ==
                                                controller.lastEventId.value &&
                                            Urls.isAdminRole
                                        ? true
                                        : false,
                                    endActionPane: ActionPane(
                                      motion: const BehindMotion(),
                                      extentRatio: 0.25,
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            _onDismissed(index, Actions.delete);
                                          },
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(24),
                                              bottomRight: Radius.circular(24)),
                                        ),
                                      ],
                                    ),
                                    child: Builder(builder: (context) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          radius: 25,
                                          backgroundColor: Colors.orange,
                                          child: CircleAvatar(
                                            radius: 24,
                                            //child: Text(controller
                                            //    .cheetukalidtlsperevent[index].abr!),
                                            backgroundImage: AssetImage(
                                                'assets/images/${controller.cheetukalidtlsperevent[index].playerName}.jpg'),
                                          ),
                                        ),
                                        title: Row(
                                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            // ignore: avoid_unnecessary_containers
                                            Container(
                                              //color: Colors.blue,
                                              width: 150,
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  controller
                                                      .cheetukalidtlsperevent[
                                                          index]
                                                      .playerName,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 6),
                                                  child: Text(
                                                      controller
                                                          .cheetukalidtlsperevent[
                                                              index]
                                                          .amount
                                                          .toInt()
                                                          .toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis)),
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          final slidable = Slidable.of(context);
                                          final isClosed =
                                              slidable?.actionPaneType.value ==
                                                  ActionPaneType.none;
                                          if (!isClosed) {
                                            slidable!.close();
                                          }
                                        },
                                      );
                                    }),
                                  ),
                                );
                              },
                              separatorBuilder: (ctx, index) {
                                return const Divider(height: 1);
                              },
                            ),
                          );
                        } else {
                          return CustomWidgets.customProgressIndicator();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDismissed(int index, Actions action) async {
    switch (action) {
      case Actions.delete:
        // _gIndex = index;
        //Fill PlayerID ising index
        delWinnerModel.playerId =
            kaliListController.cheetukalidtlsperevent[index].playerId;
        DialogHelper.okcancelDialog(false, 'Do you want to delete?', 'Delete',
            _dialogOkButtonPressedforDelEvent);
        break;
    }
  }

  //Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforDelEvent() async {
    //
    apiManager.delWinner(delWinnerModel).then(
      (value) {
        if (value == 'Deleted') {
          //Sucessfully Created
          //Called below funtion to remove list item locally and change the obersrvable count
          //this refresh listview builder using GetX
          kaliListController.GetCheetukaliDtlsAll().then((value) {
            if (value == 200) {
              kaliListController.GetCheetukaliDtlsPerEvent(arguments[0]);
              kaliListController.cheetukaliDtliperEventCount.value =
                  kaliListController.cheetukalidtlsperevent.length;

              kaliListController.eventChanged.value = true;
            }
          });
        } else {
          //Alerts
          DialogHelper.okcancelDialog(true, value);
        }
      },
    );
  }
}
