import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:library_managment_system/functions/shared_pref_helper.dart';
import 'package:library_managment_system/services/auth_services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../database/auth_db.dart';
import '../models/UserModel.dart';
import '../views/admin_home_views.dart';
import '../views/user_home_views.dart';

class AuthController extends GetxController {
  AuthDatabase authDatabase = AuthDatabase();
  AuthService authService = AuthService();

  final isLoading = false.obs;
  final isAdmin = false.obs;

  //Login
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isIconTrue = false.obs;
  final isChecked = false.obs;
  final checkBoxValue = false.obs;
//  final f1 = FocusNode();
  // final f2 = FocusNode();

  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;

  loginCTR() {
    //Get.to(()=> AddBook());

    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    isLoading.value = true;

    authService
        .loginWithEmailAndPassword(
            emailController.text, passwordController.text)
        .then((value) async {
      if (value != null) {
        final querySnapshot =
            await authDatabase.getUserInfo(emailController.text);
        isAdmin.value = querySnapshot.admin;
        SPHelper.saveUserLoggedInSharedPreference(true);
        SPHelper.saveUserNameSharedPreference(querySnapshot.userName);
        SPHelper.saveUserEmailSharedPreference(querySnapshot.userEmail);
        SPHelper.saveUserIsAdminSharedPreference(querySnapshot.admin);
        EasyLoading.dismiss();
        toast('Welcome Back! ${querySnapshot.userName}');
        isLoading.value = false;

        //   Get.to(Home());

        if (querySnapshot.admin) {
          Get.offAll(() => const AdminHomeView());
        } else {
          Get.offAll(() => const UserHomeView());
        }
        _clearController();
      } else {
        EasyLoading.dismiss();
        isLoading.value = false;
        toast(
            'There is no user record corresponding to this identifier. The user may have been deleted');
      }
    });
  }

  //Registration
  final formRegKey = GlobalKey<FormState>();
  final regEmailCTR = TextEditingController();
  final regPassCTR = TextEditingController();
  final regNameCTR = TextEditingController();
  final birthDateCTR = TextEditingController();
  final userRollCTR = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();
  final selectedGender = 'Male'.obs;
  final value = ''.obs;
  final birthDate = ''.obs;

  registerCTR() async {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    isLoading.value = true;
    authService
        .registerWithEmailAndPassword(regEmailCTR.text, regPassCTR.text)
        .then((result) {
      if (result != null) {
        final newUser = UserModel(
            userName: regNameCTR.text,
            userImage: 'null',
            userEmail: regEmailCTR.text,
            userDoB: birthDate.value.toString(),
            userGender: selectedGender.value.toString(),
            admin: false,
            userRoll: userRollCTR.text,
            issuedBooks: {},
            applied: {});
        authDatabase.addUserInfo(newUser);
        isLoading.value = false;
        SPHelper.saveUserLoggedInSharedPreference(true);
        SPHelper.saveUserNameSharedPreference(regNameCTR.text);
        SPHelper.saveUserEmailSharedPreference(regEmailCTR.text);
        EasyLoading.dismiss();

        Fluttertoast.showToast(
            msg: 'Welcome! Your account created successfully.');
        //  Get.to(Home());

        //_clearController();

      } else {
        EasyLoading.dismiss();
        isLoading.value = false;
      }
    });
  }

  _clearController() {
    emailController.clear();
    passwordController.clear();
    regEmailCTR.clear();
    regPassCTR.clear();
    regNameCTR.clear();
    birthDateCTR.clear();

    selectedGender.value = 'Male';
    birthDate.value = '';
  }

  getUserInfo(String email) async {
    final querySnapshot = await authDatabase.getUserInfo(email);
    return querySnapshot;
  }

  @override
  void onClose() {
    print('AuthController.onClose');
    super.onClose();
    //   Get.delete<AuthController>();
  }

  @override
  void dispose() {
    print('AuthController.dispose');
    super.dispose();
    Get.delete<AuthController>();
  }
}
