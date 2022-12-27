import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/database/auth_db.dart';
import 'package:library_managment_system/database/book_db.dart';
import 'package:library_managment_system/functions/shared_pref_helper.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/models/issued_book_model.dart';
import 'package:library_managment_system/services/fcm_messaging_services.dart';
import 'package:library_managment_system/views/pdf_invoice.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:collection/collection.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import '../functions/app_constants.dart';
import '../models/application_model.dart';
import '../models/book_model.dart';
import 'package:path/path.dart' as Path;

import '../views/admin_home_views.dart';

class BookController extends GetxController {
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

  final dueDateText = DateTime.now().obs;
  final issueDateText = DateTime.now().obs;
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
  final isDownloading = false.obs;
  final downloadingProgress = 0.0.obs;

  final bookImages = [].obs;

  final bookImageLink = [].obs;

  final uploading = false.obs;
  final uploadingProgress = 0.0.obs;

  @override
  onInit() {
    uploadingProgress.value = 0.0;
    super.onInit();
  }

  chooseImage(BuildContext context) async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    bookImages.add(pickedFile!.path);

    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker().retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      bookImages.add(response.file!.path);
    } else {
    }
  }


  Future<void> downloadFile(String fileName) async {

    final firebasePath = firebaseStorage
        .ref(AppConstants.firebaseStorageImgPathInvoices)
        .child(fileName);

    print('BookController.downloadFile--> $fileName');

    final dir = (await getExternalStorageDirectory())?.path;
    final path = '$dir/$fileName';
    final File tempFile = File(path);

    try {
      await firebasePath.writeToFile(tempFile);
      await tempFile.create();
      await OpenFile.open(tempFile.path);
    } on FirebaseException catch(e) {
      print('BookController.downloadFileerror --> ${e.toString()}');
      Fluttertoast.showToast(msg: 'Error!');
    }

  }

  Future uploadFile() async {
    int i = 1;

    bookImageLink.clear();

    for (var images in bookImages) {
      uploading.value = true;

      uploadingProgress.value = i / bookImages.length;

      final firebasePath = firebaseStorage
          .ref(AppConstants.firebaseStorageImgPath)
          .child(Path.basename(images));

      await firebasePath.putFile(File(images)).whenComplete(() async {
        await firebasePath.getDownloadURL().then((value) {
          bookImageLink.add({'url' : value});
         //bookImages.removeAt(images);
          i++;
        });
      });
    }

  }

  getImage(BuildContext context, ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      bookImage.value = pickedImage.path;
      bookImageName.value = pickedImage.name;

      Navigator.pop(context);
    } else {
      toast('Select Images');
    }
  }

  addNewBook() async {

    try{
      if(bookImageLink.isEmpty){

        Fluttertoast.showToast(msg: 'Please Upload Image!', backgroundColor: Colors.red);
      }else {
        EasyLoading.show(
          maskType: EasyLoadingMaskType.black,
        );

        final newBook = BookModel(
          bookName: bookNameController.text,
          bookAuthor: bookAuthorController.text,
          categories: selectedCategory.value,
          publication: bookPublicationController.text,
          publishedDate: publicationDate.value,
          language: bookLanguage.value,
          bookItem: bookQuantityController.text.toInt(),
          bookDescription: bookDescriptionController.text,
          bookCode: bookCodeController.text,
          borrower: {},
          bookImages: bookImageLink.value,

          // bookImages: {}
        );


        final addBook = await bookDatabase.addBooks(newBook);

        Fluttertoast.showToast(msg: '${bookNameController.text} added!', backgroundColor: Colors.green);
        bookImageLink.clear();
        clearController();
        EasyLoading.dismiss();

        return true;

      }

    } catch(e){

      Fluttertoast.showToast(msg: e.toString());
    }

  }

  getAllApplication() {
    Future<List<ApplicationModel>> result = bookDatabase.getAllApplication();
    return result;
  }

  getAllBooks() {
    Future<List<BookModel>> bookListResult = bookDatabase.getAllBooks();
    return bookListResult;
  }

  getBookById(String id) {
    Future<BookModel> bookResult =bookDatabase.getBooks(id);
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
    return book;
  }
  deleteBook(String bookCode) async {
    final book = await bookDatabase.deleteBook(bookCode);

    if(book != null){
      Fluttertoast.showToast(msg: 'Book Deleted', backgroundColor: Colors.green);
      Get.off(() => const AdminHomeView());
    }

    return book;
  }

  getIssuedBook() {
    isReload.value = true;

    Future<List<IssuedBookModel>> issuedResult = bookDatabase.getIssuedBook();

    isReload.value = false;
    return issuedResult;
  }

  getIssuedBookByCode(String uniqueCode) async {
    final issuedBook = await bookDatabase.getIssuedBookByCode(uniqueCode);
    return issuedBook;
  }

  acceptApplication(String bookCode, String userName, String borrower, String bookName) async {


    final book = await bookDatabase.getBookByCode(bookCode);
    final bookContents = await bookDatabase.getBookByCode(bookCode);
    int newQuantity = bookContents!.bookHired.toInt() + 1;
    final updatedUserData = {
      '$tblIssuedBooks.${uniqueBookCodeController.text}':
          dueDateText.value,
    };
    final updateUser = await authDatabase.updateUser(borrower, updatedUserData);
    final updatedBookData = {
      tblBookHired: newQuantity,
      '$tblBookBorrower.${uniqueBookCodeController.text}': borrower,
    };
    final updateBook = await bookDatabase.updateBook(bookCode, updatedBookData);
    final dir = (await getApplicationDocumentsDirectory()).path;
    final path = '$dir/invoice_${uniqueBookCodeController.text}_.pdf';

    final File file = File(path);
    Uint8List bytes = await generateInvoice(
        book!,
        await SPHelper.getUserNameSharedPreference(),
        uniqueBookCodeController.text,
        userName,
        borrower,
        issueDateText.value,
        dueDateText.value
    );

    await file.writeAsBytes(bytes).whenComplete(() async {


      final firebasePath = firebaseStorage
          .ref(AppConstants.firebaseStorageImgPathInvoices)
          .child('invoice_${uniqueBookCodeController.text}_.pdf');

      await firebasePath.putFile(File(path)).whenComplete(() async {

        await firebasePath.getDownloadURL().then((pdfUrlLink) {

          final newIssue = IssuedBookModel(
            bookCode: bookCode,
            uniqueBookCode: uniqueBookCodeController.text,
            borrower: borrower,
            dueDate: dueDateText.value,
            bookName: bookName,
            issuedDate: issueDateText.value,
            pdfUrl: pdfUrlLink,
          );

          final addIssued = bookDatabase.addIssuedBook(newIssue);

          Fluttertoast.showToast(
            msg: 'Application Request Accepted',
          );
          uniqueBookCodeController.clear();
          dueDateText.value = DateTime.now();
          issueDateText.value = DateTime.now();

        });



      });


    });


  }

  deleteApplication(BuildContext context, String bookCode, String email) async {
    try {
      Map applied = {};

      var applicationId = email + bookCode;

      final userData = await authDatabase.getUserInfo(email);

      applied = userData.applied;
      applied.remove(bookCode);

      final userUpdateData = {tblApplied: applied};

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
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );

    final result = await bookDatabase.checkIssued(bookCode);

    final bookInfo = await bookDatabase.getBookByCode(bookCode);

    var isIssued = bookInfo?.borrower.keys.firstWhere((key) => bookInfo.borrower[key] == borrower,
        orElse: () => '');

     if (isIssued != '' ) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(msg: 'You have Already Issued!');
      } else {
        final userInfo = await authDatabase.getUserInfo(borrower);
        if (userInfo.applied[bookCode] != null) {
          EasyLoading.dismiss();
          Fluttertoast.showToast(
            msg: 'You have Already Applied!',
            backgroundColor: Color(0xDDDE1B1B),
          );
        } else {
          String applicationId;
          applicationId = borrower + bookCode;

          final application = ApplicationModel(
            bookCode: bookCode,
            applicationDate: DateTime.now().toString(),
            borrower: borrower,
            borrowerName: userInfo.userName,
            bookName: bookInfo!.bookName,
          );

          final addApplication =
              await bookDatabase.addApplication(application, applicationId);
          final userData = {
            '$tblApplied.$bookCode': DateTime.now(),
          };
          final updateUser = await authDatabase.updateUser(borrower, userData);

          UserModel userModel = await authDatabase.getAdmin();
          FCMServices.sendPushMessage(
              userModel.userToken, 'New Book Request!',
              '${userInfo.userName}, requested for ${bookInfo.bookName} #$bookCode!');


          EasyLoading.dismiss();
          Fluttertoast.showToast(
            msg: 'Issuing Request Send',
            backgroundColor: const Color(0xDD218B21),
          );
        }
      }

   /* if (bookInfo!.borrower.isEmpty) {
      final userInfo = await authDatabase.getUserInfo(borrower);
      if (userInfo.applied[bookCode] != null) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: 'You have Already Applied!',
          backgroundColor: Color(0xDDDE1B1B),
        );
      } else {
        String applicationId;
        applicationId = borrower + bookCode;
        print(applicationId);

        final application = ApplicationModel(
          bookCode: bookCode,
          applicationDate: DateTime.now().toString(),
          borrower: borrower,
          borrowerName: userInfo.userName,
          bookName: bookInfo.bookName,
        );

        final addApplication =
            await bookDatabase.addApplication(application, applicationId);
        final userData = {
          '$tblApplied.$bookCode': DateTime.now(),
        };
        final updateUser = await authDatabase.updateUser(borrower, userData);

        EasyLoading.dismiss();
        Fluttertoast.showToast(
          msg: 'Issuing Request Send',
          backgroundColor: Color(0xDD286053),
        );
      }
    } else {






    }*/

    return result;
  }

  deleteIssue(BuildContext context, String uniqueBookCode, String borrower,
      String bookCode) async {
    try {
      Map issuedBooks = {};
      Map borrowerList = {};

      final userData =
          await authDatabase.deleteIssueFromUser(borrower, uniqueBookCode);
      final bookData =
          await bookDatabase.deleteIssuedFromBook(bookCode, uniqueBookCode);
      final issuedBook = await bookDatabase.deleteIssued(uniqueBookCode);

      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Issued Books Updated!',
      );

      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }


  getUserApplication() {
    final result = bookDatabase.getUserApplicationList();
    return result;
  }

  getUserIssued() {
    final result = bookDatabase.getUserIssuedList();
    return result;
  }

  getApplicationByUser(String userEmail) {
    final result = bookDatabase.getApplicationListByUser(userEmail);
    return result;
  }

  getIssuedByUser(String userEmail) {
    final result = bookDatabase.getIssuedListByUser(userEmail);

    return result;
  }

  available(int item, int hired) {
    total.value = item - hired;
    return total;
  }

  itemLeft(int item, int hired) {
    final numberFormat = NumberFormat("##", "en_US");
    int total = item;
    int reserve = hired;
    double count = reserve * 100 / total;
    double finalResult = 100 - count;

    if (numberFormat.format(finalResult) == '100') {
      return 1.0;
    } else {
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
