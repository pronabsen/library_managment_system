import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_managment_system/models/book_hried_model.dart';
import 'package:library_managment_system/models/book_model.dart';
import 'package:nb_utils/nb_utils.dart';

class BookDatabase{

  final bookCollection =  FirebaseFirestore.instance.collection("Books");


  Future addBooks(BookModel bookModel) async {
    bookCollection.add(bookModel.toMap()).then((value){
      return value;
    }).catchError((e) {
      print(e.toString());
      return false;
    });
  }

  Future<List<BookModel>> getAllBooks() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await bookCollection.get();

    return snapshot.docs.map((e) => BookModel.fromDocumentSnapshot(e)).toList();
  }

  Future<BookModel> getBooks(String docID) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await bookCollection.doc(docID).get();
    return BookModel.fromMap(snapshot.data(), docID);
  }


  Future updateBooksDetails(BookModel bookModel) async {
   return await bookCollection.doc(bookModel.id).update(bookModel.toMap());
  }


  Future updateBookStatus(String id, Map<String, dynamic> value) async {
    await bookCollection.doc(id).update(value).whenComplete((){
      toast('Book Status Updated!');

    }).catchError((e){
      print(e);
      return false;
    });

    return true;
  }


  Future addBookHired(BookHireModel bookHireModel) async {



    bookCollection.add(bookHireModel.toMap()).then((value){
      return value;
    }).catchError((e) {
      print(e.toString());
      return false;
    });
  }

}