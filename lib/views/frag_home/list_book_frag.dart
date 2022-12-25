import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../controller/auth_controller.dart';
import '../../controller/book_controller.dart';
import '../../models/book_model.dart';
import '../../utils/widgets.dart';
import '../book_details_view.dart';

class FragBookList extends StatelessWidget {
  FragBookList({Key? key}) : super(key: key);

  BookController bookController = Get.put(BookController());
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: FutureBuilder(
        future: bookController.getAllBooks(),
        builder:
            (BuildContext context, AsyncSnapshot<List<BookModel>> snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
                childAspectRatio: 0.79,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    //      toast(snapshot.data![index].id.toString());

                    Get.off(() => BookDetailsView(
                        book_code: snapshot.data![index].bookCode.toString(),
                        book_name: snapshot.data![index].bookName.toString()));

                    //        BookModel result = await bookController.getBookById(snapshot.data![index].id.toString());
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 140,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: NetworkImage(
                                        snapshot.data![index].bookImages[0]['url'])),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                                color: Colors.redAccent,
                              ),
                            ),
                            LinearPercentIndicator(
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${bookController.available(snapshot.data![index].bookItem, snapshot.data![index].bookHired).toString()} left',
                                  style: montserratTextStyle(
                                      fontSize: 11, color: Colors.grey),
                                  maxLines: 1,
                                ),
                              ),
                              alignment: MainAxisAlignment.start,
                              lineHeight: 5,
                              percent: bookController.itemLeft(
                                  snapshot.data![index].bookItem,
                                  snapshot.data![index].bookHired),
                              barRadius: const Radius.circular(16),
                              progressColor: Colors.orange[300],
                              backgroundColor: Colors.grey[200],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //const SizedBox(height: 6,),
                                  Text(
                                    snapshot.data![index].bookName,
                                    style: montserratTextStyle(),
                                    maxLines: 2,
                                  ),
                                  Text(
                                    snapshot.data![index].bookAuthor,
                                    style: montserratTextStyle(
                                        fontSize: textSecondarySizeGlobal,
                                        color: textSecondaryColorGlobal,
                                        weight: fontWeightSecondaryGlobal),
                                    maxLines: 1,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(8),
                                      topRight: Radius.circular(10))),
                              child: Text(
                                snapshot.data![index].categories,
                                style: montserratTextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            )
                            //_available(snapshot.data![index].bookItem,snapshot.data![index].bookHired ),
                            ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                    topLeft: Radius.circular(10))),
                            child: Text(
                              snapshot.data![index].language,
                              style: montserratTextStyle(
                                  fontSize: 10, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
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
          return Container();
        },
      ),
    );
  }
}
