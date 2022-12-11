import 'package:cloud_firestore/cloud_firestore.dart';

const String tblUserId = 'user_id';
const String tblUserName = 'user_name';
const String tblUserImage = 'user_image';
const String tblUserEmail = 'user_email';
const String tblUserPassword = 'user_password';
const String tblUserDOB = 'user_dob';
const String tblUserGender = 'user_gender';
const String tblUserAdmin = 'admin';
const String tblUserTrash = 'trash';

class UserModel {
  final String? userId;
  final String userName;
  final String userImage;
  final String userEmail;
  final String userPassword;
  final String userDoB;
  final String userGender;
  final bool admin;
  final bool trash;

  UserModel({
    this.userId,
    required this.userName,
    this.userImage = 'null',
    required this.userEmail,
    required this.userPassword,
    required this.userDoB,
    required this.userGender,
    required this.admin,
    required this.trash,
  });

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblUserName : userName,
      tblUserImage : userImage,
      tblUserEmail : userEmail,
      tblUserPassword : userPassword,
      tblUserDOB : userDoB,
      tblUserGender : userGender,
      tblUserAdmin : admin == null ? 0 : admin == true ? 1 : 0,
      tblUserTrash : trash == null ? 0 : trash == true ? 1 : 0,
    };
    if(userId != null) {
      map[tblUserId] = userId;
    }
    return map;
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : userId = doc.id,
        userName = doc.data()![tblUserName],
        userEmail = doc.data()![tblUserEmail],
        userImage = doc.data()![tblUserImage],
        userPassword = doc.data()![tblUserPassword],
        userDoB = doc.data()![tblUserDOB],
        userGender = doc.data()![tblUserGender],
        admin = doc.data()![tblUserAdmin] == 0 ? false : true,
        trash = doc.data()![tblUserTrash] == 0 ? false : true
  ;


}
