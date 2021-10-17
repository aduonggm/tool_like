import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class MyWebView extends StatelessWidget {
  final String link;
  final Function(InAppWebViewController inAppWebViewController)? onloadStop;
  final Function(InAppWebViewController controller, Uri? url, int code, String message)? onLoadError;

  const MyWebView({Key? key, required this.link, this.onloadStop, this.onLoadError}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue(
            (RxInt value) => value.value == -1
            ? Center(child: Text("Đã xảy ra lỗi"))
            : Stack(
          children: [
            if (value.value != -1)
              InAppWebView(
                initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      horizontalScrollBarEnabled: false,
                      disableHorizontalScroll: true,
                      verticalScrollBarEnabled: false,
                    )),
                onWebViewCreated: (controller) {
                  controller.loadUrl(urlRequest: URLRequest(url: Uri.parse(link)));
                },
                onLoadStop: (controller, url) {
                  if (onloadStop != null) onloadStop!(controller);
                  if (value.value != -1) value.value = 1;
                  controller.evaluateJavascript(source: removeElementByClassName('form-inline'));
                  controller.evaluateJavascript(source: removeElementByClassName('navbar navbar-default'));

                },
                onLoadError: (controller, url, code, message) {
                  value.value = -1;
                  this.onLoadError!(controller, url, code, message);
                },
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
        0.obs);
  }

  String removeElementByClassName(String name) {
    return "var element = document.getElementsByClassName('$name'); while(element.length > 0){element[0].parentNode.removeChild(element[0]);}";
  }

}
