import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/views/registration_view.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/auth_controller.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/widgets.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);


  AuthController authController = Get.put(AuthController());
  final formKey = AuthController().formKey;

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: careaAppBarWidget(context),
      body: Obx((){
        return Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(height: 130, width: 130, fit: BoxFit.fitWidth, image: AssetImage('assets/app_icon.png')),
                  Text('Login to Your Account', style: boldTextStyle(size: 24)),
                  const SizedBox(height: 30),
                  TextFormField(
                    autofocus: false,
                    validator: (value) {
                      if (!value!.contains('@')) {
                        return 'Please enter the correct email';
                      }
                      return null;
                    },
                    //    focusNode: authController.focusEmail,
                    autofillHints: const [AutofillHints.email],
                    onFieldSubmitted: (v) {
                      authController.focusEmail.unfocus();
                      FocusScope.of(context).requestFocus(authController.focusPassword);
                    },
                    controller: authController.emailController,
                    decoration: inputDecoration(context, prefixIcon: Icons.mail_rounded, hintText: "Email"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: authController.passwordController,
                    obscureText: authController.isIconTrue.value,
                    //   autofocus: false,
                    //   focusNode: authController.focusPassword,
                    validator: (value){
                      if (value!.isEmpty) {
                        return "* Required";
                      } else {
                        return null;
                      }
                    },
                    decoration: inputDecoration(
                      context,
                      prefixIcon: Icons.lock,
                      hintText: "Password",
                      suffixIcon: Theme(
                        data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            authController.isIconTrue.value = false;
                          },
                          icon: Icon(
                            (authController.isIconTrue.isTrue) ? Icons.visibility_rounded : Icons.visibility_off,
                            size: 16,
                            color: gray,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Theme(
                    data: ThemeData(unselectedWidgetColor: appStore.isDarkModeOn ? Colors.white : black),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.all(0),
                      title: Text("Remember Me", style: primaryTextStyle()),
                      value: authController.checkBoxValue.value,
                      dense: true,
                      onChanged: (newValue) {
                        authController.checkBoxValue.value = newValue!;
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                    //  authController.loginCTR();
                      if (formKey.currentState!.validate()) {
                           authController.loginCTR();
                      } else {
                        Fluttertoast.showToast(msg: 'Field can\'t be empty');
                      }


                      // if (authController.formKey.currentState!.validate()) {
                      //
                      //   email = _emailController!.text;
                      //   password = _passwordController!.text;
                      //
                      //   if(email.isEmptyOrNull || password.isEmptyOrNull){
                      //     print('Data:- ');
                      //   } else{
                      //     print('Data:- $email / $password');
                      //
                      //     Map<String, dynamic> loginBody = {
                      //       tblUserEmail : authController.emailController.text.va,
                      //       tblUserPassword  : password
                      //     };
                      //     final login = await dbHelper.loginUsers(loginBody);
                      //     print(login);
                      //     if(login == null){
                      //       toast('Login Failed! Please Verify Credential');
                      //     } else{
                      //       toast('Login Success!');
                      //
                      //       final userData = GetStorage();
                      //       userData.write('isAdmin', login[tblUserAdmin]);
                      //       userData.write('isLogged', true);
                      //       userData.write('name', login[tblUserName]);
                      //       userData.write('email', login[tblUserEmail]);
                      //       userData.write('image', login[tblUserImage]);
                      //
                      //
                      //       //
                      //       // SPHelper.setString('userName', login[tblUserName].toString());
                      //       // SPHelper.setString('userImage', login[tblUserImage].toString());
                      //       // SPHelper.setString('userMail', login[tblUserEmail].toString());
                      //       // SPHelper.setInt('isLoggedIn', 1);
                      //
                      //       Future.delayed(const Duration(seconds: 1), (){
                      //         Get.to(HomeScreen());
                      //         //   Navigator.pushNamed(context, HomeScreen.routeName,);
                      //       });
                      //     }
                      //
                      //     //  final allRows = await dbHelper.getAllUsers();
                      //     //   print('query all rows:');
                      //     // allRows?.forEach(print);
                      //   }
                      // } else {
                      //   print("Not Validated");
                      // }
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                        backgroundColor: appSecBackGroundColor,
                      ),
                      child: Text('Login', style: boldTextStyle(color: white)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassScreen()));
                    },
                    child: Text('Forgot the password ?', style: boldTextStyle()),
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      //   Get.to.
                      Get.to(() => RegistrationView());
                      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        style: secondaryTextStyle(),
                        children: [
                          TextSpan(text: ' Create New', style: boldTextStyle(size: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
