import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller/profile_settings_controller.dart';
import '../utils/Constants.dart';
import '../utils/widgets.dart';

class Faqs_view extends StatelessWidget {
  Faqs_view({Key? key}) : super(key: key);

  ProfileSettingsController profileSettingsController = Get.put(ProfileSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBarWidget(context,
          backgroundColor: Colors.blue,
          itemColor: Colors.white,
          titleText: '${profileSettingsController.isAdmin.isFalse ? 'User' : 'Admin' } FAQs'),
      body: Container(
        child: ListView.builder(

          shrinkWrap: true,
          itemCount: profileSettingsController.isAdmin.isFalse ? userInstructionsList.length : adminInstructionsList.length,
          itemBuilder: (BuildContext context, int index) {

            return ExpandableTheme(
              data: const ExpandableThemeData(
                iconColor: Colors.blue,
                useInkWell: true,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  ExpandableNotifier(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          elevation: 8.0,
                          shadowColor: Colors.white,
                          color: Colors.blue[50],
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            children: [
                              ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                  theme: const ExpandableThemeData(
                                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                                    tapBodyToCollapse: true,
                                  ),
                                  header: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        profileSettingsController.isAdmin.isFalse ?
                                        userInstructionsList[index].question :
                                        adminInstructionsList[index].question,
                                        style: montserratTextStyle(fontSize: 17, color: Colors.deepOrangeAccent),
                                      )),
                                  collapsed: Text(
                                    profileSettingsController.isAdmin.isFalse ?
                                    userInstructionsList[index].answer :
                                    adminInstructionsList[index].answer,
                                    softWrap: true,
                                    maxLines: 1,
                                    style: montserratTextStyle(fontSize: 15),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  expanded: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      for (var _ in Iterable.generate(1))
                                        Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              profileSettingsController.isAdmin.isFalse ?
                                              userInstructionsList[index].answer :
                                              adminInstructionsList[index].answer,
                                              softWrap: true,
                                              style: montserratTextStyle(fontSize: 17),
                                              overflow: TextOverflow.fade,
                                            )
                                        ),
                                    ],
                                  ),
                                  builder: (_, collapsed, expanded) {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                      child: Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        theme: const ExpandableThemeData(crossFadePoint: 0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                ],
              ),
            );
          },

        ),
      ),
    );
  }
}
