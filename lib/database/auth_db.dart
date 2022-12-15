import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_managment_system/models/UserModel.dart';

class AuthDatabase {
  final userCollection = FirebaseFirestore.instance.collection("Users");

  Future<void> addUserInfo(UserModel userModel) async {
    userCollection
        .doc(userModel.userEmail)
        .set(userModel.toMap())
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<UserModel> getUserInfo(String email) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userCollection.doc(email).get();
    return UserModel.fromMap(snapshot.data());
  }

  Future getUserInfoForProfile(String email) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await userCollection.doc(email).get();
    return snapshot.data();
  }

  Future updateUser(String email, Map<String, dynamic> doc) async {
    return userCollection.doc(email).update(doc).catchError((onError) {
      Fluttertoast.showToast(msg: onError.toString());
    });
  }
}
