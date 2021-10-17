import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/kiem_xu_home.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';

class TangTuongTacView extends KiemXuView {
  TangTuongTacView({Key? key}):super(key: key);
  @override
  buildClickAction(MissionType missionType) {
    Get.toNamed("${Get.currentRoute}${Routes.TANGLIKEVIEW}", arguments: {
      "link": '${Constants.baseUrl}${missionType.getLinkTangLike}'
    });
  }

  @override
  String buildNameItem(MissionType missionType) => 'Tăng ${missionType.getName.replaceAll(' chéo', '').toLowerCase()}';

  @override
  String get buildTitle => 'Tăng tương tác';
}
