import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'constants.dart';

toast(String msg,
    {Toast length = Toast.LENGTH_SHORT,
    Color textColor = Colors.black,
    double fontSize = 15,
    Color background = Colors.grey,
    ToastGravity gravity = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(msg: msg, toastLength: length, gravity: gravity, textColor: textColor, fontSize: fontSize, backgroundColor: background);
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
    var jsonList = jsonDecode(await DefaultAssetBundle.of(context).loadString("assets/json/product_barcode.json")) as List<dynamic>;
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

Future<RemoteConfig> setupRemoteConfig() async {
  final RemoteConfig remoteConfig = RemoteConfig.instance;
  await remoteConfig.setDefaults(<String, dynamic>{'version': Constants.version,'version_name' : '1.0'});

  remoteConfig
      .setConfigSettings(RemoteConfigSettings(fetchTimeout: Duration(seconds: 60), minimumFetchInterval: Duration(hours: kReleaseMode ? 12 : 0)));
  try {
    remoteConfig.fetchAndActivate();
  } catch (exception) {
    print('Unable to fetch remote config. Cached or default values will be '
        'used');
  }
  return remoteConfig;
}
