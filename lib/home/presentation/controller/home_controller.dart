import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomeController extends BaseTabController {
  final IDataManager dataManager;
  RxInt indexPage = 0.obs;

  HomeController(this.dataManager) : super(dataManager);

  @override
  void onInit() async {
    super.onInit();
    FirebaseCrashlytics.instance.crash();

  }

  @override
  void onReady() {
    super.onReady();
    checkVersion();
  }

  signout() {
    dataManager.signout();
    Get.offAllNamed(Routes.SIGN_IN);
  }
}
