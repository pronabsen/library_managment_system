import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  String errorMessage = '';

  Future getToken() async {
    return await firebaseMessaging.getToken();
  }

  Future registerWithEmailAndPassword(String email, String password) async {


    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //   User? user = result.user.uid;
      return result.user?.email;
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "The email address is already in use by another account";
          break;
          case "account-exists-with-different-credential":
          errorMessage = "The email address is already in use by another account";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      if (errorMessage.isNotEmpty) {
        Fluttertoast.showToast(msg: errorMessage, backgroundColor: Colors.redAccent);
        return null;
      }
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      //User? user = result.user;
      return result.user?.uid;
    }  on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "The email address is already in use by another account";
          break;
        case "account-exists-with-different-credential":
          errorMessage = "The email address is already in use by another account";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      if (errorMessage.isNotEmpty) {
        Fluttertoast.showToast(msg: errorMessage, backgroundColor: Colors.redAccent);
        return null;
      }
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    }  on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "email-already-in-use":
          errorMessage = "The email address is already in use by another account";
          break;
        case "account-exists-with-different-credential":
          errorMessage = "The email address is already in use by another account";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      if (errorMessage.isNotEmpty) {
        Fluttertoast.showToast(msg: errorMessage, backgroundColor: Colors.redAccent);
        return null;
      }
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
