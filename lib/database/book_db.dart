import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/models/issued_book_model.dart';
import 'package:library_managment_system/models/book_model.dart';
import 'package:nb_utils/nb_utils.dart';

import '../functions/shared_pref_helper.dart';
import '../models/application_model.dart';

class BookDatabase {
  AuthController authController = Get.put(AuthController());

  final bookCollection = FirebaseFirestore.instance.collection("Books");
  final applicationCollection =
      FirebaseFirestore.instance.collection("Applications");
  final issuedBookCollection =
      FirebaseFirestore.instance.collection("IssuedBooks");

  Future<int> countApplication() async {
    int application = 0;
    int total = application;

    final result = await applicationCollection.get();
    if (result.docs.isNotEmpty) {
      total = result.docs.length + application;
    }
    return total;
  }

  Future<int> countIssued() async {
    int issued = 0;
    int total = issued;

    final result = await issuedBookCollection.get();
    if (result.docs.isNotEmpty) {
      total = result.docs.length + issued;
    }
    return total;
  }

  Future addBooks(BookModel bookModel) async {
    bookCollection.doc(bookModel.bookCode).set(bookModel.toMap()).then((value) {
      Fluttertoast.showToast(msg: 'Book Added');
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  Future<List<BookModel>> getAllBooks() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await bookCollection.get();

    return snapshot.docs.map((e) => BookModel.fromDocumentSnapshot(e)).toList();
  }

  Future<IssuedBookModel?> checkIssued(String bookCode) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await issuedBookCollection.where('bookCode', isEqualTo: bookCode).get();

    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return snapshot.docs
          .map((e) => IssuedBookModel.fromDocumentSnapshot(e))
          .first;
    }
  }

  Future<BookModel> getBooks(String docID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await bookCollection.doc(docID).get();
    return BookModel.fromMap(snapshot.data());
  }

  Future<BookModel?> getBookByCode(String code) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await bookCollection.doc(code).get();

    print('BookDatabase.getBookByCode---- ${snapshot}');
    if (snapshot.data() == null) {
      return null;
    } else {
      return BookModel.fromMap(snapshot.data());
    }
  }

  Future<bool?> deleteBook(String code) async {
    await bookCollection.doc(code).delete();
    return true;
  }

  Future<List<IssuedBookModel>> getIssuedBook() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await issuedBookCollection.get();

    return snapshot.docs
        .map((e) => IssuedBookModel.fromDocumentSnapshot(e))
        .toList();
  }

  Future<IssuedBookModel?> getIssuedBookByCode(String code) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await issuedBookCollection.doc(code).get();
    print('BookDatabase.getIssuedBookByCode---- ${snapshot}');

    if (snapshot.data() == null) {
      return null;
    } else {
      return IssuedBookModel.fromMap(snapshot.data());
    }
  }

  Future updateBooksDetails(BookModel bookModel) async {
    return await bookCollection
        .doc(bookModel.bookCode)
        .update(bookModel.toMap());
  }

  Future updateBookStatus(String id, Map<String, dynamic> value) async {
    await bookCollection.doc(id).update(value).whenComplete(() {
      toast('Book Status Updated!');
    }).catchError((e) {
      print(e);
      return false;
    });

    return true;
  }

  Future deleteIssuedFromBook(String bookCode, String uniqueBookCode) async {
    int newQuantity;
    Map borrowerList = {};

    final bookData = await bookCollection.doc(bookCode).get();
    borrowerList = bookData.data()![tblBookBorrower];
    newQuantity = bookData.data()![tblBookHired] - 1;
    borrowerList.remove(uniqueBookCode);

    final result = bookCollection.doc(bookCode).update({
      tblBookBorrower: borrowerList,
      tblBookHired: newQuantity,
    });

    return result;
  }

  Future addApplication(
      ApplicationModel applicationModel, String applicationId) async {
    applicationCollection
        .doc(applicationId)
        .set(applicationModel.toMap())
        .then((value) {
      // Fluttertoast.showToast(msg: 'Book Added');
    }).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  Future<List<ApplicationModel>> getAllApplication() async {
    var result = await applicationCollection.get();
    return result.docs
        .map((e) => ApplicationModel.fromDocumentSnapshot(e))
        .toList();
  }

  Future<List<ApplicationModel>> getUserApplicationList() async {

    final user = await SPHelper.getUserEmailSharedPreference();
    final snapshot =
        await applicationCollection.where('borrower', isEqualTo: user).get();

    return snapshot.docs
        .map((e) => ApplicationModel.fromDocumentSnapshot(e))
        .toList();
  }

  Future<List<IssuedBookModel>> getUserIssuedList() async {

    final user = await SPHelper.getUserEmailSharedPreference();
    final snapshot =
        await issuedBookCollection.where('borrower', isEqualTo: user).get();

    return snapshot.docs
        .map((e) => IssuedBookModel.fromDocumentSnapshot(e))
        .toList();
  }


  Future<List<ApplicationModel>> getApplicationListByUser(String userEmail) async {

    authController.userBookRequested.value = 0;
    final snapshot =
        await applicationCollection.where('borrower', isEqualTo: userEmail).get();

    authController.userBookRequested.value = snapshot.docs.length;

    return snapshot.docs
        .map((e) => ApplicationModel.fromDocumentSnapshot(e))
        .toList();
  }

  Future<List<IssuedBookModel>> getIssuedListByUser(String userEmail) async {

    authController.userBookIssued.value = 0;
    final snapshot =
        await issuedBookCollection.where('borrower', isEqualTo: userEmail).get();

    authController.userBookIssued.value = snapshot.docs.length;

    return snapshot.docs
        .map((e) => IssuedBookModel.fromDocumentSnapshot(e))
        .toList();
  }

  Future deleteApplication(String applicationId) async {
    return await applicationCollection.doc(applicationId).delete();
  }

  Future deleteIssued(String uniqueBookCode) async {
    return await issuedBookCollection.doc(uniqueBookCode).delete();
  }

  Future addIssuedBook(IssuedBookModel issuedBookModel) async {
    return issuedBookCollection
        .doc(issuedBookModel.uniqueBookCode)
        .set(issuedBookModel.toMap())
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
  }

  Future updateBook(String bookCode, Map<String, dynamic> doc) async {
    final result = bookCollection
        .doc(bookCode)
        .update(doc)
        .then((value) {})
        .catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });

    return result;
  }


}
