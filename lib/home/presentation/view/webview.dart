import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MyWebView extends StatelessWidget {
  final String link;
  final String cookie;

  const MyWebView({Key? key, required this.link, required this.cookie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ObxValue(
            (RxInt value) => value.value == -1
                ? Center(child: Text("Đã xảy ra lỗi"))
                : Stack(
                    children: [
                      if (value.value != -1)
                        InAppWebView(
                          initialUrlRequest: URLRequest(url: Uri.parse(link), headers: {
                            "Cookie": cookie,
                            "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0",
                            "X-Requested-With": "XMLHttpRequest"
                          }),
                          onLoadStop: (controller, url) {
                            if (value.value != -1) value.value = 1;
                            controller.evaluateJavascript(source: removeElementByClassName('form-inline'));
                            controller.evaluateJavascript(source: removeElementByClassName('navbar-header'));
                          },
                          onLoadError: (controller, url, code, message) => value.value = -1,
                        ),
                      if (value.value == 0)
                        GestureDetector(
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                            child: CircularProgressIndicator(),
                            alignment: Alignment.center,
                          ),
                          onTap: () {},
                        )
                    ],
                  ),
            0.obs));
  }

  String removeElementByClassName(String name) {
    return "var element = document.getElementsByClassName('$name'); while(element.length > 0){element[0].parentNode.removeChild(element[0]);}";
  }
}
