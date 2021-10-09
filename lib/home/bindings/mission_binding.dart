import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/mission_controller.dart';

class MissionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MissionController(Get.find()));
  }
}
