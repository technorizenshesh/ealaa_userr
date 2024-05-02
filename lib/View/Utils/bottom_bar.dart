import 'dart:io';
import 'package:ealaa_userr/View/Screens/ChooseVehicleScreen.dart';
import 'package:ealaa_userr/View/Screens/HomeMap.dart';
import 'package:ealaa_userr/View/Screens/Tracking.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/material.dart';

import '../Screens/Myorder.dart';
import '../Screens/UserHomeScreen.dart';
import '../Screens/profile.dart';
import 'CustomSnackBar.dart';

class Bottom_bar extends StatefulWidget {
  const Bottom_bar({ required Key? key,}) : super(key: key);

  @override
  Bottom_barState createState() => Bottom_barState();
}

class Bottom_barState extends State<Bottom_bar> {
  int _currentindex = 0;
  void onTap(int index) {
    setState(() {
      _currentindex = index;
    });
    print(_currentindex);
  }

  final pages = [
    UserHome(),
    Myorder(),
    Tracking(),
    Profile(),
  ];

  DateTime? currentBackPressTime;
  Future<bool> _onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showSnackbar(context, "Press again to exit");
      return Future.value(false);
    }
    return Future.value(exit(0)); //back all class & exit
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: pages[_currentindex],
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
              height: 1.5,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins'),
          unselectedLabelStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xffFFFFFF),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(MyImages.home),
                  size: 22,
                ),
                label: 'Home',
                backgroundColor: Color(0xff000000)),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                 MyImages.order,
                  ),
                  size: 22,
                ),
                label: 'Order',
                backgroundColor: Color(0xff000000)),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    MyImages.Tracking,
                  ),
                  size: 22,
                ),
                label: 'Tracking',
                backgroundColor: Color(0xff000000)),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    MyImages.profile,
                  ),
                  size: 22,
                ),
                label: 'Profile',
                backgroundColor: Color(0xff000000)),

          ],
          currentIndex: _currentindex,
          unselectedItemColor: MyColors.secondarycolor,
          selectedItemColor: Color(0xffFFAF00),
          selectedIconTheme: IconThemeData(
            color: MyColors.primaryColor,
          ),
          unselectedIconTheme: IconThemeData(
            color: MyColors.secondarycolor,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: onTap,
        ),
      ),
    );
  }
}
