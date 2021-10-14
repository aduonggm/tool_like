import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';

class MissionController extends BaseTabController {
  final IDataManager iDataManager;
  RxInt loadError = 0.obs;
  late MissionType missionType;

  MissionController(this.iDataManager) : super(iDataManager);

  RxList<String> missionTaked = <String>[].obs;
  RxList<String> recievered = <String>[].obs;
  RxList<MissionModel> missionList = <MissionModel>[].obs;

  loadMission(MissionType missionType) async {
    missionTaked.clear();
    recievered.clear();
    missionList.clear();
    this.missionType = missionType;
    var result = await dataManager.loadListMission(missionType);
    print(' result is  $result');

    if (result == null) {
      print(' result is  $result');
      loadError.value = -1;
      return;
    }
    if (result.isEmpty) {
      loadError.value = 1;
      return;
    }
    missionList.addAll(result);
  }

  @override
  void onInit() {
    dataManager.signWithAccessToken();
    super.onInit();
  }

  takeMission(int index) async {
    var idPost = missionList[index].idPost;
    if (!missionTaked.contains(idPost)) {
      missionTaked.add(idPost);
      if (missionList[index].content != null) {
        toast('Nội dung bình luận đã được sao chép vào bộ nhớ tạm!');
        Clipboard.setData(ClipboardData(text: missionList[index].content?.first));
      }
      var link = missionList[index].link;
      if (missionType == MissionType.FollowTT) link = 'https://www.tiktok.com/@${missionList[index].link}?lang=vi-VN';
      var laun = await launch(link);
      toast('luanch response  $laun');
    } else {
      recievered.add(idPost);
      var result = await dataManager.receiverMoney(idPost, missionType);
      toast(result.toString());
    }
  }
}
