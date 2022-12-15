import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/views/admin_home_views.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/Constants.dart';
import '../utils/widgets.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.to(AdminHomeView());
        return false; //<-- SEE HERE
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWidget(context,
            backgroundColor: Colors.white,
            itemColor: Colors.black,
            titleText: 'About'),
        body: Container(),
      ),
    );
  }
}
