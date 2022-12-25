
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/profile_settings_controller.dart';
import 'package:library_managment_system/utils/Constants.dart';
import 'package:library_managment_system/utils/widgets.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/views/about_view.dart';
import 'package:library_managment_system/views/faqs_view.dart';

import '../devops_view.dart';
import '../profile_views.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  ProfileSettingsController profileSettingsController =
      Get.put(ProfileSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    height: 240,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF90CAF9), width: 3),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(profileSettingsController
                                          .userModel?.userImage ??
                                      '')),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          profileSettingsController.userModel!.userName ?? '',
                          style: montserratTextStyle(
                              fontSize: 17, color: Colors.black),
                        ),
                        Text(
                          profileSettingsController.userModel!.userEmail ?? '',
                          style: montserratTextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              _SingleSection(
                title: "General",
                children: [
                  ListTile(
                    title: const Text('View Profile'),
                    leading: const Icon(Icons.remove_red_eye_outlined),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Get.offAll(() => ProfileView(userModel: profileSettingsController.userModel!,));
                    },
                  ),
                  ListTile(
                    title: const Text('Edit Profile'),
                    leading: const Icon(Icons.edit_location_outlined),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: 'Coming in Next update!',
                          backgroundColor: Colors.deepOrange);
                    },
                  ),
                  ListTile(
                    title: const Text('Logout'),
                    leading: const Icon(Icons.logout_outlined),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      profileSettingsController.logout();
                    },
                  ),
                ],
              ),
              _SingleSection(
                title: "Others",
                children: [
                  ListTile(
                    title: const Text('Developer & Team'),
                    leading: const Icon(CupertinoIcons.command),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Get.off(DeveloperTeamView());
                    },
                  ),
                  ListTile(
                    title: const Text('FAQs'),
                    leading: const Icon(CupertinoIcons.quote_bubble),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Get.off(Faqs_view());
                    },
                  ),
                  ListTile(
                    title: const Text('About'),
                    leading: const Icon(CupertinoIcons.info),
                    trailing: const Icon(CupertinoIcons.forward, size: 18),
                    onTap: () {
                      Get.off(AboutView());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;

  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: () {},
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline3?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: children,
          ),
        ),
      ],
    );
  }
}
