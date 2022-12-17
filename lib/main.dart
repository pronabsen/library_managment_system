/// Generated by Flutter GetX Starter on 2022-12-07 18:45

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/utils/Constants.dart';
import 'package:library_managment_system/utils/store/AppStore.dart';
import 'package:library_managment_system/views/admin_home_views.dart';
import 'package:library_managment_system/views/login_views.dart';
import 'package:library_managment_system/views/registration_view.dart';
import 'package:library_managment_system/views/splash_view.dart';
import 'package:nb_utils/nb_utils.dart';

AppStore appStore = AppStore();

void main() async {
//  _sharedPreferences = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  defaultRadius = 10;
  EasyLoading.init();
  defaultToastGravityGlobal = ToastGravity.BOTTOM;
  runApp(MyApp());
  configLoading();

  //endregion
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..textAlign = TextAlign.center
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true;
  //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData.light(),
      //  darkTheme: ThemeData.dark(),
      //theme: !appStore.isDarkModeOn ? AppThemeData.lightTheme : AppThemeData.darkTheme,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      //initialRoute: LauncherPage.routeName,
    );
  }
}
