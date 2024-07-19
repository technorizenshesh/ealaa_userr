import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/Model/BannerModel.dart';
import 'package:ealaa_userr/Model/GeneralModel.dart';
import 'package:ealaa_userr/View/Screens/DeliveryNotifications.dart';
import 'package:ealaa_userr/View/Screens/ShipmentDetailDriverScreen.dart';
import 'package:ealaa_userr/View/Store/storeBottomBar.dart';
import 'package:ealaa_userr/advertisement/ad_get_start.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../advertisement/ad_bottom_bar.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';
import 'CompanyDetails.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  int activeIndex = 0;
  String currentTime = "";
  String notificationCount = "";

  currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat.MMMEd();
    currentTime = formatter.format(now);
    print(currentTime); // 2016-01-25
  }

  getBanner() async {
    var res = await Webservices.getMap("$baseUrl$get_banner");
    print("status from api ${res}");
    final resdata = BannerModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      bannerList = resdata.result;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getNotificationCount() async {
    var res =
        await Webservices.getMap("$baseUrl$notification_count?user_id=$userId");
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      notificationCount = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message!);
    }
  }

  @override
  void initState() {
    currentDate();
    getNotificationCount();
    if (bannerList.isEmpty) {
      getBanner();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ParagraphText(
              text: currentTime,
              fontSize: 14,
              color: Colors.grey,
            ),
            MainHeadingText(
              text: profileResult!.userName == ""
                  ? "hii there!"
                  : profileResult!.userName!,
              fontSize: 22,
            ),
          ],
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        actions: [
          if (profileResult!.image != null)
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.primaryColor, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: profileResult!.image!,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        push(context: context, screen: DeliveryNotifications());
                      },
                      child: Stack(
                        children: <Widget>[
                          Icon(
                            Icons.notifications,
                            size: 32,
                          ), // Your icon here
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: notificationCount == "0" ||
                                        notificationCount == ""
                                    ? Colors.transparent
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                notificationCount, // Your badge count here
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SvgPicture.asset("assets/images/Notification.svg",height: 30,color: MyColors.primaryColor,)
                  ],
                ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              bannerList.isEmpty
                  ? CircularProgressIndicator()
                  : SizedBox(
                      height: height * 0.01,
                    ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 180,
                  //height: MediaQuery.of(context).size.height / 6,
                  aspectRatio: 10.5 / 9,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
                itemCount: bannerList.length,
                itemBuilder: (context, int index, int realIndex) {
                  return Container(
                    margin: EdgeInsets.only(right: 16),
                    width: width,
                    height: height * 0.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        bannerList[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: bannerList.length,
                  effect: const ExpandingDotsEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    activeDotColor: MyColors.primaryColor,
                    dotColor: Color(0xffD9D9D9),
                  ),
                ),
              ),
              Stack(
                children: [
                  SvgPicture.asset(
                    "assets/images/bubbel.svg",
                    width: width,
                    height: 460,
                  ),
                  Positioned(
                    top: 50,
                    left: 10,
                    child: Center(
                      child: GestureDetector(
                          onTap: () async {
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            if (sharedPreferences.getString('ads_first') !=
                                '1') {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdGetStart()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdBottomBar()));
                            }
                          },
                          child: Image.asset(
                            "assets/icons/ic_ads_logo.png",
                            height: 140,
                          )),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 10,
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShipmentDetailDriverScreen()));
                          },
                          child: Image.asset(
                            "assets/images/IndividualIcon.png",
                            height: 140,
                          )),
                    ),
                  ),
                  Positioned(
                    top: 200,
                    left: 10,
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) =>
                                        CompanyDetails(cId: "1")));
                          },
                          child: Image.asset(
                            "assets/images/CompanyIcon.png",
                            height: 140,
                          )),
                    ),
                  ),
                  Positioned(
                      top: 200,
                      right: 10,
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => StoreBottomBar()));
                            },
                            child: Image.asset(
                              "assets/images/StoreIcon.png",
                              height: 140,
                            )),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
