import 'package:cloud_firestore/cloud_firestore.dart';

const String tblUserName = 'userName';
const String tblUserImage = 'userImage';
const String tblUserEmail = 'userEmail';

const String tblUserRoll = 'userRoll';
const String tblIssuedBooks = 'issuedBooks';
const String tblApplied = 'applied';
const String tblBranch = 'branch';

const String tblUserDOB = 'userDob';
const String tblUserGender = 'userGender';
const String tblUserAdmin = 'admin';

class UserModel {
  final String userName;
  final String userImage;
  final String userEmail;

  final String userRoll;
  Map issuedBooks = {};
  Map applied = {};
  final String branch;

  final String userDoB;
  final String userGender;
  final bool admin;

  UserModel({
    required this.userName,
    this.userImage = 'null',
    required this.userEmail,
    required this.userRoll,
    required this.issuedBooks,
    required this.applied,
    this.branch = 'Admin',
    required this.userDoB,
    required this.userGender,
    required this.admin
  });

  Map<String, dynamic> toMap() {
    final map = <String,dynamic>{
      tblUserName : userName,
      tblUserImage : userImage,
      tblUserEmail : userEmail,

      tblUserRoll : userRoll,
      tblIssuedBooks : issuedBooks,
      tblApplied : applied,
      tblBranch : branch,

      tblUserDOB : userDoB,
      tblUserGender : userGender,
      tblUserAdmin : admin == null ? 0 : admin == true ? 1 : 0,
    };
    return map;
  }

  UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : userName = doc.data()![tblUserName],
        userEmail = doc.data()![tblUserEmail],
        userImage = doc.data()![tblUserImage],

        userRoll = doc.data()![tblUserRoll],
        issuedBooks = doc.data()![tblIssuedBooks],
        applied = doc.data()![tblApplied],
        branch = doc.data()![tblBranch],

        userDoB = doc.data()![tblUserDOB],
        userGender = doc.data()![tblUserGender],
        admin = doc.data()![tblUserAdmin] == 0 ? false : true
  ;

  UserModel.fromMap(Map<String, dynamic>? doc)
      : userName = doc![tblUserName],
        userEmail = doc[tblUserEmail],
        userImage = doc[tblUserImage],

        userRoll = doc[tblUserRoll],
        issuedBooks = doc[tblIssuedBooks],
        applied = doc[tblApplied],
        branch = doc[tblBranch],

        userDoB = doc[tblUserDOB],
        userGender = doc[tblUserGender],
        admin = doc[tblUserAdmin] == 0 ? false : true
  ;


}
