import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/controller/book_controller.dart';
import 'package:library_managment_system/functions/shared_pref_helper.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/models/application_model.dart';
import 'package:library_managment_system/utils/widgets.dart';
import 'package:library_managment_system/views/user_home_views.dart';

import '../models/issued_book_model.dart';
import 'admin_home_views.dart';


class ProfileView extends StatelessWidget {

  UserModel userModel;
  ProfileView({super.key, required this.userModel});
  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await SPHelper.getUserIsAdminSharedPreference()) {
          Get.offAll(const AdminHomeView());
        } else {
          Get.offAll(const UserHomeView());
        }
        return false; //<-- SEE HERE
      },
      child: Scaffold(
        appBar: customAppBarWidget(
          context, backgroundColor: Colors.blue.shade500,
          actionWidget: GestureDetector(
            onTap: (){
              Fluttertoast.showToast(msg: 'Coming in next build', backgroundColor: Colors.orange);
            },
            child: Row(
              children: const [
                Icon(Icons.edit_note_rounded, color: Colors.white, size: 26,),
                SizedBox(width: 8,)
              ],
            ),
          )

        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 160.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
              ),
            ),
            ListView(
              children: [
                _buildHeader(context),
                _buildSectionHeader(context),
                _buildApplicationsRow(),
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0, bottom: 10.0),
                    child: Text("Issued Books",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline6)),
                _buildIssuedRows(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20.0),
      height: 300.0,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 40.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    userModel.userName,
                    style: montserratTextStyle(
                        fontSize: 20, color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    userModel.userEmail, style: montserratTextStyle(),),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.building_2_fill, size: 16,),
                      const SizedBox(width: 5,),
                      Text(userModel.branch, style: montserratTextStyle(),),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.person_2, size: 16,),
                      const SizedBox(width: 5,),
                      Text(userModel.userGender, style: montserratTextStyle(),),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(CupertinoIcons.calendar, size: 16,),
                      const SizedBox(width: 5,),
                      Text(userModel.userDoB, style: montserratTextStyle(),),
                    ],
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),

                  SizedBox(
                    height: 40.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Obx(() {
                          return Expanded(
                            child: ListTile(
                              title: Text(
                                authController.userBookRequested.value
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: montserratTextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              subtitle: Text("Pending".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: montserratTextStyle(fontSize: 11)),
                            ),
                          );
                        }),
                        Obx(() {
                          return Expanded(
                            child: ListTile(
                              title: Text(
                                authController.userBookIssued.value
                                    .toString(),
                                textAlign: TextAlign.center,
                                style: montserratTextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              subtitle: Text("Issued".toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: montserratTextStyle(fontSize: 11)),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(
                elevation: 5.0,
                shape: const CircleBorder(),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundImage: NetworkImage(userModel.userImage),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildSectionHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Text(
        "Pending Applications",
        style: Theme
            .of(context)
            .textTheme
            .headline6,
      ),
    );
  }

  Container _buildApplicationsRow() {
    return Container(
      color: Colors.white,
      height: 200.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: FutureBuilder(
        future: bookController.getApplicationByUser(userModel.userEmail),
        builder: (BuildContext context,
            AsyncSnapshot<List<ApplicationModel>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                    elevation: 26.0,
                    shadowColor: Colors.white,
                    color: Colors.blue[100],
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: ListTile(
                        title: Text(
                          '${snapshot.data![index].borrowerName} applied for '
                              '${snapshot.data![index].bookName} (${snapshot
                              .data![index].bookCode})',
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color: Color(0Xaa000839),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        subtitle:
                        Text('Email: ${snapshot.data![index].borrower}'),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data!.isEmpty) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Align(
                      alignment: AlignmentDirectional.center,
                      child: noAvailableData()),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Container _buildIssuedRows() {
    return Container(
        color: Colors.white,
        height: 200.0,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FutureBuilder(
          future: bookController.getIssuedByUser(userModel.userEmail),
          builder: (BuildContext context,
              AsyncSnapshot<List<IssuedBookModel>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      elevation: 26.0,
                      shadowColor: Colors.white,
                      color: Colors.blue[100],
                      child: GestureDetector(
                        onTap: () {},
                        child: ListTile(
                          title: Text(
                            '${snapshot.data![index].bookName} (${snapshot
                                .data![index].bookCode})',
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  color: Color(0Xaa000839),
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text('Borrower: ${snapshot.data![index]
                                  .borrower}'),
                              Text(
                                  'Due Date: ${snapshot.data![index].dueDate}'),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data!.isEmpty) {
              return Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.center,
                        child: noAvailableData()),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        )
    );
  }

}
