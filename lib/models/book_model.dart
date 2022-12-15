import 'package:cloud_firestore/cloud_firestore.dart';

const String tblBookCode = 'bookCode';
const String tblBookName = 'book_name';
const String tblBookAuthor = 'book_author';
const String tblBookCategories = 'categories';
const String tblBookPublications = 'publication';
const String tblBookPublishedDate = 'publish_date';
const String tblBookLanguage = 'language';
const String tblBookImage = 'book_image';
const String tblBookItem = 'book_item';
const String tblBookHired = 'book_hired';
const String tblBookDescription = 'descriptions';
const String tblBookBorrower = 'borrower';

class BookModel {
  final String bookCode;

  final String bookName;
  final String bookAuthor;
  final String categories;
  final String publication;
  final String publishedDate;
  final String language;
  final String bookImage;
  final String bookDescription;
  final int bookItem;
  final int bookHired;
  Map borrower = {};

  BookModel(
      {required this.bookCode,
      required this.bookName,
      required this.bookAuthor,
      required this.categories,
      required this.publication,
      required this.publishedDate,
      required this.language,
      required this.bookImage,
      required this.bookDescription,
      required this.bookItem,
      this.bookHired = 0,
      required this.borrower});

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblBookCode: bookCode,
      tblBookName: bookName,
      tblBookAuthor: bookAuthor,
      tblBookCategories: categories,
      tblBookPublications: publication,
      tblBookPublishedDate: publishedDate,
      tblBookLanguage: language,
      tblBookImage: bookImage,
      tblBookItem: bookItem,
      tblBookHired: bookHired,
      tblBookDescription: bookDescription,
      tblBookBorrower: borrower,
    };
    return map;
  }

  BookModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : bookCode = doc.data()![tblBookCode],
        bookName = doc.data()![tblBookName],
        bookAuthor = doc.data()![tblBookAuthor],
        categories = doc.data()![tblBookCategories],
        publication = doc.data()![tblBookPublications],
        publishedDate = doc.data()![tblBookPublishedDate],
        language = doc.data()![tblBookLanguage],
        bookImage = doc.data()![tblBookImage],
        bookItem = doc.data()![tblBookItem],
        bookHired = doc.data()![tblBookHired],
        bookDescription = doc.data()![tblBookDescription],
        borrower = doc.data()![tblBookBorrower];

  BookModel.fromMap(Map<String, dynamic>? doc)
      : bookCode = doc![tblBookCode],
        bookName = doc[tblBookName],
        bookAuthor = doc[tblBookAuthor],
        categories = doc[tblBookCategories],
        publication = doc[tblBookPublications],
        publishedDate = doc[tblBookPublishedDate],
        language = doc[tblBookLanguage],
        bookImage = doc[tblBookImage],
        bookItem = doc[tblBookItem],
        bookHired = doc[tblBookHired],
        bookDescription = doc[tblBookDescription],
        borrower = doc[tblBookBorrower];
}
