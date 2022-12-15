import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static String firebaseStorageImgPath = 'Images/Books';

  var appFont = GoogleFonts.roboto().fontFamily;

  static const datePattern = 'dd-MM-yyyy';

  static List<String?> bookTypes = [
    'Action',
    'Sci-fi',
    'Horror',
    'Comedy',
    'Thriller'
  ];
  static List<String?> bookLanguage = ['English', 'Bengali', 'Hindi', 'Others'];
}
