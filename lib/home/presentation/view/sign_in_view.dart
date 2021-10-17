import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/sign_in_controller.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInView extends GetView<SignInController> {
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: overScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: Get.height,
            child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Spacer(),
                    Text('Đăng nhập ', style: Get.textTheme.headline3?.copyWith(color: Colors.black)),
                    space(value: 20),
                    buildTextField(
                      onSave: (value) => controller.userName = value ?? '',
                      labelText: "Tài khoản",
                      leadingIcon: Icons.person,
                    ),
                    space(),
                    Obx(
                      () => buildTextField(
                        onSave: (value) => controller.password = value ?? '',
                        labelText: 'Mật khẩu',
                        leadingIcon: Icons.lock,
                        obscureText: controller.hidePass.value,
                        trailingIcon: !controller.hidePass.value ? Icons.visibility : Icons.visibility_off,
                        trailingAction: () => controller.switchPasswordVisibility(),
                      ),
                    ),
                    space(value: 20),
                    commonButton(
                        voidCallback: () {
                          globalKey.currentState?.save();
                          controller.singIn();
                        },
                        child: Text(
                          'Đăng nhập'.toUpperCase(),
                          style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                        )),
                    space(),
                    commonButton(
                        voidCallback: () {
                          CookieManager.instance().deleteAllCookies();
                          Get.toNamed(Get.currentRoute + Routes.SIGN_UP);
                        },
                        child: Text(
                          'Đăng ký'.toUpperCase(),
                          style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                        )),
                    Spacer(),
                    RichText(
                        text: TextSpan(style: Get.textTheme.bodyText1, children: [
                      TextSpan(text: 'Ứng dụng sử dụng api của website '),
                      TextSpan(
                          text: 'tuongtaccheo.com',
                          style: TextStyle(color: Constants.mainColor),
                          recognizer: TapGestureRecognizer()..onTap = () => launch('${Constants.baseUrl}index.php'))
                    ])),
                    space(value: 50),
                    SizedBox(
                      height: 1,
                      child: InAppWebView(
                        onWebViewCreated: (controller) {
                          this.controller.inAppWebViewController = controller;
                          this.controller.autoSignin();
                        },
                        onLoadStop: (controller, url) async {
                          if (url.toString() == '${Constants.baseUrl}logintoken.php') this.controller.goHome();
                          if (url.toString() == "${Constants.baseUrl}index.php") this.controller.errorSignIn();

                          if (url.toString() == '${Constants.baseUrl}home.php')
                            controller.loadUrl(urlRequest: URLRequest(url: Uri.parse('${Constants.baseUrl}api/')));

                          if (url.toString() == '${Constants.baseUrl}api/') {
                            var value = await controller.evaluateJavascript(source: "document.getElementsByClassName('form-control')[0].value;");
                            this.controller.saveData(value);
                          }
                          print('load stop is ${(url.toString() == 'https://tuongtaccheo.com/home.php')}  ${url.toString()}');
                        },
                        onLoadError: (controller, url, code, message) {
                          if (message == 'net::ERR_INTERNET_DISCONNECTED') this.controller.noInternetConnected();
                          print('load error   $message   ${url.toString()}');
                        },
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
