import 'package:cloud_firestore/cloud_firestore.dart';

const String tblBookCode = 'bookCode';
const String tblApplicationDate = 'applicationDate';
const String tblBorrower = 'borrower';
const String tblBorrowerName = 'borrowerName';
const String tblBookName = 'book_name';

class ApplicationModel {
  final String bookCode;
  final String applicationDate;
  final String borrower;
  final String borrowerName;
  final String bookName;

  ApplicationModel(
      {required this.bookCode,
      required this.applicationDate,
      required this.borrower,
      required this.borrowerName,
      required this.bookName});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblBookCode: bookCode,
      tblApplicationDate: applicationDate,
      tblBorrower: borrower,
      tblBorrowerName: borrowerName,
      tblBookName: bookName,
    };
    return map;
  }

  ApplicationModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : bookCode = doc.data()![tblBookCode],
        applicationDate = doc.data()![tblApplicationDate],
        borrower = doc.data()![tblBorrower],
        borrowerName = doc.data()![tblBorrowerName],
        bookName = doc.data()![tblBookName];
}
