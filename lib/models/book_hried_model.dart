import 'package:cloud_firestore/cloud_firestore.dart';

const String tblId = 'id';

const String tblHireId = 'hire_id';

const String tblHireUserId = 'user_id';
const String tblHireBookId = 'book_id';
const String tblHireIssueDate = 'issue_date';
const String tblHireReturnDate = 'return_date';
const String tblHireFine = 'fine';

const String tblBookName = 'book_name';
const String tblBookAuthor = 'book_author';
const String tblBookCategories = 'categories';
const String tblBookLanguage = 'language';
const String tblBookImage = 'book_image';
const String tblHireStatus = 'status';

class BookHireModel {

  final String? id;
  final int userId;
  final int bookId;
  final String issueDate;
  final String returnDate;
  final bool fine;

  final String bookName;
  final String bookAuthor;
  final String categories;
  final String language;
  final String bookImage;
  final int hireStatus;

  BookHireModel({
    this.id = '0',
    required this.userId,
    required this.bookId,
    required this.issueDate,
    required this.returnDate,
    this.fine = false,
    required this.bookName,
    required this.bookAuthor,
    required this.categories,
    required this.language,
    required this.bookImage,
    this.hireStatus = 1,
  });

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblId: id,
      tblHireUserId: userId,
      tblHireBookId: bookId,
      tblHireIssueDate: issueDate,
      tblHireReturnDate: returnDate,
      tblHireFine: fine,
      tblBookName: bookName,
      tblBookAuthor: bookAuthor,
      tblBookCategories: categories,
      tblBookLanguage: language,
      tblBookImage: bookImage,
      tblHireStatus : hireStatus,
    };
    return map;
  }


  BookHireModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        userId = doc.data()![tblHireUserId],
        bookId = doc.data()![tblHireBookId],
        issueDate = doc.data()![tblHireIssueDate],
        returnDate = doc.data()![tblHireReturnDate],
        fine = doc.data()![tblHireFine],
        bookName = doc.data()![tblBookName],
        bookAuthor = doc.data()![tblBookAuthor],
        categories = doc.data()![tblBookCategories],
        language = doc.data()![tblBookLanguage],
        bookImage = doc.data()![tblBookImage],
        hireStatus = doc.data()![tblHireStatus]
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
