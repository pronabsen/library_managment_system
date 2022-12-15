import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/database/auth_db.dart';
import 'package:library_managment_system/database/book_db.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/models/issued_book_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../functions/app_constants.dart';
import '../models/application_model.dart';
import '../models/book_model.dart';

class BookController extends GetxController{

 // BookServices bookServices = BookServices();
  BookDatabase bookDatabase = BookDatabase();
  AuthDatabase authDatabase = AuthDatabase();
  final firebaseStorage = FirebaseStorage.instance;

  final fromKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final bookAuthorController = TextEditingController();
  final bookQuantityController = TextEditingController();
  final bookPublicationController = TextEditingController();
  final bookReleaseDate = TextEditingController();
  final bookDescriptionController = TextEditingController();
  final bookCodeController = TextEditingController();
  final uniqueBookCodeController = TextEditingController();
  final appDateController = TextEditingController();

  final appDatetext = ''.obs;
  final showOtherOption = false.obs;
  final selectedCategory = 'Action'.obs;
  final publicationDate = ''.obs;
  final id = 0.obs;
  final bookLanguage = 'English'.obs;
  final bookImage = ''.obs;
  final bookImageName = ''.obs;
  List<BookModel> bookList = <BookModel>[].obs;
  final total = 0.obs;
  final bookID = ''.obs;
  final isAvailable = true.obs;
  final isReload = false.obs;


  @override
  onInit(){
    super.onInit();
  }

  getImage(BuildContext context, ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if(pickedImage != null){
      bookImage.value = pickedImage.path;
      bookImageName.value = pickedImage.name;

      Navigator.pop(context);
    } else {
      toast('Select Images');
    }
  }

  addNewBook() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.black,);

    final firebasePath =  firebaseStorage.ref(AppConstants.firebaseStorageImgPath).child(bookImageName.value);
    UploadTask uploadTask = firebasePath.putFile(File(bookImage.value));
    await uploadTask.whenComplete((){});
    firebasePath.getDownloadURL().then((value) async {

      final newBook = BookModel(
          bookName: bookNameController.text,
          bookAuthor: bookAuthorController.text,
          categories: selectedCategory.value,
          publication: bookPublicationController.text,
          publishedDate: publicationDate.value,
          language: bookLanguage.value,
          bookImage: value.toString(),
          bookItem: bookQuantityController.text.toInt(),
          bookDescription: bookDescriptionController.text,
          bookCode: bookCodeController.text,
          borrower: {}
      );
      final addBook = await bookDatabase.addBooks(newBook);
      print('BookServices._____________ ${addBook}');
      toast('${bookNameController.text} added!');
      clearController();
      return value.toString();
    });

    EasyLoading.dismiss();

  }


  getAllApplication() {
    Future<List<ApplicationModel>> result = bookDatabase.getAllApplication();
    return result;
  }

  getAllBooks() {
    Future<List<BookModel>> bookListResult =  bookDatabase.getAllBooks();
    print('BookController.getAllBooks-> ${bookListResult}');
    return bookListResult;
  }


  getBookById(String id) {
    Future<BookModel> bookResult = bookDatabase.getBooks(id) as Future<BookModel>;
    isReload.value = false;
    return bookResult;
  }

  updateBookStatus(String id, Map<String, dynamic> value) async {
    isReload.value = true;
    final updated = await bookDatabase.updateBookStatus(id, value);
    getBookById(id);
    return updated;
  }

  getBookByCode(String bookCode) async {
   final book = await bookDatabase.getBookByCode(bookCode);
   print('BookController.getBookByCode---- ${book?.bookCode}');
    return book;
  }

  getIssuedBook() {
    Future<List<IssuedBookModel>> issuedResult = bookDatabase.getIssuedBook();
    print('BookController.getIssuedBook---. ${issuedResult}');
    return issuedResult;
  }

  getIssuedBookByCode(String uniqueCode) async {
    final issuedBook = await bookDatabase.getIssuedBookByCode(uniqueCode);
    return issuedBook;
  }

  acceptApplication(String bookCode, String borrower, String bookName ) async {
    final newIssue = IssuedBookModel(
          bookCode: bookCode,
          uniqueBookCode: uniqueBookCodeController.text,
          borrower: borrower,
          dueDate: appDatetext.toString(),
          bookName: bookName,
    );

    final addIssued = bookDatabase.addIssuedBook(newIssue);
    final bookContents = await bookDatabase.getBookByCode(bookCode);

    int newQuantity = bookContents!.bookHired.toInt() + 1;

    final updatedUserData = {
      '$tblIssuedBooks.${uniqueBookCodeController.text}': appDatetext.toString(),
    };

    final updateUser = await authDatabase.updateUser(borrower, updatedUserData);


    final updatedBookData = {
      tblBookHired: newQuantity,
      '$tblBookBorrower.${uniqueBookCodeController.text}': borrower,
    };

    final updateBook = await bookDatabase.updateBook(bookCode, updatedBookData);

    Fluttertoast.showToast(
      msg: 'Application Request Accepted',
    );
  }


  deleteApplication(BuildContext context, String bookCode, String email) async {
    try {

      Map applied = {};

      var applicationId = email + bookCode;

      final userData = await authDatabase.getUserInfo(email);

      applied = userData.applied;
      applied.remove(bookCode);

      final userUpdateData = {
        tblApplied:applied
      };

      final updateUser = authDatabase.updateUser(email, userUpdateData);
      final deleteApp = bookDatabase.deleteApplication(applicationId);

      Navigator.pop(context);

      return true;

    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }


  checkIssuedOrNot(String bookCode, String borrower) async {
    final result = await bookDatabase.checkIssued(bookCode);

    final bookInfo = await bookDatabase.getBookByCode(bookCode);

    if(bookInfo!.borrower.isEmpty){
      final userInfo = await authDatabase.getUserInfo(borrower);
      if(userInfo.applied[bookCode] != null){
        Fluttertoast.showToast(
          msg: 'You have Already Applied!',
          backgroundColor: Color(0xDDDE1B1B),);
      } else {
        String applicationId;
        applicationId = borrower+bookCode;
        print(applicationId);

        final application = ApplicationModel(
          bookCode: bookCode,
          applicationDate: DateTime.now().toString(),
          borrower: borrower,
          borrowerName: userInfo.userName,
          bookName: bookInfo.bookName,
        );

        final addApplication = await bookDatabase.addApplication(application , applicationId);
        final userData = {
          '$tblApplied.$bookCode': DateTime.now(),
        };
        final updateUser = await authDatabase.updateUser(borrower, userData);

        Fluttertoast.showToast(
          msg: 'Issuing Request Send',
          backgroundColor: Color(0xDD286053),
        );
      }
    } else {
      var isIssued = bookInfo.borrower.keys.firstWhere((element){
        if( bookInfo.borrower[element] == borrower){
          return true;
        }else{
          return false;
        }
      });

      if(isIssued != null){
        Fluttertoast.showToast(msg: 'You have Already Issued!');
      }else{

        final userInfo = await authDatabase.getUserInfo(borrower);
        if(userInfo.applied[bookCode] != null){
          Fluttertoast.showToast(
              msg: 'You have Already Applied!',
              backgroundColor: Color(0xDDDE1B1B),);
        } else {
          String applicationId;
          applicationId = borrower+bookCode;
          print(applicationId);

          final application = ApplicationModel(
            bookCode: bookCode,
            applicationDate: DateTime.now().toString(),
            borrower: borrower,
            borrowerName: userInfo.userName,
            bookName: bookInfo.bookName,
          );

          final addApplication = await bookDatabase.addApplication(application , applicationId);
          final userData = {
            '$tblApplied.$bookCode': DateTime.now(),
          };
          final updateUser = await authDatabase.updateUser(borrower, userData);

          Fluttertoast.showToast(
            msg: 'Issuing Request Send',
            backgroundColor: Color(0xDD218B21),
          );
        }

        //Fluttertoast.showToast(msg: 'You dont Already Applied!');
      }
    }


    return result;
  }

  available(int item, int hired){
    total.value = item - hired;
    return total;
  }

  itemLeft(int item, int hired){

    final numberFormat =  NumberFormat("##", "en_US");
    int total = item;
    int reserve = hired;
    double count = reserve*100/total;
    double finalResult = 100 - count;
    if(numberFormat.format(finalResult) == '100'){
      return 1.0;
    } else{
      String result = '0.${numberFormat.format(finalResult)}';
      return result.toDouble();
    }
  }

  clearController() {

    bookNameController.clear();
    bookAuthorController.clear();
    bookQuantityController.clear();
    bookPublicationController.clear();
    bookDescriptionController.clear();
    bookReleaseDate.clear();

    selectedCategory.value = 'Action';
    publicationDate.value = '';

    bookLanguage.value = 'English';

    bookImage.value = '';
    bookImageName.value = '';

  }
}