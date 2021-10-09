import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/home_controller.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/kiem_xu_home.dart';

class HomeView extends GetView<HomeController> {
  final views = <Widget>[KiemXuView(), KiemXuView(), KiemXuView(), KiemXuView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => views[controller.indexPage.value])),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.indexPage.value,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Kiếm Xu"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            ],
            onTap: (value) => controller.indexPage.value = value,
          )),
    );
  }
}
