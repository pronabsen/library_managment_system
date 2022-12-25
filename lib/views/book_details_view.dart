import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/functions/shared_pref_helper.dart';
import 'package:library_managment_system/utils/widgets.dart';
import 'package:library_managment_system/views/admin_home_views.dart';
import 'package:library_managment_system/views/user_home_views.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controller/book_controller.dart';
import '../models/book_model.dart';

class BookDetailsView extends StatelessWidget {
  final String book_code;
  final String book_name;

  BookDetailsView({Key? key, required this.book_code, required this.book_name})
      : super(key: key);

  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var callApi = bookController.getBookById(book_code);

      if (bookController.isReload.isTrue) {
        callApi = bookController.getBookById(book_code);
      }
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
          backgroundColor: Colors.white,
          appBar: customAppBarWidget(context,
              titleText: book_name,
              backgroundColor: Colors.white,
              itemColor: Colors.black,
              actionWidget: authController.isAdmin.isTrue
                  ? IconButton(
                      onPressed: () {
                        _showDialog(context, book_code, book_name);
                      },
                      icon: const Icon(
                        Icons.delete_forever_outlined,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox(),
              actionWidget2: authController.isAdmin.isTrue
                  ? IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.edit_note_rounded,
                        color: Colors.black,
                      ),
                    )
                  : const SizedBox()),
          body: FutureBuilder<BookModel>(
            future: callApi,
            builder: (BuildContext context, AsyncSnapshot<BookModel> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final bookItem = snapshot.data!;
                print(bookItem.toMap());
                return SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        Container(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 1.1,
                              enlargeCenterPage: true,
                            ),
                            items: bookItem.bookImages.map((item) => Container(
                              child: Container(
                                margin: EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: //NetworkImage('https://cdn.dribbble.com/users/1314493/screenshots/9546119/media/2c2b28c888158af6f30511d77dfdcb52.png')
                                                NetworkImage(item['url'])),
                                            borderRadius:
                                            const BorderRadius.all(Radius.circular(15)),
                                            color: Colors.white30,
                                          ),
                                        ),
                                       /* Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 20.0),
                                            child: Text(
                                              'No. ${imgList.indexOf(item)} image',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),*/
                                      ],
                                    )),
                              ),
                            )).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${bookItem.language} - ${bookItem.categories}',
                          style: montserratTextStyle(color: Colors.red),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          bookItem.bookName,
                          style: montserratTextStyle(
                              fontSize: 25, color: Colors.black),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'by',
                              style: montserratTextStyle(),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              bookItem.bookAuthor,
                              style: montserratTextStyle(
                                  fontSize: 15, color: Colors.green),
                            ),
                            Text(
                              ' | ',
                              style: montserratTextStyle(),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              bookItem.publishedDate,
                              style: montserratTextStyle(
                                  fontSize: 15, color: Colors.orangeAccent),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: LinearPercentIndicator(
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${bookController.available(bookItem.bookItem, bookItem.bookHired).toString()} Left',
                                style: montserratTextStyle(
                                    fontSize: 12, color: Colors.grey),
                                maxLines: 1,
                              ),
                            ),
                            alignment: MainAxisAlignment.start,
                            lineHeight: 5,
                            percent: bookController.itemLeft(
                                bookItem.bookItem, bookItem.bookHired),
                            barRadius: const Radius.circular(16),
                            progressColor: Colors.orange[300],
                            backgroundColor: Colors.grey[200],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (bookItem.bookHired != bookItem.bookItem) {
                                  final result = bookController.checkIssuedOrNot(
                                      bookItem.bookCode,
                                      await SPHelper.getUserEmailSharedPreference());

                                  print('BookDetailsView.build__. ${result}');

                                  /* final bookBorrow = DatabaseHelper
                                      .updateHireRecord(bookItem.id!);
                                  setState(() {
                                    myData = DatabaseHelper.getIdBooks(id);
                                  });*/

                                  // toast('Book added to Borrow List!');
                                } else {
                                  toast('Book Not Available!');
                                }
                              },
                              child: Container(
                                //width: 200,
                                width: authController.isAdmin.isTrue
                                    ? MediaQuery.of(context).size.width / 3
                                    : 200,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                decoration: boxDecorationWithRoundedCorners(
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(45)),
                                  backgroundColor: Colors.green,
                                ),
                                child: Text(
                                    bookItem.bookHired == bookItem.bookItem
                                        ? 'Not available'
                                        : 'Borrow Book',
                                    style: montserratTextStyle(color: white)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(
                          height: 2,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Book Description',
                                style: montserratTextStyle(
                                  weight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                bookItem.bookDescription,
                                style: montserratTextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == null) {
                return Center(
                  child: ListView(
                    children: const <Widget>[
                      Align(
                          alignment: AlignmentDirectional.center,
                          child: Text('No data available')),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    });
  }

  _showDialog(BuildContext context, String bookCode, String bookName){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Column(
              children: [
                Text("Alert!", style: montserratTextStyle(color: Colors.red, fontSize: 20),)
              ],
            ),
            content: Text('Are you sure want to delete $bookName ?' , style: montserratTextStyle(fontSize: 17),),
            actions: [
              CupertinoDialogAction(
                child: const Text("Yes"),
                onPressed: () async {
                 await bookController.deleteBook(bookCode);

                },),
              CupertinoDialogAction(
                child: const Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },),
            ],
          );
    });
  }
}
