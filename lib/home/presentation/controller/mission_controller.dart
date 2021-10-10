import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';
import 'package:url_launcher/url_launcher.dart';

class MissionController extends BaseTabController {
  final IDataManager iDataManager;
  RxBool loadError = false.obs;
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
    if (result == null || result.isEmpty) {
      print(' result is  $result');
      loadError.value = true;
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
      if (missionType == MissionType.CommentTT || missionType == MissionType.CommentFB)
        Clipboard.setData(ClipboardData(text: missionList[index].content?.first));
      var link = missionList[index].link;
      if (missionType == MissionType.FollowTT) link = 'https://www.tiktok.com/@${missionList[index].link}?lang=vi-VN';
      var laun = await launch(link);
      toast('luanch response  $laun');
    } else {
      recievered.add(idPost);
      var result = await dataManager.recieverMoney(idPost, missionType);

      toast(result.toString());
    }
  }
}
