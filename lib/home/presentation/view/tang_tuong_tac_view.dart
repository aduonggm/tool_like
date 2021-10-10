import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/kiem_xu_home.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class TangTuongTacView extends KiemXuView {
  @override
  buildClickAction(MissionType missionType) {
    Get.toNamed("${Get.currentRoute}${Routes.WEBVIEW}", arguments: {
      "link": 'https://tuongtaccheo.com/${missionType.getLinkTangLike}',
      'cookie': 'PHPSESSID=kp79qqilt8iq0hl4bf48a4sm40'
    });
  }

  @override
  String buildNameItem(MissionType missionType) => 'Tăng ${missionType.getName.replaceAll(' chéo', '').toLowerCase()}';

  @override
  String get buildTitle => 'Tăng tương tác';
}
