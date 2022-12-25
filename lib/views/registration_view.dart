import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/views/login_views.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/auth_controller.dart';
import '../main.dart';
import '../utils/Colors.dart';
import '../utils/widgets.dart';

class RegistrationView extends StatelessWidget {
  RegistrationView({Key? key}) : super(key: key);

  AuthController authController = Get.put(AuthController());

  final formRegKey = AuthController().formRegKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offAll( LoginView());
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: careaAppBarWidget(context),
        body: Obx(() {
          return Center(
            child: SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formRegKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // const Image(height: 110, width: 110, fit: BoxFit.cover, image: AssetImage('assets/app_icon.png'),),
                      const SizedBox(height: 16),
                      Text('Create Your Account', style: boldTextStyle(size: 24)),
                      const SizedBox(height: 40),
                      _profilePic(context),
                      const SizedBox(height: 40),
                      _name(context),
                      const SizedBox(height: 20),
                      _email(context),
                      const SizedBox(height: 20),
                      _rollNo(context),
                      const SizedBox(height: 20),
                      _dateOfBirth(context),
                      const SizedBox(height: 20),
                      _branch(context),
                      const SizedBox(height: 20),
                      _gender(context),
                      const SizedBox(height: 20),
                      _password(context),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () async {
                          if (formRegKey.currentState!.validate()) {
                            await authController.registerCTR();
                          } else {
                            print("Not Validated");
                          }
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          alignment: Alignment.center,
                          decoration: boxDecorationWithRoundedCorners(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(45)),
                            backgroundColor: appSecBackGroundColor,
                          ),
                          child:
                          Text('Sign Up', style: boldTextStyle(color: white)),
                        ),
                      ),
                      //Divider

                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Get.to(LoginView());

                          // Get.to(const LoginWithPassScreen());
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already have account? ",
                            style: secondaryTextStyle(),
                            children: [
                              TextSpan(
                                  text: ' Sign in', style: primaryTextStyle()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  _name(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.isEmptyOrNull) {
          return 'Please enter the correct Name';
        }
        return null;
      },
      autofillHints: const [AutofillHints.name],
      onFieldSubmitted: (v) {
        authController.focusEmail.unfocus();
        // FocusScope.of(context).requestFocus(focusEmail);
      },
      controller: authController.regNameCTR,
      decoration: inputDecoration(context,
          prefixIcon: Icons.person, hintText: "Full Name"),
    );
  }

  _rollNo(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.isEmptyOrNull) {
          return 'Please enter the correct roll';
        }
        return null;
      },
      keyboardType: TextInputType.number,
      onFieldSubmitted: (v) {
        // authController.focusEmail.unfocus();
        // FocusScope.of(context).requestFocus(focusEmail);
      },
      controller: authController.userRollCTR,
      decoration:
      inputDecoration(context, prefixIcon: Icons.pin, hintText: "Roll No"),
    );
  }

  _branch(BuildContext context) {
    return TextFormField(
      autofocus: false,
      keyboardType: TextInputType.text,
      onFieldSubmitted: (v) {
        // authController.focusEmail.unfocus();
        // FocusScope.of(context).requestFocus(focusEmail);
      },
      controller: authController.userBranchCTR,
      decoration:
      inputDecoration(context, prefixIcon: Icons.school,
          hintText: "School/College/University Name"),
    );
  }

  _email(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (!value!.contains('@')) {
          return 'Please enter the correct email';
        }
        return null;
      },
      focusNode: authController.focusEmail,
      autofillHints: const [AutofillHints.email],
      onFieldSubmitted: (v) {
        authController.focusEmail.unfocus();
        FocusScope.of(context).requestFocus(authController.focusPassword);
      },
      controller: authController.regEmailCTR,
      decoration: inputDecoration(context,
          prefixIcon: Icons.mail_rounded, hintText: "Email"),
    );
  }

  _dateOfBirth(BuildContext context) {
    return TextFormField(
      autofocus: false,
      validator: (value) {
        if (value.isEmptyOrNull) {
          return 'Please enter the correct Date of Birth';
        }
        return null;
      },
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1970),
            //DateTime.now() - not to allow to choose before today.
            lastDate: DateTime.now());

        if (pickedDate != null) {
          print(
              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          print(
              formattedDate); //formatted date output using intl package =>  2021-03-16

          authController.birthDate.value = formattedDate;
          authController.birthDateCTR.text = formattedDate;
        } else {}
      },
      controller: authController.birthDateCTR,
      decoration: inputDecoration(context,
          prefixIcon: Icons.date_range, hintText: "Date of Birth"),
    );
  }

  _gender(BuildContext context) {
    return Container(
      decoration: commonDecoration(color: Colors.grey[200]),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Row(
          children: <Widget>[
            const Expanded(
              flex: 2,
              child: Text(
                'Gender:',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
                flex: 4,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: authController.selectedGender.value,
                    items:
                    <String>['Male', 'Female', 'Other'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      authController.selectedGender.value = newValue!;
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

  _password(BuildContext context) {
    return Column(
      children: [
        Observer(
          builder: (context) =>
              TextFormField(
                autofocus: false,
                focusNode: authController.focusPassword,
                controller: authController.regPassCTR,
                obscureText: authController.isIconTrue.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "* Required";
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (v) {
                  authController.focusPassword.unfocus();
                  if (formRegKey.currentState!.validate()) {
                    //
                  }
                },
                decoration: inputDecoration(
                  context,
                  prefixIcon: Icons.lock,
                  hintText: "Password",
                  suffixIcon: Theme(
                    data: ThemeData(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        authController.isIconTrue.value = false;
                      },
                      icon: Icon(
                        (authController.isIconTrue.isTrue)
                            ? Icons.visibility_rounded
                            : Icons.visibility_off,
                        size: 16,
                        color: appStore.isDarkModeOn ? white : gray,
                      ),
                    ),
                  ),
                ),
              ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  _profilePic(BuildContext context) {
    if (authController.profileImage.value.isEmpty) {
      return Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/profile_placeholder.png')
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                  onTap: () {
                    selectProfileImage(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(8),

                      ),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.camera, size: 25, color: Colors.orange,),
                  )))
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(authController.profileImage.value))
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: InkWell(
                  onTap: () {
                    selectProfileImage(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(8),

                      ),
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.camera, size: 25, color: Colors.orange,),
                  )))
        ],
      );
    }
  }

  selectProfileImage(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.blue,
        context: context,
        builder: (context) {
          return Container(
            color: Colors.blue,
            width: double.infinity,
            height: MediaQuery
                .of(context)
                .size
                .height / 2 * 0.3,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Text(
                  'Choose option',
                  style: boldTextStyle(size: 20, color: Colors.white),
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        authController.getImage(context, ImageSource.camera);
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Camera',
                              style: boldTextStyle(
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        authController.getImage(context, ImageSource.gallery);
                      },
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Gallery',
                              style: boldTextStyle(
                                  size: 20, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }

}
