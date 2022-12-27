import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/models/issued_book_model.dart';
import 'package:library_managment_system/services/fcm_messaging_services.dart';

import '../../controller/auth_controller.dart';
import '../../controller/book_controller.dart';
import '../../models/UserModel.dart';
import '../../models/book_model.dart';
import '../../utils/widgets.dart';

class FragIssuedBookList extends StatefulWidget {
  const FragIssuedBookList({Key? key}) : super(key: key);

  @override
  State<FragIssuedBookList> createState() => _FragIssuedBookListState();
}

class _FragIssuedBookListState extends State<FragIssuedBookList> {
  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var callApi = bookController.getIssuedBook();

      if (bookController.isReload.isTrue) {
        callApi = bookController.getIssuedBook();
      }

      return FutureBuilder(
        future: callApi,
        builder: (BuildContext context,
            AsyncSnapshot<List<IssuedBookModel>> snapshot) {
          print('_FragIssuedBookListState.build-  --> ${snapshot.data}');
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
                          showBottomSheet(context, snapshot.data![index]);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          '${snapshot.data![index].bookName} (${snapshot.data![index].bookCode})',
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
                            SizedBox(
                              height: 8,
                            ),
                            Text('Borrower: ${snapshot.data![index].borrower}'),
                            Text('Due Date: ${snapshot.data![index].dueDate}'),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        trailing: GestureDetector(
                          onTap: () async {


                            bookController.isDownloading.value = true;

                            bookController.downloadFile('invoice_${snapshot.data![index].uniqueBookCode}_.pdf').whenComplete((){
                              bookController.isDownloading.value = false;
                            });

                            print('FILE: ${snapshot.data![index].pdfUrl}');
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                CupertinoIcons.download_circle,
                                color: Color(0Xaa000839),
                                size: 32,
                              ),
                              bookController.isDownloading.isTrue ?
                              const Positioned(
                                child: CircularProgressIndicator(
                                  //value: bookController.downloadingProgress.value,
                                  color: Colors.green,
                                ),
                              ) : Positioned(child: SizedBox()),
                            ],
                          )
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
      );
    });
  }

  showBottomSheet(BuildContext context, IssuedBookModel issuedBookModel) async {
    UserModel user = await authController.getUserInfo(issuedBookModel.borrower);

    BookModel bookItem =
        await bookController.getBookByCode(issuedBookModel.bookCode);
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
                          'Issued for #${issuedBookModel.bookName} (${issuedBookModel.bookCode})',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Colors.deepOrange,
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
                                  Text(
                                    '• Due Date',
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
                                    '• Fine(-)',
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
                                  Text(
                                    issuedBookModel.dueDate.toString(),
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
                                    fineCalculator(issuedBookModel.dueDate.toString())
                                        .toString(),
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        color: Colors.red,
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
                                  bookController.deleteIssue(
                                      context,
                                      issuedBookModel.uniqueBookCode,
                                      issuedBookModel.borrower,
                                      issuedBookModel.bookCode);

                                  setState(() {});
                                },
                                child: Text(
                                  'Delete',
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

  fineCalculator(String date) {
    try {
      var due = DateTime.parse(date);
      var cur = DateTime.now();
      var fine = cur.difference(due).inDays;
      if (fine <= 0) {
        fine = 0;
      }
      return fine;
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }
}
