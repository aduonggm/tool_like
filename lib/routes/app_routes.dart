part of 'app_pages.dart';

abstract class Routes {
  static const HOME = '/home';
  static const SIGN_IN = '/sign_in';
  static const SIGN_UP = '/sign_up';

  static const MISSION = '/mission';

  static Future<dynamic> nextScreen({@required screenName, dynamic argument}) async {
    return await Get.toNamed(Get.currentRoute + screenName, arguments: argument);
  }

  static Future<dynamic> popScreen({@required screenName, dynamic argument}) async {
    return await Get.toNamed(screenName, arguments: argument);
  }

  static Future toUpgradeView() async {
    // return await Get.toNamed(UPGRADE_VIEW);
  }

  static void back({dynamic result}) {
    Get.back(result: result);
  }
}
