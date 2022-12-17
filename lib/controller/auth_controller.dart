import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:library_managment_system/functions/shared_pref_helper.dart';
import 'package:library_managment_system/services/auth_services.dart';
import 'package:nb_utils/nb_utils.dart';

import '../database/auth_db.dart';
import '../functions/app_constants.dart';
import '../models/UserModel.dart';
import '../views/admin_home_views.dart';
import '../views/user_home_views.dart';

class AuthController extends GetxController {
  AuthDatabase authDatabase = AuthDatabase();
  AuthService authService = AuthService();
  final firebaseStorage = FirebaseStorage.instance;

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
        final querySnapshot = await authDatabase.getUserInfo(emailController.text);
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
  final userBranchCTR = TextEditingController();

  final focusEmail = FocusNode();
  final focusPassword = FocusNode();
  final selectedGender = 'Male'.obs;
  final profileImage = ''.obs;
  final profileImageName = ''.obs;
  final value = ''.obs;
  final birthDate = ''.obs;
  final branch = 'N/A'.obs;


  @override
  onInit() async {
    super.onInit();
    final result = await SPHelper.getUserIsAdminSharedPreference();
    print('AuthController.OnInit--. ${result}');
    if (result != null) {
      isAdmin.value = result;
    }
  }

  getImage(BuildContext context, ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    if (pickedImage != null) {
      profileImage.value = pickedImage.path;
      profileImageName.value = pickedImage.name;

      Navigator.pop(context);
    } else {
      toast('Select Images');
    }
  }

  registerCTR() async {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    isLoading.value = true;

    final firebasePath = firebaseStorage
        .ref(AppConstants.firebaseStorageImgPathProfile)
        .child(profileImageName.value);
    UploadTask uploadTask = firebasePath.putFile(File(profileImage.value));
    await uploadTask.whenComplete(() {});
    firebasePath.getDownloadURL().then((image) async {
      authService.registerWithEmailAndPassword(regEmailCTR.text, regPassCTR.text).then((result) async {
        if (result != null) {

          final token = await authService.getToken().then((value){

            if(userBranchCTR.text.isNotEmpty){
              branch.value = userBranchCTR.text;
            }
            if(value != null){

              print('AuthController.registerCTR->>> ${value}');

              final newUser = UserModel(
                  userName: regNameCTR.text,
                  userImage: image.toString(),
                  userEmail: regEmailCTR.text,
                  userDoB: birthDate.value.toString(),
                  userGender: selectedGender.value.toString(),
                  admin: false,
                  userRoll: userRollCTR.text,
                  issuedBooks: {},
                  applied: {},
                  userToken: value,
                  branch: branch.value.toString());
              authDatabase.addUserInfo(newUser);
              isLoading.value = false;
              SPHelper.saveUserLoggedInSharedPreference(true);
              SPHelper.saveUserIsAdminSharedPreference(false);
              SPHelper.saveUserNameSharedPreference(regNameCTR.text);
              SPHelper.saveUserEmailSharedPreference(regEmailCTR.text);
              EasyLoading.dismiss();

              Fluttertoast.showToast(
                  msg: 'Welcome! Your account created successfully.');

              Get.offAll(() => const UserHomeView());

              _clearController();

            }
          });




        } else {
          EasyLoading.dismiss();
          isLoading.value = false;
        }
      });
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

  getUserList() {
    Future<List<UserModel>> result = authDatabase.getUserList();
    return result;
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
