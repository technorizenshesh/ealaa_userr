import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';

class RealEstateDetailScreen extends StatefulWidget {
  String ads_post;
  String ads_post_id;

  RealEstateDetailScreen(
      {super.key, required this.ads_post, required this.ads_post_id});

  @override
  State<RealEstateDetailScreen> createState() => _RealEstateDetailScreenState();
}

class _RealEstateDetailScreenState extends State<RealEstateDetailScreen> {
  List<Map<String, String>> detailElements = [
    {'title': 'Body', 'Image': 'assets/icons_for_car/ic_body.png'},
    {'title': 'Governorate', 'Image': 'assets/icons_for_car/ic_model_year.png'},
    {'title': 'State', 'Image': 'assets/icons_for_car/ic_location.png'},
    {'title': 'City', 'Image': 'assets/icons_for_car/ic_location.png'},
    {
      'title': 'Land Area',
      'Image': 'assets/icons_for_car/ic_ad.png'
    },
    {'title': 'Walled', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {
      'title': 'Parking',
      'Image': 'assets/icons_for_car/ic_ad.png'
    },
    {'title': 'Price', 'Image': 'assets/icons_for_car/ic_price.png'},
    {'title': 'Ad Number', 'Image': 'assets/icons_for_car/ic_ad.png'},
    {'title': 'Published Date', 'Image': 'assets/icons_for_car/ic_ad.png'},
  ];

  bool showProgressBar = true;
  PostListDetails? result;

  getAdsPostDetails() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_post_details?ads_post=${widget.ads_post_id}&ads_post_id=${widget.ads_post}");
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
        /* actions: [
          Container(
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
        ],*/
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
                          imageUrl: result?.realStateAdsUploadImage ?? '',
                          fit: BoxFit.fill,
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
                          result?.realStateAdsAdditionalDetailDescription ?? '',
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
                          "${result?.realStateAdsAdditionalDetailPrice ?? ''} OMR",
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
                                  maxCrossAxisExtent: 170,
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
                              result?.realStateAdsAdditionalDetailDescription ??
                                  '',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 14),
                            ),
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
                              "Contact the seller",
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
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
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
      ),
    );
  }

  String getTextMethod({required int index}) {
    switch (index) {
      case 0:
          return result?.realStateAdsAdditionalDetailDescription??'';
      case 1:
        return result?.governorateName??'';
      case 2:
        return result?.stateName??'';
      case 3:
        return result?.cityName??'';
      case 4:
        return result?.realStateAdsAdditionalDetailLandArea??'';
      case 5:
        return result?.wallName??'';
      case 6:
        return result?.parkingName??'';
      case 7:
        return result?.realStateAdsAdditionalDetailPrice??'';
      case 8:
        return result?.realStateAdsAdditionalDetailPhone??'';
      case 9:
        return result?.adsCreatedAt??'';
      default:
        return 'test';
    }
  }
}
