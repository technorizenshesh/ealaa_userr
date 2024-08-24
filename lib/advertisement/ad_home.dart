import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/Model/advertisement_model/BannerModel.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_sub_categories.dart';
import 'package:ealaa_userr/advertisement/post_detail/AnimalsAndSuppliesDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/ElectronicsDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/PhoneNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/RealEstateDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehiclePartsAndAccessoriesDetailScreen.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'CategoryPostsScreen.dart';

class AdHome extends StatefulWidget {
  const AdHome({super.key});

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;
  int activeIndex = 0;
  String currentTime = "";
  String notificationCount = "";

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  getBannerApi() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    if(sharedPreferences.getString('ads_first')!='1') {
      sharedPreferences.setString('ads_first','1');
    }
    var res = await Webservices.getMap("$baseUrl$get_advertise_banner");
    print("status from banner api ${res}");
    final resdata = AdsBannerModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      adsBannerList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

/*  getAdvertisementCategoryApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      advertisementCategoryList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }*/

  getAdsWithCategoryHomeApi() async {
    var res = await Webservices.getMap("$baseUrl$get_ads_with_category_home");
    print("status from api ${res}");
    final resdata = GetAdsWithCategoryHomeModel.fromJson(res);
    print(res);
    if (resdata.result != null && resdata.status == '1') {
      getAdsWithCategoryHomeResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  //
  // getAdvertisementPostsApi() async {
  //   showProgressBar = true;
  //   var res = await Webservices.getMap(
  //       "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
  //   print("status from api ${res}");
  //   final resdata = GetAdvertisementCategoryModel.fromJson(res);
  //   print(res);
  //   if (resdata.result != null && resdata.status == '1') {
  //     getAdvertisementPostsCategoryResult = resdata.result!;
  //     setState(() {});
  //   } else {
  //     showSnackbar(context, resdata.message ?? '');
  //   }
  //   showProgressBar = false;
  // }

  @override
  void initState() {
    if (adsBannerList == [] || adsBannerList.isEmpty) {
      getBannerApi();
    }
    if (getAdsWithCategoryHomeResult == [] ||
        getAdsWithCategoryHomeResult.isEmpty) {
      showProgressBar = true;
      getAdsWithCategoryHomeApi();
    }else{
      getAdsWithCategoryHomeApi();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        title:
        const Text(
          'Home', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        /*title: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white.withOpacity(0.4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: 'What are you looking for?',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),*/
        /*actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      clickOnNotification();
                    },
                    child: Stack(
                      children: <Widget>[
                        const Icon(
                          Icons.notifications_none_rounded,
                          size: 32,
                          color: Colors.white,
                        ), // Your icon here
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: notificationCount == "0" ||
                                      notificationCount == ""
                                  ? Colors.transparent
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              notificationCount, // Your badge count here
                              style: const TextStyle(
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
        ],*/
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            SizedBox(height: 10),
            CarouselSlider.builder(
              options: CarouselOptions(
                height: 150,
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
              itemCount: adsBannerList.length,
              itemBuilder: (context, int index, int realIndex) {
                return GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(adsBannerList[index].urlLink ?? 'https://i.pinimg.com/originals/49/e5/8d/49e58d5922019b8ec4642a2e2b9291c2.png');
                    print('Attempting to launch $url');
                    if (await canLaunchUrl(url)) {
                      print('Launching $url');
                      await launchUrl(url);
                    } else {
                      print('Could not launch $url');
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: adsBannerList[index].image!,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                            baseColor: MyColors.onSecondary.withOpacity(0.4),
                            highlightColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.2,
                              color: MyColors.onSecondary.withOpacity(0.4),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            adsBannerList.isEmpty || adsBannerList == []
                ? SizedBox()
                : Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: activeIndex,
                      count: adsBannerList.length,
                      effect: const ExpandingDotsEffect(
                        dotHeight: 6,
                        dotWidth: 6,
                        activeDotColor: MyColors.primaryColor,
                        dotColor: Color(0xffD9D9D9),
                      ),
                    ),
                  ),
            SizedBox(height: 15),
            if (getAdsWithCategoryHomeResult.isNotEmpty ||
                getAdsWithCategoryHomeResult != [])
              showCategory1(getAdsWithCategoryHomeResult),
            SizedBox(height: 10),
            if (getAdsWithCategoryHomeResult.isNotEmpty ||
                getAdsWithCategoryHomeResult != [])
              showCategoriesPost1(getAdsWithCategoryHomeResult)
          ],
        ),
      ),
    );
  }

  /// Show Category ...
  Widget showCategory1(
      List<GetAdsWithCategoryHomeResult> getAdsWithCategoryHomeResult) {
    return showProgressBar
        ? CommonWidget.commonShimmer(
            itemCount: 8,
            shimmerWidget: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
              clipBehavior: Clip.hardEdge,
            ),
          )
        : GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 100, mainAxisSpacing: 5),
            itemCount: getAdsWithCategoryHomeResult.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  if (getAdsWithCategoryHomeResult[index].id == "1" ||
                      getAdsWithCategoryHomeResult[index].id == "2" ||
                      getAdsWithCategoryHomeResult[index].id == "5" ||
                      getAdsWithCategoryHomeResult[index].id == "6" ||
                      getAdsWithCategoryHomeResult[index].id == "7" ||
                      getAdsWithCategoryHomeResult[index].id == "8" ||
                      getAdsWithCategoryHomeResult[index].id == "10") {
                    getAdsWithCategorySubCategoryResult = [];
                    getAdsWithCategorySubCategoryResultGlobal = [];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdSubCategories(
                          advertisement_category_id:
                              getAdsWithCategoryHomeResult[index].id ?? '',
                          ads_post:
                              getAdsWithCategoryHomeResult[index].type ?? '',
                          getAdsWithCategoryHomeResult:
                              getAdsWithCategoryHomeResult[index],
                        ),
                      ),
                    );
                  } else if (getAdsWithCategoryHomeResult[index].id == "3" ||
                      getAdsWithCategoryHomeResult[index].id == "4" ||
                      getAdsWithCategoryHomeResult[index].id == "9") {
                    getAdsWithCategorySubCategoryResult = [];
                    getAdsWithCategorySubCategoryResultGlobal = [];
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPostsScreen(
                            adsPost: getAdsWithCategoryHomeResult[index]
                                .type
                                .toString(),
                            adsCategoryId: getAdsWithCategoryHomeResult[index]
                                .id
                                .toString(),
                            adsSubCategoryId: '',
                          ),
                        ),);
                  }
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  // padding: const EdgeInsets.only(
                  //     left: 3, right: 3, top: 5, bottom: 5),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200, // Set the width of the image here
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                getAdsWithCategoryHomeResult[index].image ?? '',
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                              baseColor: MyColors.onSecondary.withOpacity(0.4),
                              highlightColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: MyColors.onSecondary.withOpacity(0.4),
                                ),
                              ),
                            )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        getAdsWithCategoryHomeResult[index].name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget showCategoriesPost1(
      List<GetAdsWithCategoryHomeResult> getAdsWithCategoryHomeResult) {
    return Column(
      children: [
        for (int i = 0; i < getAdsWithCategoryHomeResult.length; i++)
          getAdsWithCategoryHomeResult[i].totalCount == null ||
                  getAdsWithCategoryHomeResult[i].totalCount == 0
              ? SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: InkWell(
                        onTap: () {
                          if (getAdsWithCategoryHomeResult[i].id == "1" ||
                              getAdsWithCategoryHomeResult[i].id == "2" ||
                              getAdsWithCategoryHomeResult[i].id == "5" ||
                              getAdsWithCategoryHomeResult[i].id == "6" ||
                              getAdsWithCategoryHomeResult[i].id == "7" ||
                              getAdsWithCategoryHomeResult[i].id == "8" ||
                              getAdsWithCategoryHomeResult[i].id == "10") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdSubCategories(
                                  advertisement_category_id:
                                  getAdsWithCategoryHomeResult[i].id ?? '',
                                  ads_post:
                                  getAdsWithCategoryHomeResult[i].type ?? '',
                                  getAdsWithCategoryHomeResult:
                                  getAdsWithCategoryHomeResult[i],
                                ),
                              ),
                            );
                          } else if (getAdsWithCategoryHomeResult[i].id == "3" ||
                              getAdsWithCategoryHomeResult[i].id == "4" ||
                              getAdsWithCategoryHomeResult[i].id == "9") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryPostsScreen(
                                  adsPost: getAdsWithCategoryHomeResult[i]
                                      .type
                                      .toString(),
                                  adsCategoryId: getAdsWithCategoryHomeResult[i]
                                      .id
                                      .toString(),
                                  adsSubCategoryId: '',
                                ),
                              ),);
                          }
                        },
                        child: Row(
                          children: [
                            Text(
                              "Browse ${getAdsWithCategoryHomeResult[i].totalCount}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${getAdsWithCategoryHomeResult[i].name}",
                              style: TextStyle(
                                  color: MyColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              "assets/images/Navs.svg",
                              height: 16,
                            )
                          ],
                        ),
                      ),
                    ),
                    listOfData(index: i),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
      ],
    );
  }

  Widget listOfData({required int index}) {
    if (getAdsWithCategoryHomeResult[index].postListDetails != null &&
        getAdsWithCategoryHomeResult[index].postListDetails!.isNotEmpty) {
      if (getAdsWithCategoryHomeResult[index].id == '1' ||
          getAdsWithCategoryHomeResult[index].id == '2') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return VehicleDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  .adsType ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  .adsId  ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleAdsUploadImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleAdsAdditionalDetailDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleAdsAdditionalDetailPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '3') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return VehiclePartsAndAccessoriesDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              .adsType  ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              .adsId ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehiclePartImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehiclePartDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehiclePartPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '4') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return VehicleNumberDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              .adsType  ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              .adsId ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleNumberImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleNumberDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .vehicleNumberPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '5' ||
          getAdsWithCategoryHomeResult[index].id == '6') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return RealEstateDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  .adsType  ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  .adsId ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .realStateAdsUploadImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .realStateAdsAdditionalDetailDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .realStateAdsAdditionalDetailPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '7' ||
          getAdsWithCategoryHomeResult[index].id == '8') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ElectronicsDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              .adsType ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                              .postListDetails?[j]
                              . adsId ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .electronicsAdsImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .electronicsAdsDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .electronicsAdsPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '9') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return PhoneNumberDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                                  .postListDetails![j]
                                  .adsType  ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                                  .postListDetails![j]
                                  .adsId ??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .phoneNumberAdsImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .phoneNumberAdsDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .phoneNumberAdsPrice ??
                          '0'),
                )
            ],
          ),
        );
      } else if (getAdsWithCategoryHomeResult[index].id == '10') {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int j = 0;
                  j <
                      getAdsWithCategoryHomeResult[index]
                          .postListDetails!
                          .length;
                  j++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return AnimalsAndSuppliesDetailScreen(
                          ads_post: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  .adsType ??
                              '',
                          ads_post_id: getAdsWithCategoryHomeResult[index]
                                  .postListDetails?[j]
                                  . adsId??
                              '',
                        );
                      },
                    ));
                  },
                  child: dataContainer(
                      imageUrl: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .animalsAdsImage ??
                          '',
                      name: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .animalsAdsDescription ??
                          '',
                      price: getAdsWithCategoryHomeResult[index]
                              .postListDetails![j]
                              .animalsAdsPrice ??
                          '0'),
                )
            ],
          ),
        );
      }
    }
    return SizedBox();
  }

  Widget dataContainer(
      {required String imageUrl, required String name, required String price}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey.withOpacity(0.3)),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200, // Set the width of the image here
            height: 100,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: Shimmer.fromColors(
                  baseColor: MyColors.onSecondary.withOpacity(0.4),
                  highlightColor: Theme.of(context).colorScheme.onSecondary,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: MyColors.onSecondary.withOpacity(0.4),
                    ),
                  ),
                )),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Text(
              name,
              style: TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "${price} OMR",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
