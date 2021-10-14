import 'dart:convert';
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
    print(' controller is null   ${inAppWebViewController == null}');
    if (userName.isEmpty || password.isEmpty) return;
    CookieManager.instance().deleteAllCookies();
    var postData = Uint8List.fromList(utf8.encode("username=$userName&password=$password&submit=ĐĂNG NHẬP"));
    inAppWebViewController?.postUrl(url: Uri.parse("https://tuongtaccheo.com/login.php"), postData: postData);
    showAwaitDialog();
  }

  saveData(String accessToken) async {
    dismissOverlay();
    if (accessToken.isEmpty) {
      toast('Vui lòng kiểm tra lại kết nối mạng');
      return;
    }
    UserModel userModel = UserModel(userName, password, accessToken);
    dataManager.saveUser(userModel);
    var cookieManager = CookieManager.instance();
    var cookie = await cookieManager.getCookie(url: Uri.parse("https://tuongtaccheo.com/"),name: "PHPSESSID");
    dataManager.setCookie(cookie!);
    Get.offAllNamed(Routes.HOME);
  }

  switchPasswordVisibility() {
    visibilityPassword.value = !visibilityPassword.value;
  }

  void errorSignIn() {
    dismissOverlay();
  }
}
