import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/home_controller.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/kiem_xu_home.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/setting_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/tang_tuong_tac_view.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';

class HomeView extends GetView<HomeController> {
  late final List<Widget> views = <Widget>[
    KiemXuView(key: PageStorageKey('kiem xy')),
    TangTuongTacView(key: PageStorageKey('kiem xys')),
    SettingView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => views[controller.indexPage.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.indexPage.value,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Kiếm Xu"),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Tăng Like"),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Cài đặt"),
            ],
            onTap: (value) => controller.indexPage.value = value,
          )),
    );
  }
}
