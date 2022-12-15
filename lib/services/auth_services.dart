import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var currentUser = FirebaseAuth.instance.currentUser;

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //   User? user = result.user.uid;
      return result.user?.uid;
    } catch (e) {
      //   var error = e.toString().replaceAll(e.toString(), 'The email address is already in use by another account');
      toast('The email address is already in use by another account');
      print(e);
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //User? user = result.user;
      return result.user?.uid;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
