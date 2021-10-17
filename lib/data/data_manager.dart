import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';
import 'package:tool_tang_tuong_tac/model/user_model.dart';
import 'package:tool_tang_tuong_tac/util/constants.dart';

import 'api_helper.dart';
import 'db_helper.dart';
import 'preference_helper.dart';

abstract class IDataManager implements IPreferenceHelper, IDbHelper, IApiHelper {
  String? accessToken;
  String cookie = '';
}

class DataManager extends IDataManager {
  final IPreferenceHelper preferenceHelper;
  final IApiHelper apiHelper;
  final IDbHelper dbHelper;

  DataManager({required this.preferenceHelper, required this.apiHelper, required this.dbHelper});

  @override
  bool isUpgrade() => preferenceHelper.isUpgrade();

  @override
  Future<bool> setUpgrade(bool value) => preferenceHelper.setUpgrade(value);

  @override
  Future<String> signIn(String userName, String password) => apiHelper.signIn(userName, password);

  @override
  Future<List<MissionModel>?> loadListMission(MissionType missionType) => apiHelper.loadListMission(missionType);

  @override
  Future<String> signWithAccessToken(String accessToken) async {
    this.cookie = await apiHelper.signWithAccessToken(accessToken);
    return cookie;
  }

  @override
  Future<String> receiverMoney(String idPost, MissionType missionType) => apiHelper.receiverMoney(idPost, missionType);

  @override
  UserModel? getUser() => preferenceHelper.getUser();

  @override
  Future<bool> saveUser(UserModel userModel) async {
    this.accessToken = userModel.accessToken;
    var cookieManager = CookieManager.instance();
    var cookie = await cookieManager.getCookie(url: Uri.parse(Constants.baseUrl), name: "PHPSESSID");
    setCookie(cookie!);
    return preferenceHelper.saveUser(userModel);
  }

  @override
  setCookie(Cookie cookie) => apiHelper.setCookie(cookie);
}
