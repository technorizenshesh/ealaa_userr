import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_product_detail.dart';
import 'package:ealaa_userr/advertisement/ad_sub_categories.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'ad_view_all_categories.dart';
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

  List<Map<String, String>> categoryList = [
    {'name': "Rent Property", 'image': "assets/icons/ic_category1.png"},
    {'name': "Room Rent", 'image': "assets/icons/ic_category2.png"},
    {'name': "Sale Property", 'image': "assets/icons/ic_category3.png"},
    {'name': "Rent Property", 'image': "assets/icons/ic_category1.png"},
    {'name': "Room Rent", 'image': "assets/icons/ic_category2.png"},
    {'name': "Sale Property", 'image': "assets/icons/ic_category3.png"},
  ];

  List<Map<String, String>> rentalList = [
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
  ];
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

  List<Map<String, String>> furnitureList = [
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
  ];

  List<GetAdvertisementCategoryResult> getAdvertisementCategoryResult = [];
  List<GetAdvertisementCategoryResult> getAdvertisementPostsCategoryResult = [];

  currentDate() {
    var now = DateTime.now();
    var formatter = DateFormat.MMMEd();
    currentTime = formatter.format(now);
    if (kDebugMode) {
      print(currentTime);
    } // 2016-01-25
  }

  clickOnItem(String image) {
    /*Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AdProductDetail(
                id: getAdvertisementPostsCategoryResult[index]
                    .id ??
                    '')),
      );*/
  }

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  getAdvertisementCategoryApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdvertisementCategoryResult.clear();
      getAdvertisementCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  getAdvertisementPostsApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap(
        "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
    print("status from api ${res}");
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdvertisementPostsCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  @override
  void initState() {
    getAdvertisementCategoryApi();
    getAdvertisementPostsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
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
              if (getAdvertisementCategoryResult.isNotEmpty)
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  title: const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  trailing: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AdViewAllCategories();
                      }));
                      getAdvertisementPostsApi();
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              if (getAdvertisementCategoryResult.isNotEmpty)
                SizedBox(
                  height: 110,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: showCategory(),
                  ),
                ),
              if (getAdvertisementPostsCategoryResult.isNotEmpty)
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  title: const Text(
                    'Recent Uploaded',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                  trailing: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AdViewAllSubCategories();
                      }));
                      getAdvertisementPostsApi();
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black54,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              showPopularRental(),
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
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            //padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: getAdvertisementCategoryResult.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdSubCategories(
                        title: getAdvertisementCategoryResult[index].name ?? '',
                        advertisement_category_id:
                            getAdvertisementCategoryResult[index].id ?? '',
                      ),
                    ),
                  );
                  getAdvertisementPostsApi();
                },
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: Border.all(
                          color: Colors.orangeAccent.withOpacity(0.7),
                          width: 2)),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              getAdvertisementCategoryResult[index].image ?? '',
                          height: 60,
                          fit: BoxFit.fill,
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
                              const Icon(Icons.error),
                        ),
                      ),
                      Text(
                        getAdvertisementCategoryResult[index].name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                            color: Colors.black54),
                      )
                    ],
                  ),
                ),
              );
            },
          );
  }

  /// Show Popular Rental  ...
  Widget showPopularRental() {
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 100,
                maxCrossAxisExtent: 140,
                mainAxisExtent: 170,
                mainAxisSpacing: 4),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: getAdvertisementPostsCategoryResult.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdProductDetail(
                              id: getAdvertisementPostsCategoryResult[index]
                                      .id ??
                                  '')),
                    );
                    getAdvertisementPostsApi();
                  },
                  child: Container(
                    height: 160,
                    // width: 110,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl:
                                    getAdvertisementPostsCategoryResult[index]
                                            .image ??
                                        '',
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: Shimmer.fromColors(
                                    baseColor:
                                        MyColors.onSecondary.withOpacity(0.4),
                                    highlightColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    child: Container(
                                      height: 85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: MyColors.onSecondary
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                showProgressBar = true;
                                await Webservices.getMap(
                                    "$baseUrl$advertisement_post_fav?advertisement_post_id=${(getAdvertisementPostsCategoryResult[index].id != null && getAdvertisementPostsCategoryResult[index].id!.isNotEmpty) ? getAdvertisementPostsCategoryResult[index].id! : ''}&user_id=${userId}");
                                var res = await Webservices.getMap(
                                    "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
                                print("status from api ${res}");
                                final resdata =
                                    GetAdvertisementCategoryModel.fromJson(res);
                                print(resdata);
                                if (resdata.result != null &&
                                    resdata.status == '1') {
                                  getAdvertisementPostsCategoryResult =
                                      resdata.result!;
                                  setState(() {});
                                } else {
                                  showSnackbar(context, resdata.message ?? '');
                                }
                                showProgressBar = false;
                              },
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(
                                    getAdvertisementPostsCategoryResult[index]
                                                    .advertisementPostFav !=
                                                null &&
                                            getAdvertisementPostsCategoryResult[
                                                        index]
                                                    .advertisementPostFav ==
                                                'true'
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                getAdvertisementPostsCategoryResult[index]
                                        .bedroom ??
                                    'Product',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                getAdvertisementPostsCategoryResult[index]
                                        .describeProperty ??
                                    '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black54),
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  /// Show Popular Cars  ...
  Widget showPopularCars() {
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
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: carList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                margin:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    clickOnItem(carList[index]['image'] ?? '');
                  },
                  child: Container(
                    height: 160,
                    width: 110,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              carList[index]['image'] ?? '',
                              height: 85,
                              width: 110,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 5,
                              right: 2,
                              child: Image.asset(
                                MyImages.icUnlike,
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 3, bottom: 10, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                carList[index]['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                carList[index]['description'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black54),
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  /// Show Popular Furniture  ...
  Widget showPopularFurniture() {
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
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: furnitureList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                margin:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    clickOnItem(furnitureList[index]['image'] ?? '');
                  },
                  child: Container(
                    height: 160,
                    width: 110,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              furnitureList[index]['image'] ?? '',
                              height: 85,
                              width: 110,
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 5,
                              right: 2,
                              child: Image.asset(
                                MyImages.icUnlike,
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 3, bottom: 10, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                furnitureList[index]['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                furnitureList[index]['description'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black54),
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
