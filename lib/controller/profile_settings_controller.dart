import 'package:get/get.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/services/auth_services.dart';
import 'package:library_managment_system/views/login_views.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/auth_db.dart';
import '../functions/shared_pref_helper.dart';

class ProfileSettingsController extends GetxController {


  AuthDatabase authDatabase = AuthDatabase();
  AuthService authService = AuthService();


  final userName = ''.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;
  final isAdmin = false.obs;

  UserModel ? userModel;

  @override
  void onReady() {
    loadData();
    super.onReady();
  }

  @override
  void onClose() {
    loadData();
    super.onClose();
  }

  @override
  void onInit() async {
    loadData();
    super.onInit();
  }


  loadData() async {

    final querySnapshot = await authDatabase.getUserInfo(await SPHelper.getUserEmailSharedPreference());

    userName.value = querySnapshot.userName;
    userEmail.value = querySnapshot.userEmail;
    userImage.value = querySnapshot.userImage;
    isAdmin.value = querySnapshot.admin;

    userModel =  UserModel.fromMap(querySnapshot.toMap());
    print('ProfileSettingsController.loadData----> ${userImage.value}');

    return querySnapshot;
  }
  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    authService.signOut();
    preferences.clear();

    Get.offAll(() => LoginView());
    Get.deleteAll();

  }

}