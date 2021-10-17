import 'package:flutter/material.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/webview.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: MyWebView(
            link: '${Constants.baseUrl}index.php',
            onloadStop: (controller) {
              controller.evaluateJavascript(
                  source: "document.getElementsByClassName('btn btn-primary')[0].click();"
                      "document.getElementsByClassName('btn btn-primary')[2].click();");
            },
          ),
        ));
  }
}
