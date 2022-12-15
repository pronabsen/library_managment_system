import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:library_managment_system/views/login_views.dart';
import 'package:library_managment_system/views/user_home_views.dart';
import 'package:nb_utils/nb_utils.dart';

import '../functions/shared_pref_helper.dart';
import '../utils/Colors.dart';
import '../utils/Constants.dart';
import 'admin_home_views.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  late SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    init();
    getCredential();
  }

  bool isLogged = false;
  bool isAdmin = false;

  getCredential() async {
    final login = await SPHelper.getUserLoggedInSharedPreference();
    final admin = await SPHelper.getUserIsAdminSharedPreference();

    setState(()  {
      isLogged = login;
      isAdmin = admin;
    });
  }

  Future<void> init() async {
    setStatusBarColor(Colors.transparent);
    await 3.seconds.delay;

    if(isLogged){
      if(isAdmin){
        AdminHomeView().launch(context,isNewTask: true);
      } else {
        UserHomeView().launch(context,isNewTask: true);
      }
    }else {
      LoginView().launch(context,isNewTask: true);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final Widget networkSvg = SvgPicture.network(
    'https://www.hooksounds.com/assets/seo/illustration.svg',
    semanticsLabel: 'A shark?!',
    fit: BoxFit.cover,
   // width: MediaQuery.of(context).size.width,
    placeholderBuilder: (BuildContext context) => Container(
      //  padding: const EdgeInsets.all(30.0),
        child: const CircularProgressIndicator()),
  );

  final Widget textLiquidFill = SizedBox(
 //   width: 250.0,
    child: DefaultTextStyle(
      style: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(
        animatedTexts: [

          FadeAnimatedText(appName),
          FadeAnimatedText(appName),
          FadeAnimatedText(appName),
          FadeAnimatedText(appName),
        ],
        onTap: () {
          print("Tap Event");
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: context.height(),
        width: context.width(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: context.statusBarHeight + 50),
                Image.asset('assets/library_icon.png', height: 100, width: 100, fit: BoxFit.cover),
               // textLiquidFill
                Text(appName, style: boldTextStyle(size: 35, fontFamily: appFont, color: appDarkColor, weight: FontWeight.w900)),
              ],
            ),
            Positioned(
              bottom: 0,
           child: Image.asset("assets/images/library.png", fit: BoxFit.cover,height: 300,),
           //   child: Image.network('https://www.hooksounds.com/assets/seo/illustration.svg', width: context.width(), fit: BoxFit.cover),
            ),
            Image.asset('assets/gifs/app_loader.gif', color: appDarkColor, width: 50, height: 50),
          ],
        ),
      ),
    );
  }
}
