import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/models/cheetukalifamsummmodel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenFamChart extends StatelessWidget {
  ScreenFamChart({super.key});

  final kaliListController = Get.find<CheetuKaliController>();

  @override
  Widget build(BuildContext context) {
    return GetX<CheetuKaliController>(
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
                        'Family Chart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 25),
                      Expanded(
                        child: SfCircularChart(
                          legend: Legend(
                              isVisible: true,
                              // Border color and border width of legend
                              borderColor: Colors.black,
                              borderWidth: 2),
                          series: <CircularSeries>[
                            DoughnutSeries<CheetukaliFamSummModel, String>(
                                dataSource: controller.cheetukaliFamSumm,
                                xValueMapper:
                                    (CheetukaliFamSummModel summ, _) =>
                                        summ.familyName,
                                yValueMapper:
                                    (CheetukaliFamSummModel summ, _) =>
                                        summ.amount.toInt(),
                                dataLabelSettings: const DataLabelSettings(
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12)))
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
