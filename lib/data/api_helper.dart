import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:tool_tang_tuong_tac/model/mission.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

abstract class IApiHelper {
  Future<String> signIn(String userName, String password);

  Future<List<MissionModel>?> loadListMission(MissionType missionType);

  Future signWithAccessToken();
}

class ApiHelper extends IApiHelper {
  final _baseURL = "https://tuongtaccheo.com/";
  final dio = new Dio();

  @override
  Future<String> signIn(String userName, String password) async {
    var cookieJar = CookieJar();
    await cookieJar.deleteAll();
    dio.interceptors.add(CookieManager(cookieJar));
    FormData formData = new FormData.fromMap({
      "username": userName,
      "password": password,
      "submit": "ĐĂNG NHẬP",
    });
    var response = await dio.post("${_baseURL}login.php",
        data: formData,
        options: Options(
            followRedirects: false,
            method: 'post',
            validateStatus: (status) {
              print('status í  $status');
              return status! < 500;
            }));

    var list = await cookieJar.loadForRequest(Uri.parse('https://tuongtaccheo.com/'));
    print('$userName   $password ${response.realUri.path}    ${response.statusCode}   ${response.isRedirect}  ');
    if (response.realUri.path == '/home.php' && list.isNotEmpty) return list.first.value;
    return "";
  }

  @override
  Future<List<MissionModel>?> loadListMission(MissionType missionType) async {
    var response = await new Dio().post('${_baseURL}kiemtien/thamgianhomcheo/getpost.php',
        options: Options(headers: {
          "Cookie": "PHPSESSID=lqfr3c3f4ikfgbotnoh5ge8e11",
          "User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:91.0) Gecko/20100101 Firefox/91.0",
          "Referer": "https://tuongtaccheo.com/kiemtien/",
          "X-Requested-With": "XMLHttpRequest"
        }));

    // try {
    print(' map is ${response.data.runtimeType}    ${response.data}  ');

    var datas = json.decode(response.data) as List;
    return datas.map((e) => MissionModel.fromJson(e)).toList();
    // } catch (e) {
    //   print('error in load mission   $e');
    // }
    return null;
  }

  @override
  Future signWithAccessToken() async {
    var response = await dio.post('${_baseURL}logintoken.php',
        data: FormData.fromMap({"access_token": "d2030c477a979bffe781a5f170ecaeba"}),
        options: Options(headers: {"Content-Type": "application/x-www-form-urlencoded"}));

    print("response  data is   ${response.data}    \n ${response.headers.map}");
  }
}
