import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/old/services/book_services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../database/book_db.dart';
import '../../models/book_model.dart';
import '../functions/app_constants.dart';

class BookController extends GetxController{


  BookServices bookServices = BookServices();
  BookDatabase bookDatabase = BookDatabase();
  final firebaseStorage = FirebaseStorage.instance;

  final fromKey = GlobalKey<FormState>();
  final bookNameController = TextEditingController();
  final bookAuthorController = TextEditingController();
  final bookQuantityController = TextEditingController();
  final bookPublicationController = TextEditingController();
  final bookReleaseDate = TextEditingController();
  final bookDescriptionController = TextEditingController();

  final selectedCategory = 'Action'.obs;
  final publicationDate = ''.obs;
  final id = 0.obs;
  final bookLanguage = 'English'.obs;

  final bookImage = ''.obs;
  final bookImageName = ''.obs;


  List<BookModel> bookList = <BookModel>[].obs;
  final total = 0.obs;
  final bookID = ''.obs;


  final isReload = false.obs;


  dynamic argumentData = Get.arguments;


  @override
  onInit(){
    super.onInit();
  }

  getImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if(pickedImage != null){
      bookImage.value = pickedImage.path;
      bookImageName.value = pickedImage.name;
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
          bookCode: '',
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


  getAllBooks() {
    Future<List<BookModel>> bookListResult =  bookDatabase.getAllBooks();
    return bookListResult;
  }


  getBookById(String id) {
 //   bookID.value = id;

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

  borrowBook(){

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