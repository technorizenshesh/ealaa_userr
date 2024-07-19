import 'package:ealaa_userr/advertisement/post_detail/AnimalsAndSuppliesDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/ElectronicsDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/PhoneNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/RealEstateDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehiclePartsAndAccessoriesDetailScreen.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../Model/advertisement_model/get_ads_with_category_subcategory_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';

class AdMyAdsPosts extends StatefulWidget {
  String? userIdValue;
  bool FavValue;
  AdMyAdsPosts({super.key,this.userIdValue,this.FavValue = false});

  @override
  State<AdMyAdsPosts> createState() => _AdMyAdsPostsState();
}

class _AdMyAdsPostsState extends State<AdMyAdsPosts> {
  bool showProgressBarForCategory = false;
  bool showProgressBar = false;
  int selectedIndex = 0;
  List<PostListDetails> getAdsWithCategorySubCategoryResult = [];

  getAdvertisementCategoryApi() async {
    setState(() {});
    showProgressBarForCategory = true;
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category?post_fav=${widget.FavValue ?"yes":"no"}");
    showProgressBarForCategory = false;
    setState(() {});
    final resdata = GetAdsWithCategoryHomeModel.fromJson(res);
    if (resdata.result != null && resdata.status == '1') {
      getAdsWithCategoryHomeResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getAdsMyPostApi({String adsPost = ''}) async {
    setState(() {});
    showProgressBar = true;
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_my_post?user_id=${widget.userIdValue ?? userId}&ads_post=$adsPost");
    getAdsWithCategorySubCategoryResult.clear();
    showProgressBar = false;
    setState(() {});
    final resdata = GetAdsWithCategorySubCategoryModel.fromJson(res);
    if (resdata.result != null && resdata.status == '1') {
      getAdsWithCategorySubCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    if (getAdsWithCategoryHomeResult == [] ||
        getAdsWithCategoryHomeResult.isEmpty) {
      getAdvertisementCategoryApi();
    } else {
      getAdsMyPostApi(
          adsPost: getAdsWithCategoryHomeResult[selectedIndex].type ?? '');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        centerTitle: true,
        title: const Text(
          'My Ads', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Column(
        children: [
          if (!showProgressBarForCategory)
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: getAdsWithCategoryHomeResult.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      selectedIndex = index;
                      setState(() {});
                      getAdsMyPostApi(
                          adsPost:
                              getAdsWithCategoryHomeResult[index].type ?? '');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: selectedIndex == index
                                  ? Colors.orange
                                  : Colors.black),
                        ),
                        child: Center(
                            child: Text(
                          getAdsWithCategoryHomeResult[index].name ?? '',
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.orange
                                  : Colors.black),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          Expanded(child: showCurrentAds()),
        ],
      ),
    );
  }

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
            ),
          )
        : getAdsWithCategorySubCategoryResult.isEmpty
            ? Image.asset("assets/images/NoDataFound.png")
            : ListView.builder(
                itemCount: getAdsWithCategorySubCategoryResult.length,
                itemBuilder: (context, index) {
                  return listOfData(index: index);
                },
              );
  }

  Widget listOfData({required int index}) {
    if (getAdsWithCategoryHomeResult[selectedIndex].id != null &&
        getAdsWithCategoryHomeResult[selectedIndex].id!.isNotEmpty) {
      if (getAdsWithCategoryHomeResult[selectedIndex].id == '1' ||
          getAdsWithCategoryHomeResult[selectedIndex].id == '2') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehicleDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl: getAdsWithCategorySubCategoryResult[index]
                    .vehicleAdsUploadImage ??
                '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .vehicleAdsAdditionalDetailDescription ??
                '',
            price: getAdsWithCategorySubCategoryResult[index]
                    .vehicleAdsAdditionalDetailPrice ??
                '0',
            firstText:
                '${getAdsWithCategorySubCategoryResult[index].vehicleAdsAdditionalDetailDistanceTravelled ?? '0'} km',
            secondText: getAdsWithCategorySubCategoryResult[index]
                    .vehicleAdsDetailOrigin ??
                '',
            thirdText: getAdsWithCategorySubCategoryResult[index]
                    .vehicleAdsDetailState ??
                '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_transmission.png',
            firstIcon: 'assets/icons_for_car/ic_kilometer.png',
            thirdIcon: 'assets/icons_for_car/ic_location.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '3') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehiclePartsAndAccessoriesDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl:
                getAdsWithCategorySubCategoryResult[index].vehiclePartImage ??
                    '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .vehiclePartDescription ??
                '',
            price:
                getAdsWithCategorySubCategoryResult[index].vehiclePartPrice ??
                    '',
            firstText:
                getAdsWithCategorySubCategoryResult[index].partName ?? '',
            secondText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].modelTrimName ??
                    '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_location.png',
            firstIcon: 'assets/icons_for_car/ic_engine_size.png',
            thirdIcon: 'assets/icons_for_car/ic_transmission.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '4') {
        return GestureDetector(
          onTap: () {
            print(getAdsWithCategoryHomeResult[selectedIndex].id);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehicleNumberDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl:
                getAdsWithCategorySubCategoryResult[index].vehicleNumberImage ??
                    '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .vehicleNumberDescription ??
                '',
            price:
                getAdsWithCategorySubCategoryResult[index].vehicleNumberPrice ??
                    '0',
            firstText:
                getAdsWithCategorySubCategoryResult[index].plateTypeName ?? '',
            secondText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].governorateName ??
                    '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_location.png',
            firstIcon: 'assets/icons_for_car/ic_ad.png',
            thirdIcon: 'assets/icons_for_car/ic_transmission.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '5' ||
          getAdsWithCategoryHomeResult[selectedIndex].id == '6') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return RealEstateDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl: getAdsWithCategorySubCategoryResult[index]
                    .realStateAdsUploadImage ??
                '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .realStateAdsAdditionalDetailDescription ??
                '',
            price: getAdsWithCategorySubCategoryResult[index]
                    .realStateAdsAdditionalDetailPrice ??
                '0',
            firstText:
                '${getAdsWithCategorySubCategoryResult[index].realStateAdsAdditionalDetailLandArea ?? ''} SQM',
            secondText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].parkingName ?? '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_location.png',
            firstIcon: 'assets/icons_for_car/ic_ad.png',
            thirdIcon: 'assets/icons_for_car/ic_ad.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '7' ||
          getAdsWithCategoryHomeResult[selectedIndex].id == '8') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ElectronicsDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl: getAdsWithCategorySubCategoryResult[index]
                    .electronicsAdsImage ??
                '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .electronicsAdsDescription ??
                '',
            price: getAdsWithCategorySubCategoryResult[index]
                    .electronicsAdsPrice ??
                '0',
            firstText:
                getAdsWithCategorySubCategoryResult[index].subCategoryName ??
                    '',
            secondText:
                getAdsWithCategorySubCategoryResult[index].storageName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].governorateName ??
                    '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_ad.png',
            firstIcon: 'assets/icons_for_car/ic_ad.png',
            thirdIcon: 'assets/icons_for_car/ic_ad.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '9') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PhoneNumberDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl: getAdsWithCategorySubCategoryResult[index]
                    .phoneNumberAdsImage ??
                '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .phoneNumberAdsDescription ??
                '',
            price: getAdsWithCategorySubCategoryResult[index]
                    .phoneNumberAdsPrice ??
                '0',
            firstText:
                getAdsWithCategorySubCategoryResult[index].operatorsName ?? '',
            secondText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].governorateName ??
                    '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_ad.png',
            firstIcon: 'assets/icons_for_car/ic_ad.png',
            thirdIcon: 'assets/icons_for_car/ic_ad.png',
          ),
        );
      } else if (getAdsWithCategoryHomeResult[selectedIndex].id == '10') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AnimalsAndSuppliesDetailScreen(
                  user_id_value: userId,
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl:
                getAdsWithCategorySubCategoryResult[index].animalsAdsImage ??
                    '',
            name: getAdsWithCategorySubCategoryResult[index]
                    .animalsAdsDescription ??
                '',
            price: getAdsWithCategorySubCategoryResult[index].animalsAdsPrice ??
                '0',
            firstText:
                getAdsWithCategorySubCategoryResult[index].subCategoryName ??
                    '',
            secondText:
                getAdsWithCategorySubCategoryResult[index].breedName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                '',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                '',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                '',
            secondIcon: 'assets/icons_for_car/ic_ad.png',
            firstIcon: 'assets/icons_for_car/ic_ad.png',
            thirdIcon: 'assets/icons_for_car/ic_location.png',
          ),
        );
      }
    }
    return SizedBox();
  }

  Widget dataContainer(
      {required String imageUrl,
      required String name,
      required String price,
      required String firstText,
      required String secondText,
      required String thirdText,
      required String firstIcon,
      required String secondIcon,
      required String thirdIcon,
      required String callText,
      required String smsText,
      required String userName,
      required String image}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.38,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * .2,
                        placeholder: (context, url) => Center(
                          child: Shimmer.fromColors(
                            baseColor: MyColors.onSecondary.withOpacity(0.4),
                            highlightColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.25,
                              color: MyColors.onSecondary.withOpacity(0.4),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${price} OMR",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
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
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.1))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.file_upload_outlined,
                                      color: Colors.black.withOpacity(0.5),
                                      size: 18,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "Share",
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 34.0),
                          child: Row(
                            children: [
                              Image.asset(
                                firstIcon,
                                color: Colors.black.withOpacity(0.4),
                                height: 18,
                                width: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Divider(),
                                ),
                              ),
                              Image.asset(
                                secondIcon,
                                color: Colors.black.withOpacity(0.4),
                                height: 18,
                                width: 18,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Divider(),
                                ),
                              ),
                              Image.asset(
                                thirdIcon,
                                color: Colors.black.withOpacity(0.4),
                                height: 18,
                                width: 18,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Text(
                                firstText,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.transparent,
                              )),
                              Text(
                                secondText,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              ),
                              Expanded(
                                  child: Divider(
                                color: Colors.transparent,
                              )),
                              Text(
                                thirdText,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            /*Container(height: 0.4,color: Colors.grey,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        final Uri url = Uri(scheme: 'tel', path: callText);
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
                            border: Border.all(color: Colors.grey)),
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
                        print('$smsText $userName $image');
                        if (smsText.isNotEmpty ||
                            userName.isNotEmpty ||
                            image.isNotEmpty) {
                          push(
                              context: context,
                              screen: AdChatRoom(
                                id: smsText,
                                name: userName,
                                image: image,
                              ));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),

                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey)),
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
            ),*/
          ],
        ),
      ),
    );
  }
}
