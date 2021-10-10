import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/mission_controller.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';

class MissionView extends GetView<MissionController> {
  @override
  Widget build(BuildContext context) {
    var mission = Get.arguments as MissionType;
    controller.loadMission(mission);
    return Scaffold(
      appBar: AppBar(
        title: Text(mission.getName),
      ),
      body: Obx(() => controller.loadError.value
          ? Center(child: Text('Không thể tải nhiệm vụ'))
          : controller.missionList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  child: overScrollView(
                    child: ListView.builder(
                      itemBuilder: (context, index) => buildItem(index, mission),
                      itemCount: controller.missionList.length,
                    ),
                  ),
                  onRefresh: () async {
                    await controller.loadMission(mission);
                  },
                )),
    );
  }

  buildItem(int index, MissionType mission) {
    var idPost = controller.missionList[index].idPost;
    return Obx(() => ListTile(
          leading: Text((index + 1).toString()),
          title: Text(
            controller.missionList[index].idPost,
            style: TextStyle(color: controller.recievered.contains(idPost) ? Colors.green : null),
            maxLines: 1,
          ),
          trailing: TextButton(
            onPressed: () => controller.takeMission(index),
            child: Text(controller.missionTaked.contains(idPost) ? 'Nhận tiền' : 'Làm'),
          ),
        ));
  }
}
