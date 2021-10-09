import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';

import 'constants.dart';

// buildFlag({@required String uri, double size = 20}) {
//   return Container(
//     height: size,
//     width: size,
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       color: Colors.white,
//       border: Border.all(width: 0.5, color: Colors.blue),
//       image: DecorationImage(image: AssetImage(uri), fit: BoxFit.cover, onError: (value, stacktrace) {}),
//     ),
//   );
// }

Widget space({double value = 10, Axis axis = Axis.vertical}) {
  return SizedBox(
    width: axis == Axis.horizontal ? value : 0,
    height: axis == Axis.horizontal ? 0 : value,
  );
}

Widget buildTextField(
    {IconData? leadingIcon,
    IconData? trailingIcon,
    bool? obscureText,
    String? labelText,
    String? hintText,
    String? initText,
    String? errorText,
    Function()? onTap,
    bool? readOnly,
    TextInputType? textInputType = TextInputType.emailAddress,
    Function()? trailingAction,
    TextEditingController? controller,
    Function(String?)? onSave}) {
  return TextFormField(
    obscureText: obscureText ?? false,
    initialValue: initText,
    onSaved: onSave,
    maxLines: 1,
    readOnly: readOnly ?? false,
    controller: controller,
    onTap: onTap,
    keyboardType: textInputType,
    decoration: InputDecoration(
      labelText: labelText,
      hintText: hintText,
      errorText: errorText,
      errorMaxLines: 1,
      contentPadding: EdgeInsets.only(left: 10),
      prefixIcon: leadingIcon != null ? Icon(leadingIcon) : null,
      suffixIcon: IconButton(
        onPressed: trailingAction,
        icon: Icon(trailingIcon),
        splashRadius: 20,
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

overScrollView({required Widget child}) {
  return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowGlow();
        return true;
      },
      child: child);
}

commonButton({required VoidCallback voidCallback, required Widget child}) {
  return InkWell(
      onTap: () => voidCallback(),
      borderRadius: BorderRadius.circular(10),
      child: Ink(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Constants.mainColor),
          height: 50,
          width: Get.width,
          child: Center(child: child)));
}

buttonSelect(
    {required Widget child,
    required VoidCallback voidCallback,
    Color? bgColor,
    Color? borderColor,
    double borderRadius = 15,
    double borderSize = 1.0}) {
  return InkWell(
    borderRadius: BorderRadius.circular(borderRadius),
    onTap: () => voidCallback(),
    child: Ink(
      child: Center(child: child),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
          border: Border.all(
            color: borderColor ?? Constants.mainColor,
            width: borderSize,
          )),
    ),
  );
}

commonDropDown(ValueNotifier<String> dataSelect, List<String> dataList, ValueChanged<String> valueChanged) {
  return ValueListenableBuilder(
    valueListenable: dataSelect,
    builder: (context, String value, child) {
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(),
        ),
        hint: Text('Select'),
        value: value,
        onChanged: (newValue) {
          if (newValue == null) return;
          dataSelect.value = newValue;
          valueChanged(newValue);
        },
        items: dataList.map((text) {
          return DropdownMenuItem(
            child: Text(text),
            value: text,
          );
        }).toList(),
      );
    },
  );
}

Widget get noDataWidget {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('No data', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color(0xff919191))),
      space(axis: Axis.vertical),
      Image.asset('assets/images/no_data_image.png', width: Get.width / 5)
    ],
  );
}

Widget disableGlowScroll(Widget child) {
  return NotificationListener<OverscrollIndicatorNotification>(
    child: child,
    onNotification: (notification) {
      notification.disallowGlow();
      return false;
    },
  );
}

Widget listBookSample(int length, {bool isComplete = true}) {
  return ListView.builder(
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    itemCount: length,
    itemBuilder: (BuildContext context, int index) {
      double value = isComplete ? 1 : Random().nextDouble();
      return Card(
        child: ListTile(
          isThreeLine: true,
          leading: Image.network(
            "https://kbimages1-a.akamaihd.net/011c5826-8da6-49be-9602-866760464c63/353/569/90/False/in-search-of-lost-time-vol-1-7.jpg",
            fit: BoxFit.fill,
          ),
          title: Text("In Search of Lost Time"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Marcel Proust"),
              Text("Intermediate"),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Expanded(
                      child: LinearProgressIndicator(
                    value: value,
                    minHeight: 3,
                    color: Colors.teal,
                    backgroundColor: Colors.grey,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "${(value * 100).toStringAsFixed(0)}%",
                      style: TextStyle(color: Colors.teal, fontSize: 12),
                    ),
                  )
                ],
              )
            ],
          ),
          onTap: () {},
        ),
      );
    },
  );
}
// class CustomsSlideTransition extends StatefulWidget {
//   final Widget child;
//   final Duration? delayDuration;
//
//   const CustomsSlideTransition({Key? key, required this.child, this.delayDuration}) : super(key: key);
//
//   @override
//   _CustomsSlideTransitionState createState() => _CustomsSlideTransitionState();
// }
//
// class _CustomsSlideTransitionState extends State<CustomsSlideTransition> with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     if (widget.delayDuration != null)
//       Future.delayed(widget.delayDuration!, () => _controller.forward());
//     else
//       _controller.forward();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       opacity: Tween<double>(begin: 0.0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.ease)),
//       child: widget.child,
//     );
//   }
// }
