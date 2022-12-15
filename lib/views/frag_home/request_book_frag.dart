import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/controller/book_controller.dart';
import 'package:library_managment_system/database/auth_db.dart';
import 'package:library_managment_system/database/book_db.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/models/application_model.dart';
import 'package:library_managment_system/models/book_model.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../utils/app_component.dart';
import '../../utils/widgets.dart';


class FragRequestBookList extends StatefulWidget {
  const FragRequestBookList({Key? key}) : super(key: key);

  @override
  State<FragRequestBookList> createState() => _FragRequestBookListState();
}

class _FragRequestBookListState extends State<FragRequestBookList> {


  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());



  @override
  Widget build(BuildContext context) {
    return  Container(
      child: FutureBuilder(
        future: bookController.getAllApplication(),
        builder: (BuildContext context, AsyncSnapshot<List<ApplicationModel>> snapshot) {

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
                    color: const Color(0Xaab963ff).withOpacity(0.2),
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
                        title: Text('${snapshot.data![index].borrowerName} applied for '
                            '${snapshot.data![index].bookName} (${snapshot.data![index].bookCode})', style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              color: Color(0Xaa000839),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            )),),
                        subtitle: Text('Email: ${snapshot.data![index].borrower}'),
                        trailing: const Icon(Icons.arrow_circle_right_outlined, color: Color(0Xaa000839),),

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
                  Align(alignment: AlignmentDirectional.center,
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

  showBottomSheet(BuildContext context, String email,  String bookName, String bookCode)  async {

    UserModel user = await authController.getUserInfo(email);

    BookModel bookItem = await bookController.getBookByCode(bookCode);
    bookController.isAvailable.value = !(bookItem.bookItem == bookItem.bookHired);
    print('_FragRequestBookListState.showBottomSheet--- ${user.userEmail}');

    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.blue,
        builder: (BuildContext context) {

          return Obx((){
            return SingleChildScrollView(
              child: Container(
                color: const Color(0Xff737373),
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Application for #$bookName',
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                color:  Color(0Xff6C63FF),
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
                            color:  const Color(0Xffb963ff).withOpacity(0.3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '• Name      : ',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '• Branch     : ',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15.0),
                                    Text(
                                      '• Roll No      : ',
                                      style: GoogleFonts.montserrat(
                                        textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
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
                                          fontSize: 20,
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
                                          fontSize: 20,
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
                                          fontSize: 20,
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


                          bookController.showOtherOption.isTrue ?

                          showAcceptOption(bookCode, user.userEmail, bookName) :
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              bookController.isAvailable.isTrue
                                  ? Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton(
                                  onPressed: (){
                                    setState(() {
                                      bookController.showOtherOption.value = true;
                                    });

                                  },
                                  child: Text(
                                    'Accept',
                                    style: GoogleFonts.montserrat(
                                      textStyle: const TextStyle(
                                        fontSize: 21,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                                  : Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Not Available',
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
                                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                                // decoration: _boxDecoration2,
                                child: ElevatedButton(
                                  onPressed: (){},
                                  child: Text(
                                    'Reject',
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
                          )
                        ],
                      ),
                    )),
              ),
            );
          });
        }

    );

  }

  showAcceptOption(String bookCode, String userEmail, String bookName){
    return Column(
      children: [
        SizedBox(height: 20,),
        TextFormField(
          controller: bookController.uniqueBookCodeController,
          decoration: inputDecoration(context, prefixIcon: Icons.code, hintText: "Enter Unique Code"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Email cannot be empty";
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
         //   bookController.uniqueBookCodeController.value = value;
          },
        ),

        SizedBox(height: 15,),

        TextFormField(
          controller: bookController.appDateController,

          decoration: inputDecoration(context, prefixIcon: Icons.date_range, hintText: "Enter Date"),
          validator: (val) {
            if (val!.isEmpty) {
              return "Email cannot be empty";
            } else {
              return null;
            }
          },
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          onChanged: (value) {
            print(value);
          },
          onTap: () async{
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1970),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime.now());

            if (pickedDate != null) {
              print(pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              print(formattedDate); //formatted date output using intl package =>  2021-03-16

              bookController.appDatetext.value = formattedDate;
              bookController.appDateController.text = formattedDate;

            } else {}
          },
        ),

        Container(
          margin: const EdgeInsets.only(top: 20.0),
         // decoration: _boxDecoration2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final uniqueCode = bookController.uniqueBookCodeController.text;
                  final issuedBookContent = await bookController.getIssuedBookByCode(uniqueCode);
                  final bookData = await bookController.getBookByCode(uniqueCode);

                  if (issuedBookContent != null || bookData != null || uniqueCode == null || uniqueCode == '') {
                    Fluttertoast.showToast(
                      msg: 'Enter Unique Code',
                    );
                    // print('Enter Unique Code');
                  } else {

                    bookController.acceptApplication(bookCode, userEmail, bookName);

                    bookController.deleteApplication(context, bookCode, userEmail);



                    Fluttertoast.showToast(
                      msg: 'Valid Unique Code',
                    );
                  }


                },
                child: Text('Confirm',
                  style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ),
              ),
              const SizedBox(width: 20,),
              ElevatedButton(
                onPressed: (){
                  bookController.showOtherOption.value = false;
                },
                child: Text('Back',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}

