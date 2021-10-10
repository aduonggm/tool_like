import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

import 'api_helper.dart';
import 'db_helper.dart';
import 'preference_helper.dart';

abstract class IDataManager implements IPreferenceHelper, IDbHelper, IApiHelper {}

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
  Future signWithAccessToken() => apiHelper.signWithAccessToken();

  @override
  Future recieverMoney(String idPost, MissionType missionType) => apiHelper.recieverMoney(idPost, missionType);
}
