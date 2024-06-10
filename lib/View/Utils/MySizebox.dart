import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
double totalDistance=0;
double totalRideAmount=0;

class AppColors {
  static const themeColor = Color(0xFF033D72);
  static const primeryColor = Color(0xFF033D72);

  static const blueColor = Color(0xFF0577E0);
  static const lightGrey = Color(0xFFB4B4B4);
  static const grey = Color(0xff444540);
   static const kwhiteColor = Colors.white;

  static const whiteColor = Colors.white;
  static const kAmberColor = Colors.amber;
  static const kGreeyColor = Colors.grey;
}

//=============use in future

class AppApiUrls {
  static const baseUrl = "https://server-php-7-3.technorizen.com/EalaaDarbik/webservice";
  static const logInUrl = "$baseUrl/login";
  static const homeListUrl = "$baseUrl/get_companyList";
  static const addDetailsListUrl = "$baseUrl/add_company";
  static const getProfileUrl = "$baseUrl/get_profile";
}

final statesBarTheme =
SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Color.fromARGB(250, 255, 255, 255),
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
));

//==================additional
Widget sizeBox_mq(
    BuildContext context, {
      required double width,
      required double height,
      Widget? child,
    }) {
  final mq = MediaQuery.of(context).size;
  return SizedBox(
    height: mq.height * height,
    width: mq.width * width,
    child: child,
  );
}
