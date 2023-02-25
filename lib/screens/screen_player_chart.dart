import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/models/cheetukalisummmodel.dart';
import 'package:cheetukaliapp/services/firebase_message_listener.dart';
import 'package:cheetukaliapp/utils/statefulwrapper.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenPlayerChart extends StatelessWidget {
  ScreenPlayerChart({super.key});

  final kaliListController = Get.find<CheetuKaliController>();

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        //Call firebase push notification events
        NotificationListenerProvider().registerNotification();
      },
      child: GetX<CheetuKaliController>(
        builder: (controller) {
          if (!controller.isListLoading.value) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Material(
                  color: Colors.white,
                  elevation: 14.0,
                  shadowColor: const Color(0x802196F3),
                  borderRadius: BorderRadius.circular(24.0),
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    padding: const EdgeInsets.only(right: 10, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Player Chart',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: SfCartesianChart(
                              primaryXAxis: CategoryAxis(
                                isInversed: true,
                              ),
                              primaryYAxis: NumericAxis(),

                              // Enable tooltip
                              tooltipBehavior: TooltipBehavior(enable: true),
                              series: <ChartSeries>[
                                BarSeries<CheetukaliSummModel, String>(
                                    color:
                                        const Color.fromRGBO(202, 159, 32, 1),
                                    dataSource: controller.cheetukaliSumm,
                                    xValueMapper:
                                        (CheetukaliSummModel summ, _) =>
                                            summ.playerName,
                                    yValueMapper:
                                        (CheetukaliSummModel summ, _) =>
                                            summ.amount.toInt(),
                                    name: 'Cards Play',
                                    // Enable data label
                                    borderRadius: const BorderRadius.horizontal(
                                        right: Radius.circular(10)),
                                    dataLabelSettings: const DataLabelSettings(
                                        isVisible: true,
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)))
                              ]),
                        ),
                      ],
                    ),
                  )),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
