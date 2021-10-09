import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/model/user_model.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class SignInController extends BaseTabController {
  final IDataManager dataManager;

  SignInController(this.dataManager) : super(dataManager);
  RxBool visibilityPassword = false.obs;
  RxString data = "dđ".obs;
  InAppWebViewController? inAppWebViewController;
  String userName = "";
  String password = "";

  @override
  void onInit() {
    super.onInit();
  }

  void singIn() async {
    // if (password.isEmpty || userName.isEmpty) return;
    // CookieManager.instance().deleteAllCookies();
    // showAwaitDialog();
    // var cookie = await dataManager.signIn('duongnv', 'airoiCungkhac');
    // dismissOverlay();
    // if (cookie.isEmpty) {
    //   toast('Đăng nhập lỗi');
    //   return;
    // }

    Get.offAndToNamed(Routes.HOME);
  }

  switchPasswordVisibility() {
    visibilityPassword.value = !visibilityPassword.value;
  }

  errorSignIn() {
    dismissOverlay();
    toast('log in error');
  }

  void signInDone(String? result) {
    if (result == null || result.isEmpty) {
      errorSignIn();
      return;
    }
    dismissOverlay();
    UserModel userModel = UserModel(userName, password);
    userModel.accessToken = result;
    toast(' log in success');
  }
}
