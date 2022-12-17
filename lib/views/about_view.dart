
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/views/admin_home_views.dart';
import 'package:library_managment_system/views/user_home_views.dart';
import 'package:url_launcher/url_launcher.dart';

import '../functions/shared_pref_helper.dart';
import '../utils/Constants.dart';
import '../utils/widgets.dart';

class AboutView extends StatelessWidget {
  AboutView({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await SPHelper.getUserIsAdminSharedPreference()) {
          Get.to(const AdminHomeView());
        } else {
          Get.to(const UserHomeView());
        }
        return false; //<-- SEE HERE
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWidget(context,
            backgroundColor: Colors.white,
            itemColor: Colors.black,
            titleText: 'About'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/library_icon.png'),
                height: 90,
                width: 90,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                appName,
                style: montserratTextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Your digital librarian.',
                style: montserratTextStyle(
                    fontSize: 17, color: Colors.deepOrangeAccent),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Text(
                  appDescription,
                  style: montserratTextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Build Version: v${appVersion}',
                style: montserratTextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
