import 'package:auto_size_text/auto_size_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../controller/admin_home_controller.dart';
import '../../controller/book_controller.dart';
import '../../utils/widgets.dart';

class FragAdminHome extends StatelessWidget {
  FragAdminHome({Key? key}) : super(key: key);

  AdminHomeController adminHomeController = Get.put(AdminHomeController());
  BookController bookController = Get.put(BookController());

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
   return Obx((){
     return RefreshIndicator(
       key: _refreshIndicatorKey,
       onRefresh: () async {
         // countIssuedBook();
         // countBooks();
         // setState(() {
         //   return AdminScreen();
         // });
       },
       child: Container(
         margin: const EdgeInsets.only(top: 20),
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
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 Expanded(
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25.0)),
                     margin: const EdgeInsets.only(left: 40.0,top: 3.0,right: 5.0),
                     elevation: 26.0,
                     shadowColor: Colors.white,
                     color: Colors.blue[400],
                     child: Column(
                       children: [
                         const SizedBox(height: 8,),
                         Text('Total Books',style: boldTextStyle(color: Colors.white),),
                         const SizedBox(height: 5,),
                         Text('${adminHomeController.countBook}', style: montserratTextStyle(color: Colors.white),),
                         const SizedBox(height: 8,),
                       ],
                     ),
                   ),
                 ),
                 Expanded(
                   child: Card(
                     shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(25.0)),
                     margin: const EdgeInsets.only(left:5,right: 40.0,top: 3.0),
                     elevation: 26.0,
                     shadowColor: Colors.white,
                     color: Colors.blue[400],
                     child: Column(
                       children: [
                         const SizedBox(height: 8,),
                         Text(
                           'Available', style: montserratTextStyle(color: Colors.white),
                         ),
                         const SizedBox(height: 5,),
                         Text('${adminHomeController.countBook.toInt() - adminHomeController.countIssuedBooks.toInt() }',
                           style: boldTextStyle(color: Colors.white),),
                         const SizedBox(height: 8,),
                       ],
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
                   horizontal: 40.0, vertical: 10.0),
               elevation: 26.0,
               shadowColor: Colors.white,
               color: Colors.blue[100],
               child: Container(
                 margin: const EdgeInsets.only(
                     left: 20.0, right: 20.0, top: 20.0),
                 child: Column(
                   children: [
                     Row(
                       children: [
                         Container(
                           decoration: BoxDecoration(
                             border: Border.all(
                                 color: Colors.black, width: 1.0),
                           ),
                           child: const ColoredBox(
                             color: Color(0XFFff6b63),
                             child:
                             SizedBox(width: 12, height: 12),
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
                             border: Border.all(
                                 color: Colors.black, width: 1.0),
                           ),
                           child: const ColoredBox(
                             color: Colors.blue,
                             child:
                             SizedBox(width: 12, height: 12),
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
                             value:
                             ((adminHomeController.countIssuedBooks.toInt() / adminHomeController.countBook.toInt()) * 100).roundToDouble(),
                             title:
                             '${((adminHomeController.countIssuedBooks.toInt() / adminHomeController.countBook.toInt()) * 100).roundToDouble()}%',
                             color: Colors.blue,
                             radius: 100.0,
                             titlePositionPercentageOffset: 0.75,
                             titleStyle: montserratTextStyle(fontSize: 14, color: Colors.white),
                           ),
                           PieChartSectionData(
                               value: ((adminHomeController.countBook.toInt() - adminHomeController.countIssuedBooks.toInt()) * 100 / adminHomeController.countBook.toInt())
                                   .roundToDouble(),
                               radius: 100.0,
                               color: const Color(0XFFff6b63).withOpacity(0.9),
                               title:
                               '${((adminHomeController.countBook.toInt() - adminHomeController.countIssuedBooks.toInt()) * 100 / adminHomeController.countBook.toInt()).roundToDouble()}%',
                               titlePositionPercentageOffset:
                               0.5,
                               titleStyle: montserratTextStyle(fontSize: 14, color: Colors.white),
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




           ],
         ),
       ),
     );
   });
  }
}
