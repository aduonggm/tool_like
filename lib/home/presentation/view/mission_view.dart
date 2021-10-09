import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/mission_controller.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class MissionView extends GetView<MissionController> {
  @override
  Widget build(BuildContext context) {
    var mission = Get.arguments as MissionType;
    controller.loadMission(mission);
    return Scaffold(
      appBar: AppBar(
        title: Text(mission.getTitle),
      ),
      body: Obx(() => controller.loadError.value
          ? Center(child: Text('Không thể tải nhiệm vụ'))
          : controller.missionList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, index) => ListTile(
                    leading: Text((index + 1).toString()),
                    title: Text(controller.missionList[index].idPost),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(onPressed: () {}, child: Text('Làm')),
                        TextButton(onPressed: () {}, child: Text('Nhận tiền')),
                      ],
                    ),
                  ),
                  itemCount: controller.missionList.length,
                )),
    );
  }
}
