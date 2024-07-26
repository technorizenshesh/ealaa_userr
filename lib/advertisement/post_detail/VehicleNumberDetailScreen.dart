import 'package:ealaa_userr/advertisement/UpdatePosts/update_VehicleNumbers.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../ad_chat_room.dart';
import '../ad_my_ads_post.dart';

class VehicleNumberDetailScreen extends StatefulWidget {
  String ads_post;
  String ads_post_id;
  String user_id_value;

  VehicleNumberDetailScreen(
      {super.key,
      required this.ads_post,
      required this.ads_post_id,
      this.user_id_value = ''});

  @override
  State<VehicleNumberDetailScreen> createState() =>
      _VehicleNumberDetailScreenState();
}

class _VehicleNumberDetailScreenState extends State<VehicleNumberDetailScreen> {
  List<Map<String, String>> detailElements = [
    {'title': 'Letter', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Vehicle Number', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Plate Type', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Transfer Type', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Governorate', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Ad Number', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Published Date', 'Image': 'assets/icons_for_car/ic_ad.png'},
  ];

  bool showProgressBar = true;
  PostListDetails? result;

  getAdsPostDetails() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_post_details?ads_post=${widget.ads_post}&ads_post_id=${widget.ads_post_id}&user_id=$userId");
    showProgressBar = false;
    GetAdsPostDetailsModel getAdsPostDetailsModel =
        GetAdsPostDetailsModel.fromJson(res);
    if (getAdsPostDetailsModel.result != null) {
      result = getAdsPostDetailsModel.result!;
      setState(() {});
    } else {
      showSnackbar(context, 'Something went wrong!');
      showProgressBar = false;
      setState(() {});
    }
  }

  adsPostDetailsFavourite() async {
    await Webservices.getMap(
        "$baseUrl$ads_post_details_favourite?ads_details_id=${result?.vehicleNumberId}&type=${widget.ads_post}&user_id=$userId");
    setState(() {});
    getAdsPostDetails();
  }

  @override
  void initState() {
    getAdsPostDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
        actions: [
          GestureDetector(
            onTap: () {
              try {
                Uri uri = Uri.parse('qrImage');
                Share.shareUri(uri);
              } catch (e) {
                print('Share Error: $e');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.file_upload_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              adsPostDetailsFavourite();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white)),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              margin: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.star,
                color: result?.postFav == 'yes' ? Colors.yellow : Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.user_id_value == userId
          ? null
          : Material(
              elevation: 30,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final Uri url = Uri(
                                scheme: 'tel',
                                path: result?.usersDetails?.mobile);
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
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.orange,width: .2)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Call',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (result != null &&
                                    result?.usersDetails?.id != null &&
                                    result!.usersDetails!.id!.isNotEmpty ||
                                result != null &&
                                    result?.usersDetails?.userName != null &&
                                    result!
                                        .usersDetails!.userName!.isNotEmpty ||
                                result != null &&
                                    result?.usersDetails?.image != null &&
                                    result!.usersDetails!.image!.isNotEmpty) {
                              push(
                                context: context,
                                screen: AdChatRoom(
                                  id: result!.usersDetails!.id!,
                                  name: result!.usersDetails!.userName!,
                                  image: result!.usersDetails!.image!,
                                ),
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.orange,width: .2)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.chat_bubble_outline,
                                    color: Colors.orange,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Chat',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      body: SingleChildScrollView(
        child: showProgressBar
            ? Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              )
            : result == null
                ? Image.asset("assets/images/NoDataFound.png")
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        child: CachedNetworkImage(
                          imageUrl: result?.vehicleNumberImage ?? '',
                          fit: BoxFit.contain,
                          height: 300,
                          placeholder: (context, url) => Center(
                            child: Shimmer.fromColors(
                              baseColor: MyColors.onSecondary.withOpacity(0.4),
                              highlightColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                color: MyColors.onSecondary.withOpacity(0.4),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          result?.vehicleNumberDescription ?? '',
                          maxLines: 1,
                          style: TextStyle(
                              color: AppColors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "${result?.vehicleNumberPrice ?? ''} OMR",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  childAspectRatio: 100,
                                  maxCrossAxisExtent: 200,
                                  mainAxisExtent: 70,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: detailElements.length,
                                itemBuilder: (context, int index) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                Colors.grey.withOpacity(0.3)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${detailElements[index]['title']}",
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  fontSize: 16),
                                            ),
                                            Image.asset(
                                              "${detailElements[index]['Image']}",
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              height: 18,
                                              width: 18,
                                            )
                                          ],
                                        ),
                                        Text(
                                          getTextMethod(index: index),
                                          maxLines: 1,
                                          style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              result?.vehicleNumberDescription ?? '',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      widget.user_id_value == userId ?
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: RoundButton(
                          height: 45,
                          borderRadius: 10,
                          title: 'Update your post',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateVehicleNumbers(adType: result?.adsType ?? '', advertisement_category_id: result?.adsCategoryId ?? '', advertisement_sub_category_id: result?.adsSubCategoryId ?? '', ads_post_id: widget.ads_post_id ?? '')));
                          },
                          fontsize: 18,
                          fontweight: FontWeight.w500,
                        ),
                      ):
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Contact the seller",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdMyAdsPosts(
                                        userIdValue: (result != null &&
                                                result!.usersDetails != null &&
                                                result!.usersDetails!.id !=
                                                    null &&
                                                result!.usersDetails!.id!
                                                    .isNotEmpty)
                                            ? result!.usersDetails!.id!
                                            : null,
                                      ),
                                    ));
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: SizedBox(
                                  width: 44,
                                  height: 44,
                                  child: Image.network(
                                      (result != null &&
                                              result!.usersDetails != null &&
                                              result!.usersDetails!.image !=
                                                  null &&
                                              result!.usersDetails!.image!
                                                  .isNotEmpty)
                                          ? result!.usersDetails!.image!
                                          : 'https://avatar.iran.liara.run/public/37',
                                      fit: BoxFit.fill),
                                ),
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (result != null &&
                                            result!.usersDetails != null &&
                                            result!.usersDetails!.fullName !=
                                                null &&
                                            result!.usersDetails!.fullName!
                                                .isNotEmpty)
                                        ? result?.usersDetails?.fullName ?? ''
                                        : 'Unnamed',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    (result != null &&
                                            result!.usersDetails != null &&
                                            result!.usersDetails!.email !=
                                                null &&
                                            result!.usersDetails!.email!
                                                .isNotEmpty)
                                        ? result?.usersDetails?.email ?? ''
                                        : 'Unnamed',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
      ),
    );
  }

  String getTextMethod({required int index}) {
    switch (index) {
      case 0:
        return result?.letterNameEnglish ?? '';
      case 1:
        return result?.uploadVehiclesNumbers ?? '';
      case 2:
        return result?.plateTypeName ?? '';
      case 3:
        return result?.adsType ?? '';
      case 4:
        return result?.governorateName ?? '';
      case 5:
        return result?.vehicleNumberPhone ?? '';
      case 6:
        return result?.adsCreatedAt ?? '';
      default:
        return 'test';
    }
  }
}
