import 'package:get/get.dart';
import 'package:library_managment_system/old/controller/auth_controller.dart';
import 'package:library_managment_system/old/functions/shared_pref_helper.dart';
import 'package:library_managment_system/old/services/auth_services.dart';
import 'package:library_managment_system/old/utils/sp_tools.dart';
import 'package:library_managment_system/old/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/auth_db.dart';

class HomeController extends GetxController{

  AuthDatabase authDatabase = AuthDatabase();
  AuthService authService = AuthService();

  final title = 'Home'.obs;
  final userName = 'avc'.obs;
  final userEmail = ''.obs;
  final userImage = ''.obs;
  final isAdmin = false.obs;

  @override
  void onReady() {
    super.onReady();
    this.loadData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onInit() async {
    this.loadData();
    super.onInit();
  }

  @override
  void dispose() {
    Get.delete<HomeController>();
    Get.delete<AuthController>();
    super.dispose();
  }

  loadData() async {

    final querySnapshot = await authDatabase.getUserInfo(await SPHelper.getUserEmailSharedPreference());

    userName.value = querySnapshot.userName;
    userEmail.value = querySnapshot.userEmail;
    userImage.value = querySnapshot.userImage;
    isAdmin.value = querySnapshot.admin;
    return querySnapshot;
    print('HomeController.loadData--> ${userEmail}');
  }


  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    authService.signOut();
    preferences.clear();

    Get.to(() => Login());

  }
}