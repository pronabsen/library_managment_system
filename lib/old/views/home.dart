import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:library_managment_system/old/views/add_book.dart';
import 'package:library_managment_system/old/views/login.dart';

import '../controller/home_controller.dart';
import '../utils/Colors.dart';
import 'fragments/book_list_frag.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  int _selectedIndex = 0;

 /* @override
  void initState() {
    homeController.loadData();
    // TODO: implement initState
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {

    final HomeController homeController = Get.put(HomeController());

    return Obx((){
      return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(
              color: Colors.black
          ),
          title: Text(homeController.title.value ?? '', style: const TextStyle(color: Colors.black),),
        ),
        drawer: SafeArea(
          child: Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    //   padding: EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: appBackGroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: ClipOval(
                            child: Image.file(File(homeController.userImage.value), fit: BoxFit.fitWidth,),
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(homeController.userName.value, style: const TextStyle(color: appDarkColor),),
                        Text(homeController.userEmail.value, style: const TextStyle(color: appDarkColor),),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.home_outlined),
                  title: Text('Home'),
                  trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
                ),
                homeController.isAdmin.isTrue ?
                Column(
                  children: [
                    InkWell(
                      //        onTap: (){ Get.to(AddUserScreen()); },
                      child: const ListTile(
                        leading: Icon(Icons.person_add_alt),
                        title: Text('Add User'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
                      ),
                    ),
                    InkWell(
                      onTap: (){ Get.off(AddBook()); },
                      child: const ListTile(
                        leading: Icon(Icons.book_online_rounded),
                        title: Text('Add Book'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
                      ),
                    ),
                  ],
                )
                    : SizedBox(),
                InkWell(
                  onTap: () async {
                    await homeController.logout();
                    //  Navigator.push(context, route)
                    //    Navigator.pushNamed(context, LoginWithPassScreen.routeName,);
                    // const LoginWithPassScreen().launch(context,isNewTask: true);
                  },
                  child: const ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Logout'),
                    trailing: Icon(Icons.arrow_forward_ios_rounded, size: 20,),
                  ),
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: context.iconColor),
          selectedItemColor: context.iconColor,
          unselectedLabelStyle: const TextStyle(color: Colors.grey),
          iconSize: 20,
          unselectedItemColor: Colors.grey,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.chrome_reader_mode_outlined), activeIcon: Icon(Icons.chrome_reader_mode), label: 'Book'),
            BottomNavigationBarItem(icon: Icon(Icons.book_online), activeIcon: Icon(Icons.book), label: 'Trash'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), activeIcon: Icon(Icons.person), label: 'User'),
          ],
        ),

        body: pages.elementAt(_selectedIndex),
      );
    });
  }


  final pages = [
    BookList(),
   // const UserListPage(type: 'active'),
  //  const UserListPage(type: 'trash'),
  ];


  void _onItemTapped(int index) {

    setState(() {
      //  loginInfo = await SPHelper.getLogin();
      //print(loginInfo);
      _selectedIndex = index;

  /*    if(index == 2){
        homeController.title.value = 'Active User';
      }else if(index == 3){
        homeController.title.value = 'Trashed User';
      } else{
        homeController.title.value = 'Book List';
      }
*/

    });
  }

}
