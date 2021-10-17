import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseTabController extends GetxController {
  final IDataManager dataManager;
  bool _isShowOverlay = false;

  BaseTabController(this.dataManager);

  @override
  void onInit() {
    super.onInit();
  }

  bindNativeAds(bool isSmall) {}

  Future<T> showOverLay<T>(Future<T> future, {Duration delay = Duration.zero}) async => await Get.showOverlay(
        asyncFunction: () async {
          var result = await future;
          await Future.delayed(delay);
          return result;
        },
        loadingWidget: Center(child: CircularProgressIndicator()),
      );

  showAwaitDialog() {
    _isShowOverlay = true;
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: SizedBox(
            width: Get.width / 10,
            height: Get.width / 10,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
    );
  }

  dismissOverlay() {
    if (_isShowOverlay) {
      Navigator.of(Get.overlayContext!).pop();
      _isShowOverlay = false;
    }
  }

  checkVersion() {
    RemoteConfig remoteConfig = RemoteConfig.instance;
    var version = remoteConfig.getInt('version');
    var versionName = remoteConfig.getString('version_name');
    var appLink = remoteConfig.getString('link_app');
    var content = remoteConfig.getString('update_content');

    if (version > Constants.version) showDialogUpdate(versionName, appLink, content);
  }

  Future showSnackBar({
    Duration duration = const Duration(milliseconds: 1000),
    required String title,
    String? messages,
  }) async {
    await Get.showSnackbar(GetBar(duration: duration, title: title, message: messages));
  }

  void showDialogUpdate(String versionName, String applink, String content) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: Colors.transparent,
          child: Center(
            child: Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thông tin cập nhật:', style: Get.textTheme.headline5),
                        Text('v$versionName', style: Get.textTheme.headline6?.copyWith(color: Colors.red))
                      ],
                    ),
                    space(value: 20),
                    Text(content, style: Get.textTheme.bodyText1),
                    space(value: 20),
                    Material(
                        child: commonButton(
                            voidCallback: () => launch(applink),
                            child: Text(
                              'Cập nhật'.toUpperCase(),
                              style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                            )))
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 30),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
