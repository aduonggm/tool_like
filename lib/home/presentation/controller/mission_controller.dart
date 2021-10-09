import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class MissionController extends BaseTabController {
  final IDataManager iDataManager;
  RxBool loadError = false.obs;

  MissionController(this.iDataManager) : super(iDataManager);

  RxList<MissionModel> missionList = <MissionModel>[].obs;

  loadMission(MissionType missionType) async {
    var result = await dataManager.loadListMission(missionType);
    if (result == null) {
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
}
