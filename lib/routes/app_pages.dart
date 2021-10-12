import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/bindings/home_binding.dart';
import 'package:tool_tang_tuong_tac/home/bindings/mission_binding.dart';
import 'package:tool_tang_tuong_tac/home/bindings/sign_in_binding.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/home_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/mission_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/sign_in_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/sign_up_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/tang_like_view.dart';
import 'package:tool_tang_tuong_tac/home/presentation/view/webview.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
      children: [
        GetPage(name: Routes.SIGN_UP, page: () => SignUpView()),
      ],
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      bindings: [],
      children: [
        GetPage(
          name: Routes.MISSION,
          page: () => MissionView(),
          binding: MissionBinding(),
        ),
        GetPage(
          name: Routes.TANGLIKEVIEW,
          page: () => TangLikeView(),
        ),
      ],
    )
  ];
}
