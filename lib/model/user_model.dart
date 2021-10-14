import 'dart:collection';

class UserModel {
  final String userName;
  final String password;
  final String accessToken;

  UserModel(this.userName, this.password, this.accessToken);

  UserModel.fromJson(dynamic json)
      : userName = json['user_name'],
        password = json['passwprd'],
        accessToken = ['access_token'] as String;

  Map toJson() {
    Map hashMap = Map();
    hashMap['user_name'] = userName;
    hashMap['password'] = password;
    hashMap['access_token'] = accessToken;
    return hashMap;
  }
}
