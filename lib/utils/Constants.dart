import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

double appButtonRadius = 4.0;
double appBottomSheetRadius = 20.0;
String appVersion = '1.0.0';
String appName = "Library Management";
String appNameCaps = "LIBRARY MANAGEMENT";
String appDescription =
    'Managing thousands of books, hundreds of memberships, and other library resources '
    'is no easy feat. But now you can keep records, check readers in and out, and maintain a member database,'
    ' all from a single app, efficiently and seamlessly.';

const isDarkModeOnPref = 'isDarkModeOnPref';

var appFont = GoogleFonts.roboto().fontFamily;

const datePattern = 'dd-MM-yyyy';

List<String?> bookTypes = ['Action', 'Sci-fi', 'Horror', 'Comedy', 'Thriller'];
List<String?> bookLanguage = ['English', 'Bengali', 'Hindi', 'Others'];

class InstructionsFormat{
  InstructionsFormat({required this.question,required this.answer});
  String question;
  String answer;
}


List<InstructionsFormat> userInstructionsList = [
  InstructionsFormat(question: 'How to search for books?',answer: 'One the Home screen navigate to the applications section and tap the apply button.'),
  InstructionsFormat(question: 'What do I search books with?',answer: 'Just type the name of the book and that book will appear apparently all the books are displayed already. Tap the result for more options.'),
  InstructionsFormat(question: 'Unable to request for the book?',answer: 'The book that you have already applied for or have issued already can\'t be applied again.'),
  InstructionsFormat(question: 'Applied for the book but not showing in applications?',answer: 'Try to refresh the home page to get the info. As it is not updated instantly.'),
  InstructionsFormat(question: 'How to return a particular book?',answer: 'That is something that only the admin of the app can do. Contact The Library Administrator to return the book.'),
];

List<InstructionsFormat> adminInstructionsList = [
  InstructionsFormat(question: 'How to view The Applications?',answer: 'Navigate to Applications using the bottom navigation bar and then scroll down hit the view all button'),
  InstructionsFormat(question: 'How to accept/reject Applications?',answer: 'Long press any application result and then choose the option. Enter the necessary details if you wish to accept and then hit accept. '),
  InstructionsFormat(question: 'What do I search books with?',answer: 'Just type the name of the book and that book will appear apparently all the books are displayed already. Tap the result for more options.'),
  InstructionsFormat(question: 'How to view the Due Books?',answer: 'Navigate to the issued books and hit view all. Long press any result to view the borrower details and dues.'),
  InstructionsFormat(question: 'How to remove a particular returned books?',answer: 'Navigate to the issued books page and then search with the particular unique code.'),
  InstructionsFormat(question: 'How to add a new book to the library?',answer: 'Hit the Floating Action Button. Enter the necessary details make sure they are correct and voila the book is added!'),
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
