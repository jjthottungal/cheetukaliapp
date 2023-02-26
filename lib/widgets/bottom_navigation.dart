import 'package:cheetukaliapp/controllers/cheetukalilist_controller.dart';
import 'package:cheetukaliapp/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({super.key});

  final kaliListController = Get.find<CheetuKaliController>();

  @override
  Widget build(BuildContext context) {
    return GetX<CheetuKaliController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(-2, -2), // Shadow position
              ),
            ],
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            currentIndex: controller.selectedIndexNotifier.value,
            onTap: (newIndex) {
              controller.selectedIndexNotifier.value = newIndex;
            },
            items: (Urls.isAdminRole)
                ? const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.bar_chart), label: 'Player'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.pie_chart), label: 'Family'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.notifications), label: 'Message')
                  ]
                : const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.bar_chart), label: 'Player'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.pie_chart), label: 'Family'),
                  ],
          ),
        );
      },
    );
  }
}
