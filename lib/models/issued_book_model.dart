import 'package:cloud_firestore/cloud_firestore.dart';

const String tblBookCode = 'bookCode';
const String tblUniqueBookCode = 'uniqueBookCode';
const String tblBorrower = 'borrower';
const String tblDueDate = 'dueDate';
const String tblIssuedDate = 'issueDate';
const String tblBookName = 'book_name';
const String tblPdfUrl = 'pdfUrl';

class IssuedBookModel {
  final String bookCode;
  final String uniqueBookCode;
  final String borrower;
  final DateTime dueDate;
  final DateTime issuedDate;
  final String bookName;
  final String pdfUrl;

  IssuedBookModel(
      {required this.bookCode,
      required this.uniqueBookCode,
      required this.borrower,
      required this.dueDate,
      required this.issuedDate,
      required this.bookName,
      required this.pdfUrl
      });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblBookCode: bookCode,
      tblUniqueBookCode: uniqueBookCode,
      tblBorrower: borrower,
      tblDueDate: dueDate,
      tblIssuedDate: issuedDate,
      tblBookName: bookName,
      tblPdfUrl: pdfUrl,
    };
    return map;
  }

  IssuedBookModel.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc)
      : bookCode = doc.data()![tblBookCode],
        uniqueBookCode = doc.data()![tblUniqueBookCode],
        borrower = doc.data()![tblBorrower],
        dueDate = doc.data()![tblDueDate].toDate(),
        issuedDate = doc.data()![tblIssuedDate].toDate(),
        bookName = doc.data()![tblBookName],
        pdfUrl = doc.data()![tblPdfUrl];

  IssuedBookModel.fromMap(Map<String, dynamic>? doc)
      : bookCode = doc![tblBookCode],
        uniqueBookCode = doc[tblUniqueBookCode],
        borrower = doc[tblBorrower].toDate(),
        dueDate = doc[tblDueDate].toDate(),
        issuedDate = doc[tblIssuedDate],
        bookName = doc[tblBookName],
        pdfUrl = doc[tblPdfUrl];

  /* BookHireModel.fromMap(Map<String, dynamic>? doc, String bookId)
      : id = bookId,
        bookName = doc![tblBookName],
        bookAuthor = doc[tblBookAuthor],
        categories = doc[tblBookCategories],
        publication = doc[tblBookPublications],
        publishedDate = doc[tblBookPublishedDate],
        language = doc[tblBookLanguage],
        bookImage = doc[tblBookImage],
        bookItem = doc[tblBookItem],
        bookHired = doc[tblBookHired],
        bookDescription = doc[tblBookDescription],
        bookStatus = doc[tblBookStatus]
  ;*/

}
