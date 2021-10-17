import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/base_tab_controller.dart';
import 'package:tool_tang_tuong_tac/model/user_model.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class SignInController extends BaseTabController {
  final IDataManager dataManager;

  SignInController(this.dataManager) : super(dataManager);
  RxBool hidePass = true.obs;
  InAppWebViewController? inAppWebViewController;
  String userName = "";
  String password = "";

  @override
  void onInit() {
    // checkVersion();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    checkVersion();
  }

  void autoSignin() async {
    showAwaitDialog();
    var user = dataManager.getUser();
    if (user == null) {
      dismissOverlay();
      return;
    }

    print('controller is null ${inAppWebViewController == null}');
    await inAppWebViewController?.loadUrl(
        urlRequest: URLRequest(
      url: Uri.parse('${Constants.baseUrl}logintoken.php'),
      body: Uint8List.fromList(utf8.encode('access_token=${user.accessToken}')),
      method: 'POST',
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    ));

    // _goHome();
  }

  goHome() async {
    var cookies = await CookieManager.instance().getCookie(url: Uri.parse(Constants.baseUrl), name: 'PHPSESSID');
    if (cookies == null) {
      toast("Đã xảy ra lỗi! Vui lòng thử lại ");
      return;
    }
    dataManager.setCookie(cookies);
    Get.offAllNamed(Routes.HOME);
  }

  void singIn() async {
    print(' controller is null   ${inAppWebViewController == null}');
    if (userName.isEmpty || password.isEmpty) return;
    CookieManager.instance().deleteAllCookies();
    var postData = Uint8List.fromList(utf8.encode("username=$userName&password=$password&submit=ĐĂNG NHẬP"));
    inAppWebViewController?.postUrl(url: Uri.parse("${Constants.baseUrl}login.php"), postData: postData);
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
    goHome();
  }

  switchPasswordVisibility() {
    hidePass.value = !hidePass.value;
  }

  void errorSignIn() {
    dismissOverlay();
  }

  void noInternetConnected() {
    dismissOverlay();
    toast('Vui lòng kiểm tra kết nối mạng trước khi đăng nhập');
  }
}
