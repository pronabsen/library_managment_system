import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/book_controller.dart';

import '../../controller/auth_controller.dart';
import '../../models/UserModel.dart';
import '../../models/application_model.dart';
import '../../models/book_model.dart';
import '../../utils/widgets.dart';

class UserApplication extends StatefulWidget {
  const UserApplication({Key? key}) : super(key: key);

  @override
  State<UserApplication> createState() => _UserApplicationState();
}

class _UserApplicationState extends State<UserApplication> {
  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: bookController.getUserApplication(),
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
                        setState(() {
                          showBottomSheet(
                              context,
                              snapshot.data![index].borrower,
                              snapshot.data![index].bookName,
                              snapshot.data![index].bookCode);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          '${snapshot.data![index].borrowerName} applied for '
                          '${snapshot.data![index].bookName} (${snapshot.data![index].bookCode})',
                          style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                            color: Color(0Xaa000839),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                        subtitle:
                            Text('Email: ${snapshot.data![index].borrower}'),
                        trailing: const Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Color(0Xaa000839),
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
      ),
    );
  }

  showBottomSheet(BuildContext context, String email, String bookName,
      String bookCode) async {
    UserModel user = await authController.getUserInfo(email);

    BookModel bookItem = await bookController.getBookByCode(bookCode);
    bookController.isAvailable.value =
        !(bookItem.bookItem == bookItem.bookHired);
    print('_FragRequestBookListState.showBottomSheet--- ${user.userEmail}');

    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blue,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              color: const Color(0Xff737373),
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Text(
                          'Application for #$bookName',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Color(0Xff6C63FF),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              decorationThickness: 4.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 26.0,
                          shadowColor: Colors.black,
                          color: Colors.blue[200],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const SizedBox(height: 15.0),
                                  Text(
                                    '• Name',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    '• Branch',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    '• Roll No',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                ],
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 15.0),
                                  Text(
                                    ' : ',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    ' : ',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    ' : ',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15.0),
                                  Text(
                                    user.userName,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    user.branch,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    user.userRoll,
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15.0),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontSize: 21,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
          );
        });
  }
}
