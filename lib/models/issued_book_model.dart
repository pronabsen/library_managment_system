import 'package:cloud_firestore/cloud_firestore.dart';


const String tblBookCode = 'bookCode';
const String tblUniqueBookCode= 'uniqueBookCode';
const String tblBorrower = 'borrower';
const String tblDueDate = 'dueDate';
const String tblBookName = 'book_name';

class IssuedBookModel {

  final String bookCode;
  final String uniqueBookCode;
  final String borrower;
  final String dueDate;
  final String bookName;

  IssuedBookModel({
    required this.bookCode,
    required this.uniqueBookCode,
    required this.borrower,
    required this.dueDate,
    required this.bookName
  });

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblBookCode: bookCode,
      tblUniqueBookCode: uniqueBookCode,
      tblBorrower: borrower,
      tblDueDate: dueDate,
      tblBookName: bookName,
    };
    return map;
  }


  IssuedBookModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : bookCode = doc.data()![tblBookCode],
        uniqueBookCode = doc.data()![tblUniqueBookCode],
        borrower = doc.data()![tblBorrower],
        dueDate = doc.data()![tblDueDate],
        bookName = doc.data()![tblBookName]
  ;

  IssuedBookModel.fromMap(Map<String, dynamic>? doc)
      : bookCode = doc![tblBookCode],
        uniqueBookCode = doc[tblUniqueBookCode],
        borrower = doc[tblBorrower],
        dueDate = doc[tblDueDate],
        bookName = doc[tblBookName]
  ;

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
