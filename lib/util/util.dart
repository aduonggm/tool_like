import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'constants.dart';

enum MissionType {
  LikeFb,
  CamXucFb,
  CamXucBinhLuan,
  BinhLuan,
  TheoDoi,
  Share,
  LikePage,
  Join,
  Rate,
  TymTT,
  CommentTT,
  FollowTT
}

extension GetInfo on MissionType {
  String get getTitle {
    switch (this) {
      case MissionType.LikeFb:
        return "Like Chéo";
      case MissionType.CamXucFb:
        return "Cảm xúc chéo";
      case MissionType.CamXucBinhLuan:
        return "Cảm xúc chéo bình luận ";
      case MissionType.BinhLuan:
        return "Bình luận chéo ";
      case MissionType.TheoDoi:
        return "Theo dõi chéo ";
      case MissionType.Share:
        return "Chia sẻ chéo ";
      case MissionType.LikePage:
        return "Like page chéo ";
      case MissionType.Join:
        return "Tham gia nhóm chéo ";
      case MissionType.Rate:
        return "Đánh giá page chéo ";
      case MissionType.TymTT:
        return "Tim chéo TT";
      case MissionType.CommentTT:
        return "Bình luận chéo TT";
      case MissionType.FollowTT:
        return "Follow chéo TT";
      default:
        return "";
    }
  }
}

String getTitle(MissionType missionType) {
  switch (missionType) {
    case MissionType.LikeFb:
      return "Like Chéo";
    case MissionType.CamXucFb:
      return "Cảm xúc chéo";
    case MissionType.CamXucBinhLuan:
      return "Cảm xúc chéo bình luận ";
    case MissionType.BinhLuan:
      return "Bình luận chéo ";
    case MissionType.TheoDoi:
      return "Theo dõi chéo ";
    case MissionType.Share:
      return "Chia sẻ chéo ";
    case MissionType.LikePage:
      return "Like page chéo ";
    case MissionType.Join:
      return "Tham gia nhóm chéo ";
    case MissionType.Rate:
      return "Đánh giá page chéo ";
    case MissionType.TymTT:
      return "Tim chéo TT";
    case MissionType.CommentTT:
      return "Bình luận chéo TT";
    case MissionType.FollowTT:
      return "Follow chéo TT";
    default:
      return "";
  }
}

toast(String msg,
    {Toast length = Toast.LENGTH_SHORT,
    Color textColor = Colors.black,
    double fontSize = 15,
    Color background = Colors.grey,
    ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: length,
      gravity: gravity,
      textColor: textColor,
      fontSize: fontSize,
      backgroundColor: background);
}

Future<int> checkDeviceSupportDarkMode() async {
  if (Platform.isAndroid) {
    if (await getSDKVersion >= Constants.ANDROID_Q) return 2;
  } else if (Platform.isIOS) {
    var iosInfo = await DeviceInfoPlugin().iosInfo;
    var systemName = iosInfo.systemName;
    if (double.parse(systemName) >= 13.0) return 2;
  }
  return 0;
}

Future<int> get getSDKVersion async {
  var androidInfo = await DeviceInfoPlugin().androidInfo;
  return androidInfo.version.sdkInt;
}

// requestPermission(Permission permission) async {
//   if (await permission.isGranted) return true;
//   return await permission.request() == PermissionStatus.granted;
// }

extension ListExt on List {
  get firstElement => length > 0 ? first : null;
}

Color colorParseFromString(String stringColor) {
  return Color(int.parse('0xff${stringColor.replaceAll("#", "")}'));
}

String colorToString(Color color) {
  return '#${color.value.toRadixString(16).substring(2, 8)}';
}

Future<String> getCountryWithBarcode(BuildContext? context, int data) async {
  String name = 'Unknown';
  if (context == null) return name;
  try {
    var jsonList = jsonDecode(await DefaultAssetBundle.of(context).loadString("assets/json/product_barcode.json"))
        as List<dynamic>;
    for (Map element in jsonList) {
      List<String> number = (element['barcode'] as String).split(' – ');
      if (number.length == 1 && int.parse(number.first.trim()) == data) {
        name = element['country'];
        break;
      } else {
        int startNumber = int.parse(number.first.trim());
        int endNumber = int.parse(number.last.trim());
        if (data >= startNumber && data <= endNumber) {
          print(' dataaaaaaa   $startNumber    $endNumber');
          name = element['country'];
          break;
        }
      }
    }
  } catch (e) {}
  return name;
}

extension checkEmptyList on List? {
  bool get isNotEmptyList {
    return this != null && this!.isNotEmpty;
  }
}

extension check on String {
  bool get startHttp {
    return startsWith('http://') || startsWith('https://');
  }
}

extension checkStringNull on String? {
  bool get isStringEmpty {
    return this == null || this!.isEmpty;
  }

  String getInfo(String title, {bool newLine = true}) {
    return this != null && this!.isNotEmpty ? '${newLine ? '\n' : ''}${title.capitalizeFirst}: $this' : '';
  }
}

Brightness getColorIconsStatusBar(int theme) {
  if (theme == 0)
    return Brightness.dark;
  else if (theme == 1)
    return Brightness.light;
  else
    return SchedulerBinding.instance?.window.platformBrightness == Brightness.dark ? Brightness.light : Brightness.dark;
}

// Future<bool> checkNetworkStatus() async {
//   ConnectivityResult result = await (Connectivity().checkConnectivity());
//   return result != ConnectivityResult.none;
// }

String getNameFileInPath(String filePath, {bool containsExtension = true}) {
  var lastSeparator = filePath.lastIndexOf(Platform.pathSeparator);
  if (containsExtension) return filePath.substring(lastSeparator + 1);
  return filePath.substring(lastSeparator + 1, filePath.lastIndexOf('.pdf'));
}

class BindingObserver extends WidgetsBindingObserver {
  VoidCallback? pauseCallback;
  VoidCallback? resumeCallback;

  BindingObserver({this.pauseCallback, this.resumeCallback});

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('appLifeCycleState inactive');
        break;
      case AppLifecycleState.resumed:
        print('appLifeCycleState resume');
        if (resumeCallback != null) resumeCallback!();
        break;
      case AppLifecycleState.paused:
        if (pauseCallback != null) pauseCallback!();
        break;
      case AppLifecycleState.detached:
        print('appLifeCycleState detached');
        break;
    }
  }
}
