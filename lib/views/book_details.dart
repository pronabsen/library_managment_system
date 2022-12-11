import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/controller/book_controller.dart';
import 'package:library_managment_system/controller/home_controller.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../models/book_model.dart';
import '../utils/widgets.dart';
import 'home.dart';

class BookDetails extends StatelessWidget {
  final String book_id;
  final String book_name;
  
  BookDetails({Key? key, required this.book_id, required this.book_name}) : super(key: key);
  
  BookController bookController = Get.put(BookController());
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {


    return Obx((){

      var callApi = bookController.getBookById(book_id);

      if(bookController.isReload.isTrue){
        callApi = bookController.getBookById(book_id);
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: customAppBarWidget(
            context, titleText: book_name,
            backgroundColor: Colors.white,
            itemColor: Colors.black,
            actionWidget: homeController.isAdmin.isTrue
                ? IconButton(
                onPressed: () {
                  Get.off(Home());
                }, icon: Icon(Icons.edit_note_rounded))
                : SizedBox()),
        body: FutureBuilder<BookModel>(
          future: callApi,
          builder: (BuildContext context, AsyncSnapshot<BookModel> snapshot) {
            if(snapshot.hasData && snapshot.data != null){
              final bookItem = snapshot.data!;
              print(bookItem.toMap());
              return SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      Container(
                        width: 250,
                        height: 320,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: //NetworkImage('https://cdn.dribbble.com/users/1314493/screenshots/9546119/media/2c2b28c888158af6f30511d77dfdcb52.png')
                              NetworkImage(bookItem.bookImage)
                          ),
                          borderRadius: const BorderRadius.all(
                              Radius.circular(15)),
                          color: Colors.white30,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text('${bookItem.language} - ${bookItem.categories}',
                        style: primaryTextStyle(color: Colors.red),),
                      const SizedBox(height: 10,),
                      Text(bookItem.bookName, style: boldTextStyle(size: 25,
                          color: Colors.black),),
                      const SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('by', style: secondaryTextStyle(),),
                          const SizedBox(width: 5,),
                          Text(bookItem.bookAuthor, style: boldTextStyle(
                              size: 15, color: Colors.green),),
                          Text(' | ', style: secondaryTextStyle(),),
                          const SizedBox(width: 5,),
                          Text(bookItem.publishedDate, style: boldTextStyle(
                              size: 15, color: Colors.orangeAccent),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width / 2,
                        child: LinearPercentIndicator(
                          trailing: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${bookController.available(
                                  bookItem.bookItem, bookItem.bookHired)
                                  .toString()} Left',
                              style: primaryTextStyle(
                                  size: 12, color: Colors.grey), maxLines: 1,),
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
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          GestureDetector(
                            onTap: () {
                              if (bookItem.bookStatus == true &&
                                  bookItem.bookHired != bookItem.bookItem) {

                                /* final bookBorrow = DatabaseHelper
                                    .updateHireRecord(bookItem.id!);
                                setState(() {
                                  myData = DatabaseHelper.getIdBooks(id);
                                });*/

                                toast('Book added to Borrow List!');
                              } else {
                                toast('Book Not Available!');
                              }
                            },
                            child: Container(
                              //width: 200,
                              width: homeController.isAdmin.isTrue ? MediaQuery
                                  .of(context)
                                  .size
                                  .width / 3 : 200,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: boxDecorationWithRoundedCorners(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(45)),
                                backgroundColor: Colors.green,
                              ),
                              child: Text(bookItem.bookStatus == true &&
                                  bookItem.bookHired == 0
                                  ? 'Borrow Book'
                                  : 'Not available',
                                  style: boldTextStyle(color: white)),
                            ),
                          ),
                          homeController.isAdmin.isTrue ?
                          Row(
                            children: [
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: () {
                                  if (bookItem.bookStatus == true) {

                                    Map<String, dynamic> data = <String, dynamic>{
                                      tblBookStatus: false,
                                    };

                                    bookController.updateBookStatus(bookItem.id.toString(), data);

                                    bookController.refresh();

                                    /*       final bookUpdate = DatabaseHelper
                                        .updateBookDetails(
                                        tblBookStatus, 0, bookItem.id!);
                                    print(bookUpdate);
                                    setState(() {
                                      myData = DatabaseHelper.getIdBooks(id);
                                    });*/
                                  } else {

                                    Map<String, dynamic> data = <String, dynamic>{
                                      tblBookStatus: true,
                                    };

                                    bookController.updateBookStatus(bookItem.id.toString(), data);
                                    bookController.refresh();

                                    /*   final bookUpdate = DatabaseHelper
                                        .updateBookDetails(
                                        tblBookStatus, 1, bookItem.id!);
                                    print(bookUpdate);
                                    setState(() {
                                      myData = DatabaseHelper.getIdBooks(id);
                                    });*/
                                  }
                                 // toast('Book Details Updated!');
                                },
                                child: Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 3,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10),
                                  alignment: Alignment.center,
                                  decoration: boxDecorationWithRoundedCorners(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(45)),
                                    backgroundColor: Colors.black,
                                  ),
                                  child: Text(bookItem.bookStatus
                                      ? 'Make Unable'
                                      : 'Make Able',
                                      style: boldTextStyle(color: white)),
                                ),
                              )
                            ],
                          ) : SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      const Divider(height: 2, color: Colors.grey,),
                      const SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('Book Description', style: boldTextStyle(
                                weight: FontWeight.bold,
                                size: 17,
                                color: Colors.black),),
                            const SizedBox(height: 20,),
                            Text(bookItem.bookDescription,
                              style: primaryTextStyle(
                                  size: 15, color: Colors.black),),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if(snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null){
              return Center(
                child: ListView(
                  children: const <Widget>[
                    Align(alignment: AlignmentDirectional.center,
                        child: Text('No data available')),
                  ],
                ),
              );
            } else{
              return Center(child: CircularProgressIndicator());
            }

          },

        ),
      );
    });
  }
}
