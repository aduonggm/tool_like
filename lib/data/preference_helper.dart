import 'package:shared_preferences/shared_preferences.dart';

abstract class IPreferenceHelper {
  bool isUpgrade();

  Future<bool> setUpgrade(bool value);
}

class PreferenceHelper implements IPreferenceHelper {
  static const String KEY_THEME = "theme";
  static const String KEY_VERSION_RATE = "version_rate";
  static const String KEY_SHOW_RATE_DIALOG = "should_show_rate_dialog";
  static const String KEY_UPGRADE = "upgrade_status";
  static const String KEY_FIRST_OPEN_TIME = "first_open_time";
  static const String KEY_LAST_SHOW_INTERS = "last_show_inters";
  static const String KEY_LIST_PRODUCT = "list_product";
  static const String KEY_LAST_SHOW_UPGRADE = "last_show_upgrade";
  late SharedPreferences _preferences;

  Future<void> initPreference() async {
    _preferences = await SharedPreferences.getInstance();
    print("Init preference success");
  }

  @override
  bool isUpgrade() {
    // return true;
    return _preferences.getBool(KEY_UPGRADE) ?? false;
  }

  @override
  Future<bool> setUpgrade(bool value) async {
    return _preferences.setBool(KEY_UPGRADE, value);
  }
}
