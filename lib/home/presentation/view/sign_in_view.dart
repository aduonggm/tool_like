import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/home/presentation/controller/sign_in_controller.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';

class SignInView extends GetView<SignInController> {
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: overScrollView(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            height: Get.height,
            child: Form(
                key: globalKey,
                child: Column(
                  children: [
                    Spacer(),
                    buildTextField(
                      onSave: (value) => controller.userName = value ?? '',
                      labelText: "username",
                      leadingIcon: Icons.person,
                    ),
                    space(),
                    Obx(
                      () => buildTextField(
                        onSave: (value) => controller.password = value ?? '',
                        labelText: 'password',
                        leadingIcon: Icons.lock,
                        obscureText: controller.visibilityPassword.value,
                        trailingIcon: !controller.visibilityPassword.value ? Icons.visibility : Icons.visibility_off,
                        trailingAction: () => controller.switchPasswordVisibility(),
                      ),
                    ),
                    space(value: 20),
                    commonButton(
                        voidCallback: () {
                          globalKey.currentState?.save();
                          controller.singIn();
                        },
                        child: Text(
                          'Đăng nhập'.toUpperCase(),
                          style: Get.textTheme.headline6?.copyWith(color: Colors.white),
                        )),
                    Spacer(),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
