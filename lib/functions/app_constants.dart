import 'package:google_fonts/google_fonts.dart';

class AppConstants {

  static String fcmServerKey = 'AAAAg1W55Io:APA91bEAoNs2uqrKa-b8MTIWLU5iVxRbr9KHr9OWwNwgrZZrvyHqldzThkC_6zt1gayWGvGvzOaAOKWpGb1haWJApBFAZGe6OtUHE3AmxjAK2-c3Gh33BBsTmUrmRFzrQcvkfE38hFCY';

  static String firebaseStorageImgPath = 'Images/Books';
  static String firebaseStorageImgPathProfile = 'Images/Users';
  static String firebaseStorageImgPathInvoices = 'Images/Invoices';

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
