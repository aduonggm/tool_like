import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/home_controller.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/webview.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';

class SettingView extends GetView<HomeController> {
  final RxString sodu = '0'.obs;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Obx(() => Text("Số dư: ${sodu.value} xu"))),
        Expanded(
            child: MyWebView(
          link: '${Constants.baseUrl}cauhinh',
          onloadStop: (inAppWebViewController) async {
            var sodu = await inAppWebViewController.evaluateJavascript(source: "\$('#soduchinh').text()");
            this.sodu.value = sodu ?? '';
          },
        ))
      ],
    );
  }
}
