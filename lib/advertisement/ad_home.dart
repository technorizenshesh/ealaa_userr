import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/Model/advertisement_model/BannerModel.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_product_detail.dart';
import 'package:ealaa_userr/advertisement/ad_sub_categories.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Model/advertisement_model/AllCategoryPostModel.dart';
import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'ad_view_all_sub_categories.dart';

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

  List<Map<String, String>> carList = [
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_car1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_car2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_car1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_car2.png"
    },
  ];

  List<AllCategoryPostResult> PostByCategoryList = [];

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  getBannerApi() async {
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

  getAdvertisementCategoryApi() async {
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
  }

  getAllPostByCategoryApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_category_post");
    print("status from api ${res}");
    final resdata = AllCategoryPostModel.fromJson(res);
    print(res);
    if (resdata.result != null && resdata.status == '1') {
      PostByCategoryList = resdata.result!;
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
    if (advertisementCategoryList == [] || advertisementCategoryList.isEmpty) {
      getAdvertisementCategoryApi();
    }

    getAllPostByCategoryApi();
  //  getAdvertisementPostsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.grey.withOpacity(0.4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 5),
                child: Icon(
                  Icons.search,
                  size: 25,
                  color: Colors.black45,
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
                        color: Colors.black54)),
              ))
            ],
          ),
        ),
        actions: [
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
                          color: Colors.orange,
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
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
                      // Image.network(
                      //   adsBannerList[index].image!,
                      //   fit: BoxFit.fill,
                      // ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
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
              SizedBox(
                height: 15,
              ),
              // if (getAdvertisementCategoryResult.isNotEmpty)
              //   ListTile(
              //     contentPadding:
              //         const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              //     title: const Text(
              //       'Categories',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.orange),
              //     ),
              //     trailing: InkWell(
              //       borderRadius: const BorderRadius.all(Radius.circular(8)),
              //       onTap: () async {
              //         await Navigator.push(context,
              //             MaterialPageRoute(builder: (context) {
              //           return const AdViewAllCategories();
              //         }));
              //         getAdvertisementPostsApi();
              //       },
              //       child: const Text(
              //         'View All',
              //         style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.normal,
              //             color: Colors.black54,
              //             decoration: TextDecoration.underline),
              //       ),
              //     ),
              //   ),
              if (advertisementCategoryList.isNotEmpty ||
                  advertisementCategoryList != [])
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  //  height: 110,
                  child: showCategory(),
                ),
              // if (getAdvertisementPostsCategoryResult.isNotEmpty)
              //   ListTile(
              //     contentPadding:
              //         const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              //     title: const Text(
              //       'Recent Uploaded',
              //       style: TextStyle(
              //           fontSize: 16,
              //           fontWeight: FontWeight.bold,
              //           color: Colors.orange),
              //     ),
              //     trailing: InkWell(
              //       borderRadius: const BorderRadius.all(Radius.circular(8)),
              //       onTap: () async {
              //         await Navigator.push(context,
              //             MaterialPageRoute(builder: (context) {
              //           return const AdViewAllSubCategories();
              //         }));
              //         getAdvertisementPostsApi();
              //       },
              //       child: const Text(
              //         'View All',
              //         style: TextStyle(
              //             fontSize: 14,
              //             fontWeight: FontWeight.normal,
              //             color: Colors.black54,
              //             decoration: TextDecoration.underline),
              //       ),
              //     ),
              //   ),
              PostByCategoryList.isEmpty||PostByCategoryList==[]?SizedBox():
              showCategoriesPost()
              // showPopularPosts(),
              /*const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                title: Text(
                  'Popular in used Car for Sale',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                trailing: Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: showPopularCars(),
                ),
              ),
              const ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                title: Text(
                  'Popular in Furniture and Garden',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                trailing: Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black54,
                      decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: showPopularFurniture(),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  /// Show Category ...
  Widget showCategory() {
    return showProgressBar
        ? CommonWidget.commonShimmer(
            itemCount: 4,
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
            ))
        : GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 100,mainAxisSpacing: 5),
            itemCount: advertisementCategoryList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdSubCategories(
                        title: advertisementCategoryList[index].name ?? '',
                        advertisement_category_id:
                            advertisementCategoryList[index].id ?? '',
                      ),
                    ),
                  );
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
                                advertisementCategoryList[index].image ?? '',
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
                        advertisementCategoryList[index].name ?? '',
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
    // ListView.builder(
    //         physics: const BouncingScrollPhysics(),
    //         shrinkWrap: true,
    //         //padding: EdgeInsets.zero,
    //         scrollDirection: Axis.horizontal,
    //         itemCount: getAdvertisementCategoryResult.length,
    //         itemBuilder: (context, int index) {
    //           //  GetClubsResult item = controller.getClubsModel!.result![index];
    //           return GestureDetector(
    //             onTap: () async {
    //               await Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => AdSubCategories(
    //                     title: getAdvertisementCategoryResult[index].name ?? '',
    //                     advertisement_category_id:
    //                         getAdvertisementCategoryResult[index].id ?? '',
    //                   ),
    //                 ),
    //               );
    //               getAdvertisementPostsApi();
    //             },
    //             child: Container(
    //               height: 110,
    //               width: 110,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: const BorderRadius.all(Radius.circular(15)),
    //                   border: Border.all(
    //                       color: Colors.orangeAccent.withOpacity(0.7),
    //                       width: 2)),
    //               margin: const EdgeInsets.symmetric(horizontal: 4),
    //               clipBehavior: Clip.hardEdge,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   ClipRRect(
    //                     borderRadius: BorderRadius.circular(10),
    //                     child: CachedNetworkImage(
    //                       imageUrl:
    //                           getAdvertisementCategoryResult[index].image ?? '',
    //                       height: 60,
    //                       fit: BoxFit.fill,
    //                       placeholder: (context, url) => Center(
    //                           child: Shimmer.fromColors(
    //                         baseColor: MyColors.onSecondary.withOpacity(0.4),
    //                         highlightColor:
    //                             Theme.of(context).colorScheme.onSecondary,
    //                         child: Container(
    //                           height: 60,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(16),
    //                             color: MyColors.onSecondary.withOpacity(0.4),
    //                           ),
    //                         ),
    //                       )),
    //                       errorWidget: (context, url, error) =>
    //                           const Icon(Icons.error),
    //                     ),
    //                   ),
    //                   Text(
    //                     getAdvertisementCategoryResult[index].name ?? '',
    //                     style: const TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         fontSize: 13,
    //                         color: Colors.black54),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       );
  }

// Show categories post

  Widget showCategoriesPost() {
    return Column(
      children: [
        for(int i=0;i<PostByCategoryList.length;i++)
          PostByCategoryList[i].count=="0"?SizedBox():
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Text(
                    "Browse ${PostByCategoryList[i].count}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${PostByCategoryList[i].name}",
                    style: TextStyle(
                        color: MyColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (int j = 0; j < PostByCategoryList[i].postData!.length; j++)
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 200, // Set the width of the image here
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              child: CachedNetworkImage(
                                imageUrl: PostByCategoryList[i].postData![j].image ?? '',
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: Shimmer.fromColors(
                                  baseColor: MyColors.onSecondary.withOpacity(0.4),
                                  highlightColor:
                                      Theme.of(context).colorScheme.onSecondary,
                                  child: Container(
                                    height: 100,
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            child: Text(
                              "Nissan Rogue SL 2017",
                              style: TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${PostByCategoryList[i].postData![j].price} OMR",
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
                    ),
                ],
              ),
            ),
            SizedBox(height: 25,)
          ],
        ),],
    );
  }

  /// Show Popular Rental  ...
// Widget showPopularPosts() {
//   return showProgressBar
//       ? CommonWidget.commonShimmer(
//           itemCount: 4,
//           shimmerWidget: Container(
//             height: 100,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             margin:
//                 const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
//             clipBehavior: Clip.hardEdge,
//           ))
//       : GridView.builder(
//           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               childAspectRatio: 100,
//               maxCrossAxisExtent: 140,
//               mainAxisExtent: 170,
//               mainAxisSpacing: 20,crossAxisSpacing: 10),
//           physics: const BouncingScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: getAdvertisementPostsCategoryResult.length,
//           itemBuilder: (context, int index) {
//             //  GetClubsResult item = controller.getClubsModel!.result![index];
//             return Card(
//               shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(4)),
//               ),
//               elevation: 2,
//               clipBehavior: Clip.hardEdge,
//               child: GestureDetector(
//                 onTap: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => AdProductDetail(
//                             id: getAdvertisementPostsCategoryResult[index]
//                                     .id ??
//                                 '')),
//                   );
//                   getAdvertisementPostsApi();
//                 },
//                 child: Container(
//                   height: 160,
//                   // width: 110,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Stack(
//                         alignment: Alignment.topRight,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                                   getAdvertisementPostsCategoryResult[index]
//                                           .image ??
//                                       '',
//                               height: 100,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => Center(
//                                 child: Shimmer.fromColors(
//                                   baseColor:
//                                       MyColors.onSecondary.withOpacity(0.4),
//                                   highlightColor: Theme.of(context)
//                                       .colorScheme
//                                       .onSecondary,
//                                   child: Container(
//                                     height: 85,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(16),
//                                       color: MyColors.onSecondary
//                                           .withOpacity(0.4),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               showProgressBar = true;
//                               await Webservices.getMap(
//                                   "$baseUrl$advertisement_post_fav?advertisement_post_id=${(getAdvertisementPostsCategoryResult[index].id != null && getAdvertisementPostsCategoryResult[index].id!.isNotEmpty) ? getAdvertisementPostsCategoryResult[index].id! : ''}&user_id=${userId}");
//                               var res = await Webservices.getMap(
//                                   "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
//                               print("status from api ${res}");
//                               final resdata =
//                                   GetAdvertisementCategoryModel.fromJson(res);
//                               print(resdata);
//                               if (resdata.result != null &&
//                                   resdata.status == '1') {
//                                 getAdvertisementPostsCategoryResult =
//                                     resdata.result!;
//                                 setState(() {});
//                               } else {
//                                 showSnackbar(context, resdata.message ?? '');
//                               }
//                               showProgressBar = false;
//                             },
//                             borderRadius: BorderRadius.circular(4),
//                             child: Container(
//                               padding: const EdgeInsets.all(4),
//                               margin: const EdgeInsets.all(4),
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(4)),
//                               child: Icon(
//                                   getAdvertisementPostsCategoryResult[index]
//                                                   .advertisementPostFav !=
//                                               null &&
//                                           getAdvertisementPostsCategoryResult[
//                                                       index]
//                                                   .advertisementPostFav ==
//                                               'true'
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: Colors.red),
//                             ),
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               getAdvertisementPostsCategoryResult[index].describeProperty??"dsd",
//                               maxLines: 1,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                   color: Colors.orange),
//                             ),
//                             Text(
//                               getAdvertisementPostsCategoryResult[index]
//                                       .describeProperty ??
//                                   '',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.normal,
//                                   fontSize: 12,
//                                   color: Colors.black54),
//                               maxLines: 2,
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
// }
}
