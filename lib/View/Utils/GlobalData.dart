
import 'package:ealaa_userr/Model/advertisement_model/BannerModel.dart';
import 'package:ealaa_userr/View/Utils/bottom_bar.dart';

import '../../Model/BannerModel.dart';
import '../../Model/ProfileModel.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
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


//Ads Module

List<AdsBannerResult> adsBannerList = [];
// List<GetAdvertisementCategoryResult> advertisementCategoryList = [];
 List<GetAdsWithCategoryHomeResult> getAdsWithCategoryHomeResult = [];
