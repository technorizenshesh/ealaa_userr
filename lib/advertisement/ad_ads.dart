import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_product_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';
import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';

class AdAds extends StatefulWidget {
  const AdAds({super.key});

  @override
  State<AdAds> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdAds> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  List<Map<String, String>> furnitureList = [
    {
      'name': "Studio- 4 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "Studio- 3 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
    {
      'name': "Studio- 4 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "Studio- 3 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
  ];
  int drawerIndex = 0;
  String notificationCount = "";
  List<GetAdsWithCategoryHomeResult> getAdvertisementCategoryResult = [];
  clickOnItem(String image) {
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdProductDetail(image: image)),
    );*/
  }

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  getAdvertisementPostsApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap(
        "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
    print("status from api ${res}");
    final resdata = GetAdsWithCategoryHomeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdvertisementCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  @override
  void initState() {
    getAdvertisementPostsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
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
        centerTitle: true,
        title: const Text(
          'Ads', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
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
        ],
      ),
      drawer: filterDrawer(),
      endDrawer: shortDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      print('hiiiii......');
                      setState(() {
                        drawerIndex = 0;
                      });
                      _key.currentState!.openDrawer();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.icFilter2,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
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
                            hintText: 'Search best deal',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black54),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      print('hiiiii......');
                      setState(() {
                        drawerIndex = 1;
                      });
                      _key.currentState!.openEndDrawer();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.icFilter1,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: showCurrentAds(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTimeToTimeAgo(String? dateTime) {
    if (dateTime == null) return '';

    DateTime parsedDateTime = DateTime.parse(dateTime);
    Duration difference = DateTime.now().difference(parsedDateTime);

    if (difference.inDays > 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inHours > 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inMinutes > 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes == 1) {
      return '1 minute ago';
    } else {
      return 'just now';
    }
  }

  /// Show Popular Furniture  ...
  Widget showCurrentAds() {
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
            scrollDirection: Axis.vertical,
            itemCount: getAdvertisementCategoryResult.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdProductDetail(
                          id: getAdvertisementCategoryResult[index].id ?? ''),
                    ),
                  );
                },
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  elevation: 2,
                  clipBehavior: Clip.hardEdge,
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  child: Container(
                    height: 230,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  topLeft: Radius.circular(25)),
                              child: CachedNetworkImage(
                                imageUrl: getAdvertisementCategoryResult[index]
                                        .image ??
                                    '',
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: Shimmer.fromColors(
                                  baseColor:
                                      MyColors.onSecondary.withOpacity(0.4),
                                  highlightColor:
                                      Theme.of(context).colorScheme.onSecondary,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color:
                                          MyColors.onSecondary.withOpacity(0.4),
                                    ),
                                  ),
                                )),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            /*InkWell(
                              onTap: () async {
                                showProgressBar = true;
                                await Webservices.getMap(
                                    "$baseUrl$advertisement_post_fav?advertisement_post_id=${(getAdvertisementCategoryResult[index].id != null && getAdvertisementCategoryResult[index].id!.isNotEmpty) ? getAdvertisementCategoryResult[index].id! : ''}&user_id=${userId}");
                                var res = await Webservices.getMap(
                                    "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
                                print("status from api ${res}");
                                final resdata =
                                GetAdsWithCategoryHomeModel.fromJson(res);
                                print(resdata);
                                if (resdata.result != null &&
                                    resdata.status == '1') {
                                  getAdvertisementCategoryResult =
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
                                margin: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(
                                    getAdvertisementCategoryResult[index]
                                                    .advertisementPostFav !=
                                                null &&
                                            getAdvertisementCategoryResult[
                                                        index]
                                                    .advertisementPostFav ==
                                                'true'
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red),
                              ),
                            )*/
                          ],
                        ),
                        /*Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                getAdvertisementCategoryResult[index].bedroom ??
                                    '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                'AED- ${getAdvertisementCategoryResult[index].totalClosingFee ?? ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Text(
                                      getAdvertisementCategoryResult[index]
                                              .describeProperty ??
                                          '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 12,
                                          color: Colors.black54),
                                      maxLines: 1,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    formatDateTimeToTimeAgo(
                                        getAdvertisementCategoryResult[index]
                                                .dateTime ??
                                            ''),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12,
                                        color: Colors.black54),
                                    maxLines: 2,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )*/
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }

  /// OpenFilterDrawer ....
  Widget filterDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 40, bottom: 20),
            child: const Text('Filter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Category',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Type',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'City',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Show english Ads only',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Real Estate Agent',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Amenties',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Listed By',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CommonWidget.commonElevatedButton(
                      onPressed: () {},
                      context: context,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      buttonMargin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// OpenShortDrawer ....
  Widget shortDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 40, bottom: 20),
            child: const Text('Sort',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Listed By',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CommonWidget.commonElevatedButton(
                      onPressed: () {},
                      context: context,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      buttonMargin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
