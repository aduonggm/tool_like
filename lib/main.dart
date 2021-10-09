import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

import 'data/db_helper.dart';
import 'data/preference_helper.dart';
import 'home/bindings/app_bindings.dart';
import 'logger/logger_utils.dart';
import 'routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  // }
  // await MobileAds.instance.initialize();
  var preferenceHelper = PreferenceHelper();
  await preferenceHelper.initPreference();
  var dbHelper = DbHelper();
  await dbHelper.initDatabase();
  // await AnalyticSender.initFirebase();
  // var remoteConfig = await AnalyticSender.setupRemoteConfig();

  // if (remoteConfig.getBool("open_app_enable") && !(preferenceHelper.isUpgrade())) {
  //   OpenAds.instance.initOpenAds(remoteConfig.getString("open_app_id"));
  // }
  // AnalyticSender.trackOpenApp();
  runApp(MyApp(preferenceHelper: preferenceHelper, dbHelper: dbHelper));
}

class MyApp extends StatelessWidget {
  final IPreferenceHelper preferenceHelper;
  final IDbHelper dbHelper;

  const MyApp({required this.preferenceHelper, required this.dbHelper});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // defaultTransition: Transition.rightToLeftWithFade,
        // transitionDuration: Duration(milliseconds: 200),

        theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          textTheme: Get.textTheme,
        )),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        enableLog: true,
        title: 'Learning Book',
        logWriterCallback: Logger.write,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: AppBinding(preferenceHelper: preferenceHelper, dbHelper: dbHelper));
  }
}
