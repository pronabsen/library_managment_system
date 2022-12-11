import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';
import '../views/home.dart';
import 'Colors.dart';

Widget text({
  required String txt,
  double size = 12,
  final Color? color = white,
  final FontWeight? fontWeight,
  final TextAlign? textAlign,
  final Color? backgroundColor,
}) {
  return Text(
    txt,
    textAlign: textAlign,
    style: TextStyle(backgroundColor: backgroundColor, color: color, fontSize: size, fontWeight: fontWeight),
  );
}

Widget customButton({
  final GestureTapCallback? onTap,
  String txt = "",
  double? wid,
  double? high = 40,
  final Color? color = black,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = white,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      child: Container(
        height: high,
        width: wid,
        alignment: Alignment.center,
        decoration: BoxDecoration(border: border, color: color, borderRadius: BorderRadius.circular(45)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Widget customButton_1({
  final GestureTapCallback? onTap,
  String txt = "",
  final Color? color = primaryBlackColor,
  final double? elevation = 10,
  final BoxBorder? border,
  final Color? txtcolor = primaryWhiteColor,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(border: border, color: color, borderRadius: BorderRadius.circular(15)),
        child: Text(txt, style: TextStyle(color: txtcolor)),
      ),
    ),
  );
}

Future customDialoge(
  BuildContext context, {
  final GestureTapCallback? onTap,
  final List<Widget>? actions,
  // Flash? i,
  var arguments,
      final int ? duration,
}) {
  //var flashObserver = i;
  return showDialog(
    context: context,
    builder: (context) {
      Timer.periodic(Duration(milliseconds: 5000), (timer) {
        //appStore.i += 1;
        if (timer.tick == 5000) {
          timer.cancel();
        }
      });
      Timer(
        Duration(seconds: 50),
        () {
          Navigator.pop(context);
       //   Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        },
      );
      final high = MediaQuery.of(context).size.width;
      return AlertDialog(
        scrollable: true,
        actions: actions,
        backgroundColor: context.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        content: SingleChildScrollView(
          child: Container(
            color: context.scaffoldBackgroundColor,
            alignment: Alignment.topCenter,
        //    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            width: 80,
            child: Observer(
              builder: (context) => Transform.rotate(
                angle: 0.5,
                child: Image(image: AssetImage('assets/gifs/app_loader.gif'), color: Colors.black, height: high / 24 *5, width: high / 24 * 5),
              ),
            ),
          ),
        ),
      );
    },
  );
}

PreferredSizeWidget customAppBarWidget(BuildContext context, {String? titleText, Color? backgroundColor, Color? itemColor, Widget? actionWidget, Widget? actionWidget2}) {
  return AppBar(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: backgroundColor?? appSecBackGroundColor),
    backgroundColor: backgroundColor ?? appSecBackGroundColor,
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: itemColor ?? Colors.white),
      onPressed: () {
        Get.off(Home());
       // Home().launch(context, isNewTask: true);
      },
    ),
    actions: [actionWidget ?? SizedBox(), actionWidget2 ?? SizedBox()],
    title: Text(titleText ?? "", style: boldTextStyle(size: 18, color: itemColor ?? Colors.black)),
    elevation: 0.0,
  );
}

InputDecoration inputDecoration(
  BuildContext context, {
  IconData? prefixIcon,
  Widget? suffixIcon,
  String? labelText,
  double? borderRadius,
  String? hintText,
}) {
  return InputDecoration(
    counterText: "",
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    hintText: hintText.validate(),
    hintStyle: secondaryTextStyle(),
    isDense: true,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 16, color: appStore.isDarkModeOn ? white : gray) : null,
    suffixIcon: suffixIcon.validate(),
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    filled: true,
    fillColor: editTextBgColor,
  );
}

Decoration commonDecoration({double? cornorRadius, Color?color}) {
  return boxDecorationWithRoundedCorners(
    backgroundColor: color ?? white,
    borderRadius: BorderRadius.all(Radius.circular(cornorRadius ?? 8.0)),
    border: Border.all(color: appStore.isDarkModeOn ? white : gray.withOpacity(0.1)),
  );
}
showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Simple Alert"),
        content: Text("This is an alert message."),
        actions: [
          ElevatedButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}