import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/database/book_db.dart';

class AdminHomeController extends GetxController {
  final countBook = 0.obs;
  final countIssuedBooks = 0.obs;
  final available = 0.obs;
  final countApplication = 0.obs;
  final countIssued = 0.obs;

  BookDatabase bookDatabase = BookDatabase();

  @override
  onInit() {
    super.onInit();
    countBooks();
    countIssuedBook();
    available.value = countBook.toInt() - countIssuedBooks.toInt();
    countApplicationIssuedList();
    print('AdminHomeController.available-- ${available}');
  }

  @override
  onReady() {
    countBooks();
    countIssuedBook();
    countApplicationIssuedList();

    print('AdminHomeController.onInit-- ${available}');
  }

  countApplicationIssuedList() async {
    final application = await bookDatabase.countApplication();
    countApplication.value = application;

    final issued = await bookDatabase.countIssued();
    countIssued.value = issued;
  }

  countBooks() async {
    try {
      QuerySnapshot _myDoc =
          await FirebaseFirestore.instance.collection('Books').get();
      List<DocumentSnapshot> _myDocCount = _myDoc.docs;
      num s = 0;
      for (var i = 0; i < _myDocCount.length; i++) {
        s = s + _myDocCount[i]['book_item'];
      }
      countBook.value = s.toInt();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    } // Count of Documents in Collection
  }

  countIssuedBook() async {
    try {
      QuerySnapshot _myDoc =
          await FirebaseFirestore.instance.collection('IssuedBooks').get();
      List<DocumentSnapshot> _myDocCount = _myDoc.docs;

      countIssuedBooks.value = _myDocCount.length;

      print('AdminHomeController.countIssuedBook---> ${countIssuedBooks}');
    } catch (e) {
      print('AdminHomeController.countIssuedBook---> ${e.toString()}');
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    } // Count of Documents in Collection
  }
}
