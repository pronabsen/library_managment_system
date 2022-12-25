import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:library_managment_system/controller/auth_controller.dart';
import 'package:library_managment_system/models/UserModel.dart';
import 'package:library_managment_system/views/profile_views.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/admin_home_controller.dart';
import '../../controller/book_controller.dart';
import '../../utils/widgets.dart';

class FragAdminHome extends StatelessWidget {
  FragAdminHome({Key? key}) : super(key: key);

  AdminHomeController adminHomeController = Get.put(AdminHomeController());
  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          adminHomeController.countApplicationIssuedList();
          adminHomeController.countIssuedBook();
          adminHomeController.countBooks();

          var callApi = authController.getUserList();

          // countIssuedBook();
          // countBooks();
          // setState(() {
          //   return AdminScreen();
          // });
        },
        child: Container(
          //   margin: const EdgeInsets.only(top: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Colors.white,
                Colors.white,
              ])),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      margin: const EdgeInsets.only(
                          left: 20.0, top: 3.0, right: 5.0),
                      elevation: 26.0,
                      shadowColor: Colors.white,
                      color: Colors.green,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.library_books_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${adminHomeController.countBook}',
                                  style: montserratTextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Total Books',
                                  style: montserratTextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      margin:
                          const EdgeInsets.only(left: 5, right: 20.0, top: 3.0),
                      elevation: 26.0,
                      shadowColor: Colors.white,
                      color: Colors.deepOrange,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.library_books_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${adminHomeController.countBook.toInt() - adminHomeController.countIssuedBooks.toInt()}',
                                  style: montserratTextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Available',
                                  style: montserratTextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      margin: const EdgeInsets.only(
                          left: 20.0, top: 3.0, right: 5.0),
                      elevation: 26.0,
                      shadowColor: Colors.white,
                      color: Colors.pink,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.my_library_add_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${adminHomeController.countApplication}',
                                  style: montserratTextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Request',
                                  style: montserratTextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0)),
                      margin:
                          const EdgeInsets.only(left: 5, right: 20.0, top: 3.0),
                      elevation: 26.0,
                      shadowColor: Colors.white,
                      color: Colors.deepPurple,
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 30, bottom: 30),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.library_add_check_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${adminHomeController.countIssued}',
                                  style: montserratTextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Issued',
                                  style: montserratTextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                elevation: 26.0,
                shadowColor: Colors.white,
                color: Colors.blue[100],
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: const ColoredBox(
                              color: Color(0XFFff6b63),
                              child: SizedBox(width: 12, height: 12),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          AutoSizeText(
                            'Total Books',
                            style: montserratTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black, width: 1.0),
                            ),
                            child: const ColoredBox(
                              color: Colors.blue,
                              child: SizedBox(width: 12, height: 12),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          AutoSizeText(
                            'Total No. of Issued Books',
                            style: montserratTextStyle(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      AspectRatio(
                        aspectRatio: 1.3,
                        child: PieChart(PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: ((adminHomeController.countIssuedBooks
                                              .toInt() /
                                          adminHomeController.countBook
                                              .toInt()) *
                                      100)
                                  .roundToDouble(),
                              title:
                                  '${((adminHomeController.countIssuedBooks.toInt() / adminHomeController.countBook.toInt()) * 100).roundToDouble()}%',
                              color: Colors.blue,
                              radius: 100.0,
                              titlePositionPercentageOffset: 0.75,
                              titleStyle: montserratTextStyle(
                                  fontSize: 14, color: Colors.white),
                            ),
                            PieChartSectionData(
                              value: ((adminHomeController.countBook.toInt() -
                                          adminHomeController.countIssuedBooks
                                              .toInt()) *
                                      100 /
                                      adminHomeController.countBook.toInt())
                                  .roundToDouble(),
                              radius: 100.0,
                              color: const Color(0XFFff6b63).withOpacity(0.9),
                              title:
                                  '${((adminHomeController.countBook.toInt() - adminHomeController.countIssuedBooks.toInt()) * 100 / adminHomeController.countBook.toInt()).roundToDouble()}%',
                              titlePositionPercentageOffset: 0.5,
                              titleStyle: montserratTextStyle(
                                  fontSize: 14, color: Colors.white),
                            )
                          ],
                          centerSpaceRadius: 8.0,
                          centerSpaceColor: Colors.white,
                          sectionsSpace: 4,
                          pieTouchData: PieTouchData(
                            enabled: true,
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                        )),
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                margin: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                elevation: 26.0,
                shadowColor: Colors.white,
                color: Colors.deepOrange[50],
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 5.0, right: 5.0, top: 20.0),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                              ),
                              child: const ColoredBox(
                                color: Colors.blue,
                                child: SizedBox(width: 12, height: 12),
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              'User List',
                              style: montserratTextStyle(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                        future: authController.getUserList(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<UserModel>> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: ListView(
                                shrinkWrap: true,
                                children: const [
                                  Align(
                                      alignment: AlignmentDirectional.center,
                                      child: CircularProgressIndicator()),
                                ],
                              ),
                            );
                          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                            return Container(
                              height: 110,
                              margin: const EdgeInsets.only(
                                  left: 10.0, top: 3.0, right: 5.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: (){

                                      Get.off(() =>  ProfileView(userModel : snapshot.data![index]));
                                     // Fluttertoast.showToast(msg: 'Coming in next Build!', backgroundColor: Colors.orangeAccent);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: 90,
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: const Color(
                                                      0xFF90CAF9),
                                                  width: 3),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      snapshot.data![index].userImage ??
                                                          '')),
                                            ),
                                          ),
                                        )),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      );
    });
  }
}
