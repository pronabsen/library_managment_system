import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/admin_home_controller.dart';
import 'package:library_managment_system/controller/book_controller.dart';
import 'package:library_managment_system/utils/Constants.dart';
import 'package:library_managment_system/views/frag_home/request_book_frag.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/book_model.dart';
import '../utils/widgets.dart';
import 'add_book_view.dart';
import 'frag_home/admin_home_frag.dart';
import 'frag_home/issued_book_list.dart';
import 'frag_home/list_book_frag.dart';
import 'frag_home/settings_frag.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView> {

  int _currentIndex = 0;
  PageController _pageController = PageController();


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: homeAppBar(context),
        body: SizedBox.expand(
          child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: [
                Container(
                  child: FragAdminHome(),
                ),
                Container(
                  child: FragBookList(),
                ),
                Container(
                  child: FragRequestBookList(),
                ),
                Container(
                  child: FragIssuedBookList(),
                ),
                Container(
                  child: SettingsPage(),
                )
              ]),
        ),

        floatingActionButton: _currentIndex == 4 ? Container() :FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_outlined),
          onPressed: () {
            Get.off(AddBookView());
          },
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.blue,
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 400), curve: Curves.ease);
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.dashboard_outlined),
              title: const AutoSizeText('Home'),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.library_books_outlined),
                title: const AutoSizeText('Books List'),
                activeColor: Colors.white
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.keyboard_command_key),
                title: const AutoSizeText('Request List'),
                activeColor: Colors.white
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.menu_book_outlined),
                title: const AutoSizeText('Issued Books'),
                activeColor: Colors.white
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.account_circle_outlined),
                title: const AutoSizeText('Me'),
                activeColor: Colors.white
            ),
          ],
        )
    );
  }
}
