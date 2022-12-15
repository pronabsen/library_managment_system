import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double appButtonRadius = 4.0;
double appBottomSheetRadius = 20.0;
String appName = "Library Management";
String appNameCaps = "LIBRARY MANAGEMENT";

const isDarkModeOnPref = 'isDarkModeOnPref';

var appFont = GoogleFonts.roboto().fontFamily;

const datePattern = 'dd-MM-yyyy';

List<String?> bookTypes = ['Action', 'Sci-fi', 'Horror', 'Comedy', 'Thriller'];
List<String?> bookLanguage = ['English', 'Bengali', 'Hindi', 'Others'];

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

final List<String> developers = ['Pronab Sen Gupta'];

final List<String> teamMember = ['Vaskar Dhali', 'Apurbo', 'Rifat'];

const isLoggedIn = 'isLoggedIn';
const userId = 'userId';

String getFormattedDate(DateTime dateTime, String pattern) {
  return DateFormat(pattern).format(dateTime);
}

void showMsg(BuildContext context, String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

teamSliderClass(BuildContext context) {
  final List<Widget> teamSliders = teamMember
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              // padding: const EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage('assets/images/team/$item.jpg'),
                  fit: BoxFit.cover,
                ),
                //color: Colors.blue[200],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(width: 3.0, color: Colors.white),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              //  borderRadius: BorderRadius.circular(20),
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: const Color(0xFF90CAF9), width: 1),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/images/team/$item.jpg')),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          item,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ))
      .toList();
  return teamSliders;
}

bluer() {
  return Container(
    height: 200,
    width: double.maxFinite,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: ExactAssetImage("your_chocolage_image"),
        fit: BoxFit.cover,
      ),
    ),
    child: ClipRRect(
      // make sure we apply clip it properly
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          alignment: Alignment.center,
          color: Colors.grey.withOpacity(0.1),
          child: Text(
            "CHOCOLATE",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ),
  );
}
