import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/model/mission_type.dart';

abstract class IApiHelper {
  Future<String> signIn(String userName, String password);

  Future<List<MissionModel>?> loadListMission(MissionType missionType);

  Future receiverMoney(String idPost, MissionType missionType);

  Future signWithAccessToken();

  setCookie(Cookie cookie);
}

class ApiHelper extends IApiHelper {
  final _baseURL = "https://tuongtaccheo.com/";
  final dio = new Dio();

  final header = {
    "Cookie": "PHPSESSID=pf7hbgu4ee780j680249lsl726",
    "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0",
    "X-Requested-With": "XMLHttpRequest"
  };

  @override
  Future<String> signIn(String userName, String password) async {
    FormData formData = new FormData.fromMap({
      "username": userName,
      "password": password,
      "submit": "ĐĂNG NHẬP",
    });
    var response = await new Dio().post(
      "${_baseURL}login.php",
      data: formData,
      options: Options(
        followRedirects: false,
        maxRedirects: 1,
      ),
    );

    print('$userName   $password ${response.realUri.path}    ${response.statusCode}   ${response.isRedirect}  ');

    return "";
  }

  @override
  Future<List<MissionModel>?> loadListMission(MissionType missionType) async {
    var response = await new Dio().get('$_baseURL${missionType.getListLink}/getpost.php', options: Options(headers: header));
    try {
      var datas = json.decode(response.data) as List;
      return datas.map((e) => MissionModel.fromJson(e)).toList();
    } catch (e) {
      print('error in load mission   $e');
    }
    return null;
  }

  @override
  Future signWithAccessToken() async {
    var response = await dio.post('${_baseURL}logintoken.php',
        data: FormData.fromMap({"access_token": "d2030c477a979bffe781a5f170ecaeba"}),
        options: Options(headers: {"Content-Type": "application/x-www-form-urlencoded"}));
    var cookie = response.headers.map['set-cookie']?.first;
    if (cookie != null) header['Cookie'] = response.headers.map['set-cookie']!.first;
    return cookie != null;
  }

  @override
  Future receiverMoney(String idPost, MissionType missionType) async {
    var response =
        await dio.post('$_baseURL${missionType.getListLink}/nhantien.php', data: FormData.fromMap({"id": idPost}), options: Options(headers: header));
    return response.data;
  }

  @override
  setCookie(Cookie cookie) {
    this.header['Cookie'] = '${cookie.name}=${cookie.value}';
  }
}
