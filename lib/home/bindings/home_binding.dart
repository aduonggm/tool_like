import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(Get.find()));
  }
}
