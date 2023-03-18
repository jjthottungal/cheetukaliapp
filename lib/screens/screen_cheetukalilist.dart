import 'package:cheetukaliapp/controllers/apimanger_controller.dart';
import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/models/cheetunkalilistmonthlymodel.dart';
import 'package:cheetukaliapp/services/firebase_message_listener.dart';
//import 'package:cheetukaliapp/services/onesignal_message_notification.dart';
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cheetukaliapp/utils/dialog_helper.dart';
import 'package:cheetukaliapp/widgets/custom_widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';

enum Actions { delete }

// ignore: must_be_immutable
class ScreenCheetukaliList extends StatelessWidget {
  ScreenCheetukaliList({super.key});

//Declare and Initialize Controller
  final kaliListController = Get.find<CheetuKaliController>();

  final apiManager = Get.put(ApiManagerController());

  late int _gWgid;
  late String _gTitle;

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        //Call firebase push notification events
        NotificationListenerProvider().registerNotification();
        //OnesignalNotificationListenerProvider().onesignalRegisterNotification();
      },
      child: GetX<CheetuKaliController>(
        builder: (controller) {
          if (!controller.isListLoading.value || controller.needRefresh.value) {
            controller.needRefresh.value = false;
            controller.deleteDrawer.value = false;
            return CustomScrollView(
              slivers: buildNews(news: controller.cheetukalilistmonthly),
            );
          } else {
            return CustomWidgets.customProgressIndicator();
          }
        },
      ),
    );
  }

  //Create multiple sliver section widgets
  List<Widget> buildNews({required List<CheetukaliListMonthlyModel> news}) =>
      news
          .map((newsSection) => eventsSectionWidget(
              section: newsSection, news: newsSection.events))
          .toList();

  //Creating Events List for  each call
  Widget eventsSectionWidget(
      {required CheetukaliListMonthlyModel section,
      required List<Event> news}) {
    //const double padding = 0;

    return
        /* SliverPadding(
      padding: const EdgeInsets.all(padding).copyWith(top: 0),
      sliver:  */
        MultiSliver(
      //pushPinnedChildren: true,
      children: [
        SliverStickyHeader.builder(
          builder: (context, state) {
            return Card(
              margin: const EdgeInsets.all(0),
              //color: Colors.white,
              elevation:
                  (state.isPinned && state.scrollPercentage <= 0.0) ? 14 : 0,
              shadowColor: const Color(0x802196F3),
              // shape: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(15.0),
              // side: BorderSide(width: 1, color: Colors.grey)),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 0, bottom: 0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 06),
                decoration: BoxDecoration(
                  // color: Colors.blue.shade100,
                  //(state.isPinned ? Colors.blue.shade100 : Colors.white)
                  //  .withOpacity(1.0 - state.scrollPercentage),
                  border: (state.isPinned && state.scrollPercentage <= 0.0)
                      ? const Border(
                          bottom: BorderSide(width: 0, color: Colors.white),
                          //top: BorderSide(width: 0, color: Colors.white),
                        )
                      : Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.grey[300]!),
                          top: BorderSide(width: 1, color: Colors.grey[300]!),
                        ),
                ),
                child: Text(
                  section.monthly,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            );
          },
          sliver: SliverClip(
            child: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slidable(
                        enabled: !kaliListController.deleteDrawer.value &&
                                Urls.isAdminRole
                            ? true
                            : false,
                        endActionPane: ActionPane(
                          motion: const BehindMotion(),
                          extentRatio: 0.25,
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                _onDismissed(news[index].wgId, section.monthly,
                                    Actions.delete);
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: Builder(builder: (context) {
                          //Restrict only one DEL drawer in the first list
                          if (!kaliListController.deleteDrawer.value) {
                            kaliListController.deleteDrawer.value = true;
                          }
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.orange,
                              child: CircleAvatar(
                                radius: 25,
                                //child: Text('JJ'),
                                backgroundImage: AssetImage(
                                    'assets/images/${news[index].host}.jpg'),
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
                                  child: Text(news[index].host,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                // ignore: avoid_unnecessary_containers
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    news[index].dateInText,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Text(news[index].result,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis)),
                                ),
                              ],
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward,
                              color: Colors.blue,
                            ),
                            onTap: () async {
                              final slidable = Slidable.of(context);
                              final isClosed = slidable?.actionPaneType.value ==
                                  ActionPaneType.none;
                              if (!isClosed) {
                                slidable!.close();
                              }

                              //Retrieve data per Event
                              //kaliListController.GetCheetukaliDtlsPerEvent(
                              //   controller.cheetukalilist[index].wgId);
                              await Get.toNamed('/detail', arguments: [
                                news[index].wgId,
                                news[index].host,
                                index
                              ]);

                              //In case Kalilist has changed
                              if (kaliListController.eventChanged.value) {
                                //Event added or removed
                                kaliListController.GetCheetukaliListMonthly();
                                kaliListController.GetPlayerChart();
                                kaliListController.GetFamilyChart();
                                kaliListController.eventChanged.value = false;
                              }
                              //In case Details has changed
                              if (kaliListController.winnerChanged.value) {
                                //Winner added or removed
                                kaliListController.GetCheetukaliDtlsAll();
                                kaliListController.winnerChanged.value = false;
                              }
                            },
                          );
                        }), //  },
                      ),
                      const Divider(height: 2),
                    ],
                  );
                },
                childCount: news.length,
              ),
            ),
          ),
        ),
      ],
    );
    //);
  }

  void _onDismissed(int wgid, String title, Actions action) async {
    switch (action) {
      case Actions.delete:
        _gWgid = wgid;
        _gTitle = title;

        DialogHelper.okcancelDialog(false, 'Do you want to delete?', 'Delete',
            _dialogOkButtonPressedforDelEvent);
        break;
    }
  }

//Callback fucntion for OK button pressed
  void _dialogOkButtonPressedforDelEvent() async {
    //
    apiManager.delEvent(_gWgid).then(
      (value) {
        if (value == 'Deleted') {
          //Sucessfully Created
          //Called below funtion to remove list item locally and change the obersrvable count
          //this refresh listview builder using Get
          kaliListController.GetCheetukaliListMonthlyUpdated(_gWgid, _gTitle);
          //kaliListController.GetCheetukaliListMonthly();
          kaliListController.GetPlayerChart();
          kaliListController.GetFamilyChart();

          kaliListController.GetCheetukaliDtlsAll();
        } else {
          //Alerts
          DialogHelper.okcancelDialog(true, value);
        }
      },
    );
  }
}
