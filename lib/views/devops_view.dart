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

class DeveloperTeamView extends StatelessWidget {
  DeveloperTeamView({Key? key}) : super(key: key);

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
            titleText: 'Developer & Team'),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Developer',
                      style: montserratTextStyle(
                          fontSize: 20, color: Colors.orange),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 110,
                            height: 110,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF90CAF9), width: 3),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage('assets/pronabsen.jpg')),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Pronab Sen Gupta',
                                style: montserratTextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                'pronabsen18@gmail.com',
                                style: montserratTextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/mail.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb('mailto:pronabsen18@gmail.com');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/github.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb('https://github.com/pronabsen');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/facebook.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/profile.php?id=100007250821251');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Team Member',
                      style:
                          montserratTextStyle(fontSize: 20, color: Colors.blue),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vaskor Dhali Shuvo',
                                style: montserratTextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                'shuvodhali64@gmail.com',
                                style: montserratTextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/mail.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchMail('shuvodhali64@gmail.com');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/facebook.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/profile.php?id=100011112939392');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF90CAF9), width: 3),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/team/Vaskar Dhali.jpg')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF90CAF9), width: 3),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/team/Apurbo.jpg')),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Apurba Biswas',
                                style: montserratTextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                'apurbabiswas@gmail.com',
                                style: montserratTextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/mail.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/iamshuvodhali');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/facebook.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/profile.php?id=100015580339071');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Towhid Rifat',
                                style: montserratTextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              Text(
                                'tohidurrifat@gmail.com',
                                style: montserratTextStyle(fontSize: 13),
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/mail.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/profile.php?id=100015055260838');
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    child: const Image(
                                      image: AssetImage(
                                        'assets/other/facebook.png',
                                      ),
                                      height: 32.0,
                                      width: 32.0,
                                    ),
                                    onTap: () {
                                      launchWeb(
                                          'https://www.facebook.com/profile.php?id=100015055260838');
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: 90,
                            height: 90,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xFF90CAF9), width: 3),
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/team/Rifat.jpg')),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    Text(
                      'Team Members helped to complete this project!\nThanks to all Team Members',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> launchWeb(String url) async {
  final Uri launch = Uri.parse(url);
  if (await canLaunchUrl(launch)) {
    await launchUrl(launch, mode: LaunchMode.externalApplication);
  } else {
    // can't launch url
  }
}

Future<void> launchMail(String mail) async {
  final Uri params = Uri(scheme: 'mailto', path: mail, query: 'subject=Hello!');
  if (await canLaunchUrl(params)) {
    await launchUrl(params, mode: LaunchMode.externalApplication);
  } else {
    // can't launch url
  }
}
