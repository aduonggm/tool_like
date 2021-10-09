import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/data/data_manager.dart';

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

  Future showSnackBar({
    Duration duration = const Duration(milliseconds: 1000),
    required String title,
    String? messages,
  }) async {
    await Get.showSnackbar(GetBar(duration: duration, title: title, message: messages));
  }

}
