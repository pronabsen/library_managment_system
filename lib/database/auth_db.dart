import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:library_managment_system/models/UserModel.dart';

class AuthDatabase {

  final userCollection =  FirebaseFirestore.instance.collection("Users");


  Future<void> addUserInfo(UserModel userModel) async {
    userCollection.add(userModel.toMap()).catchError((e) {
      print(e.toString());
    });
  }

   getUserInfos(String email) async {
    return userCollection.where(tblUserEmail, isEqualTo: email).get().catchError((e) {
      print(e.toString());
    });
  }

  Future<UserModel> getUserInfo(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await userCollection.where(tblUserEmail, isEqualTo: email).get();
    return snapshot.docs.map((e) => UserModel.fromDocumentSnapshot(e)).first;
  }

}