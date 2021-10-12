import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/home_controller.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';


abstract class BuildContent {
  String get buildTitle;

  String buildNameItem(MissionType missionType);

  buildClickAction(MissionType missionType);
}

class KiemXuView extends GetView<HomeController> implements BuildContent {
  const KiemXuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text(buildTitle)),
        Expanded(
          child: overScrollView(
            child: ListView.builder(
              itemBuilder: (context, index) => _item(missionType: MissionType.values[index]),
              itemCount: MissionType.values.length,
            ),
          ),
        )
      ],
    );
  }

  _item({required MissionType missionType}) {
    return ListTile(
      onTap: () => buildClickAction(missionType),
      title: Text(buildNameItem(missionType)),
      leading: Image.asset('assets/icons/${missionType.getImageName}.png', width: 24),
      trailing: Image.asset('assets/icons/${missionType.getTrailingImage}.png', width: 24),
    );
  }

  @override
  buildClickAction(MissionType missionType) {
    Get.toNamed("${Get.currentRoute}${Routes.MISSION}", arguments: missionType);
  }

  @override
  String buildNameItem(MissionType missionType) {
    return missionType.getName;
  }

  @override
  String get buildTitle => 'Kiếm xu';
}
