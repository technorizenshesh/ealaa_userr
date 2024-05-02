import 'dart:io';

import 'package:ealaa_userr/View/Utils/bottom_bar.dart';

import '../../Model/BannerModel.dart';
import '../../Model/ProfileModel.dart';
import '../../import_ealaa_user.dart';

var userToken;
var userId;
ProfileResult? profileResult;
List<BannerResult> bannerList = [];
class MyGlobalKeys{
  static GlobalKey<Bottom_barState> tabBarKey = GlobalKey<Bottom_barState>();
}
String BookingStatus = '';
String BookingTime = '';
String BookingPickLocation = '';
String BookingPickLocationTime = '';
String BookingDropLocation = '';
String BookingPickLat = '';
String BookingPickLong = '';
String BookingDropLat = '';
String BookingDropLong = '';
String BookingDropLocationTime = '';
String DriverId='';



double dropLat = 0;
double dropLong = 0;

int pendingNotification=0;
int ongoingNotification=0;
int cancelNotification=0;
// bool isPermissionGranted = await requestPermission();

int currentindex = 0;