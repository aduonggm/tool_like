import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/webview.dart';

class TangLikeView extends StatelessWidget {
  const TangLikeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = Get.arguments;
    var link = arg['link'] as String;
    var cookie = arg['cookie'] as String;

    return Scaffold(
      body: MyWebView(link: link, cookie: cookie),
    );
  }
}
