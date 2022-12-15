import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/old/controller/book_controller.dart';
import 'package:library_managment_system/old/functions/app_constants.dart';
import 'package:library_managment_system/old/views/home.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/Colors.dart';
import '../utils/widgets.dart';

class AddBook extends StatelessWidget {
  AddBook({Key? key}) : super(key: key);

  BookController bookController = Get.put(BookController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(Home());
            },
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),

          ),
          title: const Text('Add New Book'),
        ),
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
                            String formattedDate = DateFormat(
                                AppConstants.datePattern).format(pickedDate);
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
                              selectBookImage(context);
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
                       bookImage(),
                    ],
                  ),
                ),

                GestureDetector(
                  onTap: () async {

                    if (bookController.bookImage.value.isEmpty) {
                      toast( 'Please select an Image');
                      return;
                    }

                    if (bookController.fromKey.currentState!.validate()) {

                      final result = await bookController.addNewBook();

                    } else{
                     print('error');
                    }

                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: const BorderRadius.all(Radius.circular(45)),
                        backgroundColor: appSecBackGroundColor,
                      ),
                      child: Text('Add New Book', style: boldTextStyle(color: white)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }

  bookImage(){
    if(bookController.bookImage.value.isEmpty){
      return const SizedBox();
    } else {
      return Row(
        children: [
          const SizedBox(width: 30,),
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: FileImage(File(bookController.bookImage.value))
              ),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
        ],
      );
    }

  }

  selectBookImage(BuildContext context) {
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
                        bookController.getImage(ImageSource.camera);
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
                        bookController.getImage(ImageSource.gallery);
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
