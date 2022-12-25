import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/utils/widgets.dart';
import 'package:library_managment_system/views/user_home_views.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controller/book_controller.dart';
import '../functions/app_constants.dart';
import '../functions/shared_pref_helper.dart';
import '../utils/Colors.dart';
import 'admin_home_views.dart';

class AddBookView extends StatelessWidget {
  AddBookView({Key? key}) : super(key: key);

  BookController bookController = Get.put(BookController());

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
          backgroundColor: Colors.white,
          appBar: customAppBarWidget(
              backgroundColor: Colors.white,
              itemColor: Colors.black,
              context,
              titleText: 'Add New Book'),
          body: Obx(() {
            return Form(
              key: bookController.fromKey,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Book Name:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: bookController.bookNameController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Book Name", borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Book Code:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          maxLines: 1,
                          controller: bookController.bookCodeController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Book Code", borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Author Name:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: bookController.bookAuthorController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Author Name", borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Publication Name:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: bookController.bookPublicationController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Publication Name",
                              borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Book Description:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          controller: bookController.bookDescriptionController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Book Description",
                              borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: commonDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Book Language:',
                                style: boldTextStyle(),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: bookController.bookLanguage.value,
                                    items: AppConstants.bookLanguage
                                        .map((e) =>
                                        DropdownMenuItem(
                                            value: e, child: Text(e!)))
                                        .toList(),
                                    onChanged: (newValue) {
                                      bookController.bookLanguage.value =
                                          newValue.toString();
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: commonDecoration(color: Colors.grey[200]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Book Category:',
                                style: boldTextStyle(),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: bookController.selectedCategory.value,
                                    items: AppConstants.bookTypes
                                        .map((e) =>
                                        DropdownMenuItem(
                                            value: e, child: Text(e!)))
                                        .toList(),
                                    onChanged: (newValue) {
                                      bookController.selectedCategory.value =
                                          newValue.toString();
                                    },
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Release Date:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          controller: bookController.bookReleaseDate,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime.now());
                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                              DateFormat(AppConstants.datePattern)
                                  .format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16

                              bookController.bookReleaseDate.text = formattedDate;
                              bookController.publicationDate.value =
                                  formattedDate;
                            } else {}
                          },
                          decoration: inputDecoration(context,
                              hintText: "Enter Release Date", borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Book Quantity:',
                            style: boldTextStyle(),
                          ),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          controller: bookController.bookQuantityController,
                          decoration: inputDecoration(context,
                              hintText: "Enter Book Quantity", borderRadius: 6),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This fields must not be empty';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: commonDecoration(color: Colors.grey[200]),
                          child: TextButton.icon(
                              onPressed: () {
                                selectBookImages(context);
                              },
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.black87,
                              ),
                              label: Text(
                                'Select Book Image',
                                style: boldTextStyle(),
                              )),
                        ),
                        //bookImage(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (bookController.bookImageLink.isEmpty) {
                        Fluttertoast.showToast(msg: 'Please Upload Image!', backgroundColor: Colors.red);
                        return;
                      }

                      if (bookController.fromKey.currentState!.validate()) {
                        final result = await bookController.addNewBook();
                      } else {
                        print('error');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
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
                        child: Text('Add New Book',
                            style: boldTextStyle(color: white)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
/*
  bookImage() {
    if (bookController.bookImage.value.isEmpty) {
      return const SizedBox();
    } else {
      return Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: FileImage(File(bookController.bookImage.value))),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
        ],
      );
    }
  }

  selectBook(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.blue,
        context: context,
        builder: (context) {
          return Container(
            // color: Colors.blue,
            width: double.infinity,
            // height: MediaQuery
            //     .of(context)
            //     .size
            //     .height / 2 * 0.3,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                Text(
                  'Select Images',
                  style: boldTextStyle(size: 17, color: Colors.black),
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
                        bookController.getImage(context, ImageSource.camera);
                      },
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
                            style: boldTextStyle(size: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        bookController.getImage(context, ImageSource.gallery);
                      },
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
                            style: boldTextStyle(size: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }*/

  selectBookImages(BuildContext context) {
    return showModalBottomSheet(
      // backgroundColor: Colors.blue,
        context: context,
        builder: (context) {
          return Obx(() {
            return Container(
              // color: Colors.blue,
              width: double.infinity,
             // height: 300,
              // height: MediaQuery
              //     .of(context)
              //     .size
              //     .height / 2 * 0.3,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: ListView(
                children: [
                  Text(
                    'Select Images - (${bookController.bookImages.length} selected)',
                    style: montserratTextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),

                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: GridView.builder(
                          // physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                            shrinkWrap: true,
                            itemCount: bookController.bookImages.length + 1,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return index == 0
                                  ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Center(
                                  child: IconButton(
                                      icon: const Icon(
                                        CupertinoIcons.add_circled, color: Colors.black,size: 32,),
                                      onPressed: () =>
                                      !bookController.uploading.isTrue
                                          ? bookController.chooseImage(context)
                                          : null),
                                ),
                              )
                                  : Positioned(
                                child: Stack(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.red),
                                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
                                          image: DecorationImage(
                                              image: FileImage(File(
                                                  bookController.bookImages[index - 1]
                                                      .toString())),
                                              fit: BoxFit.cover)
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: GestureDetector(
                                        onTap: () {
                                          bookController.bookImages.removeAt(index-1);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.all(5),
                                          padding: const EdgeInsets.all(3),
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3))
                                          ),
                                          child: Icon(CupertinoIcons.clear_circled, color: Colors.white, size: 27,),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      bookController.uploading.isTrue
                          ? Center(
                          child: Container(
                           // width: MediaQuery.of(context).size.width/2,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.blue
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Uploading...',
                                  style: montserratTextStyle(fontSize: 17, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CircularProgressIndicator(
                                  value: bookController.uploadingProgress.value,
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              ],
                            ),
                          ))
                          : Container(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      try {
                        bookController.uploadFile().whenComplete((){
                          bookController.uploadingProgress.value = 0.0;
                          bookController.uploading.value = false;
                          Navigator.of(context).pop();
                          Fluttertoast.showToast(msg: 'Image Uploaded Complete!',
                              backgroundColor: Colors.green, textColor: Colors.white);
                          bookController.bookImages.clear();
                        });
                      } catch (e){
                        Fluttertoast.showToast(msg: 'Image Uploaded Failed!',
                            backgroundColor: Colors.red, textColor: Colors.white);
                      }
                     // bookController.uploading.value = false;
                     // bookController.getImage(context, ImageSource.camera);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 50.0, vertical: 10.0),
                      elevation: 15.0,
                      shadowColor: Colors.white,
                      color: Colors.blue,
                      child: Container(
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          'Upload',
                          style: montserratTextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
        });
  }


  selectBookImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            // color: Colors.blue,
            width: MediaQuery
                .of(context)
                .size
                .width,
            //  height: MediaQuery.of(context).size.height / 2 * 0.3,
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Obx(() {
              return Stack(
                children: [

                  Container(
                    padding: const EdgeInsets.all(4),
                    child: GridView.builder(
                        itemCount: bookController.bookImages.length + 1,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                            child: IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () =>
                                !bookController.uploading.isTrue
                                    ? bookController.chooseImage(context)
                                    : null),
                          )
                              : Container(
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(File(
                                        bookController.bookImages[index - 1]
                                            .toString())),
                                    fit: BoxFit.cover)
                            ),
                          );
                        }),
                  ),
                  bookController.uploading.isTrue
                      ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: const Text(
                              'Uploading...',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CircularProgressIndicator(
                            value: bookController.uploadingProgress.value
                                .toDouble(),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          )
                        ],
                      ))
                      : Container(),


                ],
              );
            }),
          );
        }
    );
  }

  _bookImage() {
    return Obx(() {
      return Row(
        children: [
          const SizedBox(
            width: 30,
          ),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(''))),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
        ],
      );
    });
  }
}
