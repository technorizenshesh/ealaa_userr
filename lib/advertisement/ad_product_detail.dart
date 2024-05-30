import 'package:carousel_slider/carousel_slider.dart';
import 'package:ealaa_userr/advertisement/chat_message_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Model/advertisement_model/get_advertisement_details_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';

class AdProductDetail extends StatefulWidget {
  final String id;

  const AdProductDetail({super.key, required this.id});

  @override
  State<AdProductDetail> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdProductDetail> {
  int activeIndex = 0;
  bool showProgressBar = false;

  GetAdvertisementDetailsResult? getAdvertisementPostsCategoryResult;

  getAdvertisementDetailsApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_details?advertisement_posts_id=${widget.id}&user_id=${userId}");
    print("status from api ${res}");
    final resdata = GetAdvertisementDetailsModel.fromJson(res);
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
    getAdvertisementDetailsApi();
    super.initState();
  }

  Future<void> share() async {
    try {
      Share.share('Hii....');
    } catch (e) {
      print('Share Error: $e');
    }
  }

  clickOnChatButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdChatMessageDetail()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Assign the key to Scaffold.
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
          'Product Detail', // Your badge count here
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
                    share();
                  },
                  child: const Icon(
                    Icons.share,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                // SvgPicture.asset("assets/images/Notification.svg",height: 30,color: MyColors.primaryColor,)
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14),
            Stack(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: height * 0.5,
                    aspectRatio: width / height * 0.5,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, reason) =>
                        setState(() => activeIndex = index),
                  ),
                  itemCount: 1,
                  itemBuilder: (context, int index, int realIndex) {
                    return Container(
                      width: width,
                      height: height * 0.5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          imageUrl:
                              getAdvertisementPostsCategoryResult?.image ?? '',
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                            baseColor: MyColors.onSecondary.withOpacity(0.4),
                            highlightColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: Container(
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
                    );
                  },
                ),
                Positioned(
                  top: 14,
                  right: 10,
                  child: InkWell(
                    onTap: () async {
                      showProgressBar = true;
                      await Webservices.getMap(
                          "$baseUrl$advertisement_post_fav?advertisement_post_id=${(getAdvertisementPostsCategoryResult != null && getAdvertisementPostsCategoryResult!.id != null && getAdvertisementPostsCategoryResult!.id!.isNotEmpty) ? getAdvertisementPostsCategoryResult!.id! : ''}&user_id=${userId}");
                      var res = await Webservices.getMap(
                          "$baseUrl$get_advertisement_details?advertisement_posts_id=${widget.id}&user_id=${userId}");
                      print("status from api ${res}");
                      final resdata =
                          GetAdvertisementDetailsModel.fromJson(res);
                      print(resdata);
                      if (resdata.result != null && resdata.status == '1') {
                        getAdvertisementPostsCategoryResult = resdata.result!;
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
                          getAdvertisementPostsCategoryResult
                                          ?.advertisementPostFav !=
                                      null &&
                                  getAdvertisementPostsCategoryResult
                                          ?.advertisementPostFav ==
                                      'true'
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  right: 15,
                  child: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Text(
                      '${getAdvertisementPostsCategoryResult?.count} Likes',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.orange),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 1,
                effect: const ExpandingDotsEffect(
                  dotHeight: 6,
                  dotWidth: 6,
                  activeDotColor: MyColors.primaryColor,
                  dotColor: Color(0xffD9D9D9),
                ),
              ),
            ),
            ListTile(
              title: Text(
                getAdvertisementPostsCategoryResult?.bedroom ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              trailing: Text(
                'AED- ${getAdvertisementPostsCategoryResult?.price ?? ''}',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.orange),
              ),
            ),
            /* const ListTile(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              title: Text(
                'NEW IN CONDITION',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              trailing: Text(
                '3 days ago by',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.black54),
              ),
            ),*/
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                maxLines: null,
                getAdvertisementPostsCategoryResult?.describeProperty ?? '',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                getAdvertisementPostsCategoryResult?.locationPin ?? '',
                style: TextStyle(fontSize: 16, color: Colors.orange),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Meet The Seller',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl:
                      getAdvertisementPostsCategoryResult?.userDetails?.image ??
                          '',
                  height: 60,
                  width: 60,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                    baseColor: MyColors.onSecondary.withOpacity(0.4),
                    highlightColor: Theme.of(context).colorScheme.onSecondary,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: MyColors.onSecondary.withOpacity(0.4),
                      ),
                    ),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(
                getAdvertisementPostsCategoryResult?.userDetails?.email ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              subtitle: Text(
                timeAgoString(getAdvertisementPostsCategoryResult
                            ?.userDetails?.dateTime !=
                        null
                    ? DateTime.parse(getAdvertisementPostsCategoryResult
                            ?.userDetails?.dateTime ??
                        '')
                    : DateTime.now()),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54),
              ),
              /*trailing: const Text(
                'AED- 33,000',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.orange),
              ),*/
            ),
            SizedBox(
              height: height * 0.01,
            ),
            CommonWidget.commonElevatedButton(
              onPressed: () {
                clickOnChatButton();
              },
              context: context,
              child: const Text(
                'Chat',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
              buttonMargin:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              buttonColor: Colors.orange,
            ),
            CommonWidget.commonElevatedButton(
              onPressed: () {},
              context: context,
              child: const Text(
                'Make Offer',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange),
              ),
              buttonMargin:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 10),
              buttonColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  String timeAgoString(DateTime pastTime) {
    // Get the current time
    DateTime currentTime = DateTime.now();

    // Calculate the difference between pastTime and currentTime
    Duration difference = currentTime.difference(pastTime);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      int months = difference.inDays ~/ 30;
      return '$months months ago';
    } else {
      int years = difference.inDays ~/ 365;
      return '$years years ago';
    }
  }
}
