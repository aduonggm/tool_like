import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController(Get.find()));
  }
}
