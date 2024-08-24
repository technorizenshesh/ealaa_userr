import 'package:ealaa_userr/Model/advertisement_model/get_ads_with_category_subcategory_model.dart';
import 'package:ealaa_userr/advertisement/filters/phone_number_filter.dart';
import 'package:ealaa_userr/advertisement/filters/vehicle_for_sale_and_rent_filter.dart';
import 'package:ealaa_userr/advertisement/post_detail/AnimalsAndSuppliesDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/ElectronicsDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/PhoneNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/RealEstateDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehicleNumberDetailScreen.dart';
import 'package:ealaa_userr/advertisement/post_detail/VehiclePartsAndAccessoriesDetailScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Model/advertisement_model/VehiclePartsModel.dart';
import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'AddPost/Vehicles/VehiclesMake.dart';
import 'ad_chat_room.dart';
import 'filters/animals_filter.dart';
import 'filters/electronics_for_sale_and_rent_filter.dart';
import 'filters/realstate_for_sale_and_rent_filter.dart';
import 'filters/vehicle_number_filter.dart';
import 'filters/vehicle_parts_and_accessories_filter.dart';

List<PostListDetails> getAdsWithCategorySubCategoryResult = [];
List<PostListDetails> getAdsWithCategorySubCategoryResultGlobal = [];

class CategoryPostsScreen extends StatefulWidget {
  String adsSubCategoryId = '';
  String adsPost = '';
  String adsCategoryId = '';
  bool value = false;

  CategoryPostsScreen(
      {super.key,
      this.adsSubCategoryId = '',
      this.adsPost = '',
      this.adsCategoryId = '',
      this.value = false});

  @override
  State<CategoryPostsScreen> createState() => _CategoryPostsScreenState();
}

class _CategoryPostsScreenState extends State<CategoryPostsScreen> {
  List<PostListDetails> getAdsWithCategorySubCategoryResultTem = [];

  bool showProgressBar = true;

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_with_category_subcategory?ads_category_id=${widget.adsCategoryId}&ads_post=${widget.adsPost}&ads_sub_category_id=${widget.adsSubCategoryId}");
    showProgressBar = false;
    GetAdsWithCategorySubCategoryModel getAdsWithCategorySubCategoryModel =
        GetAdsWithCategorySubCategoryModel.fromJson(res);
    if (getAdsWithCategorySubCategoryModel.result != null &&
        getAdsWithCategorySubCategoryModel.result!.isNotEmpty) {
      getAdsWithCategorySubCategoryResultGlobal =
          getAdsWithCategorySubCategoryModel.result!;
      getAdsWithCategorySubCategoryResult =
          getAdsWithCategorySubCategoryModel.result!;
      setState(() {});
    } else {
      showSnackbar(context, 'Something went wrong!');
      showProgressBar = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    if (!widget.value) {
      getAdSubcategory();
    } else {
      showProgressBar = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        setState(() {});
        clearValues();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () {
              setState(() {});
              clearValues();
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
              onTap: () async {
                clearValues();
                if (widget.adsCategoryId == '1' ||
                    widget.adsCategoryId == '2') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleForSaleAndRentFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '3') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehiclePartsAndAccessoriesFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '4') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VehicleNumberFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '5' ||
                    widget.adsCategoryId == '6') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RealstateForSaleAndRentFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '7' ||
                    widget.adsCategoryId == '8') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectronicsForSaleAndRentFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '9') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneNumberFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }

                if (widget.adsCategoryId == '10') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AnimalsFilter(
                        advertisement_category_id: widget.adsCategoryId,
                      ),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange, width: .2)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.orange,
                        size: 18,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Filters',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            PopupMenuButton(
              position: PopupMenuPosition.under,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange, width: .2)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Shorted by',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.short_text,
                        color: Colors.orange,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
              itemBuilder: (ctx) => [
                PopupMenuItem(
                  child: const Text('Date (Newest)'),
                  onTap: () {
                    if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                      getAdsWithCategorySubCategoryResult.sort((a, b) {
                        return b.adsCreatedAt!.compareTo(a.adsCreatedAt!);
                      });
                      setState(() {});
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Date (Oldest)'),
                  onTap: () {
                    if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                      getAdsWithCategorySubCategoryResult.sort((a, b) {
                        return a.adsCreatedAt!.compareTo(b.adsCreatedAt!);
                      });
                      setState(() {});
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Price (Lowest)'),
                  onTap: () {
                    if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                      getAdsWithCategorySubCategoryResult.sort((a, b) {
                        return int.parse(a.vehicleAdsAdditionalDetailPrice!)
                            .compareTo(
                                int.parse(b.vehicleAdsAdditionalDetailPrice!));
                      });
                      setState(() {});
                    }
                  },
                ),
                PopupMenuItem(
                  child: const Text('Price (Highest)'),
                  onTap: () {
                    if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                      getAdsWithCategorySubCategoryResult.sort((a, b) {
                        return int.parse(b.vehicleAdsAdditionalDetailPrice!)
                            .compareTo(
                                int.parse(a.vehicleAdsAdditionalDetailPrice!));
                      });
                      setState(() {});
                    }
                  },
                ),

                ///TODO FOR Vehicle for sell rent
                if (widget.adsCategoryId == '1' || widget.adsCategoryId == '2')
                  PopupMenuItem(
                    child: const Text('Killometerage (Lowest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(a
                                  .vehicleAdsAdditionalDetailDistanceTravelled!)
                              .compareTo(int.parse(b
                                  .vehicleAdsAdditionalDetailDistanceTravelled!));
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '1' || widget.adsCategoryId == '2')
                  PopupMenuItem(
                    child: const Text('Killometerage (Highest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(b
                                  .vehicleAdsAdditionalDetailDistanceTravelled!)
                              .compareTo(int.parse(a
                                  .vehicleAdsAdditionalDetailDistanceTravelled!));
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '1' ||
                    widget.adsCategoryId == '2' ||
                    widget.adsCategoryId == '5' ||
                    widget.adsCategoryId == '6')
                  PopupMenuItem(
                    child: const Text('Year (Newest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(a.vehicleAdsDetailYear!)
                              .compareTo(int.parse(b.vehicleAdsDetailYear!));
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '1' ||
                    widget.adsCategoryId == '2' ||
                    widget.adsCategoryId == '5' ||
                    widget.adsCategoryId == '6')
                  PopupMenuItem(
                    child: const Text('Year (Oldest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(b.vehicleAdsDetailYear!)
                              .compareTo(int.parse(a.vehicleAdsDetailYear!));
                        });
                        setState(() {});
                      }
                    },
                  ),

                ///TODO FOR Real state
                if (widget.adsCategoryId == '5' || widget.adsCategoryId == '6')
                  PopupMenuItem(
                    child: const Text('Land Area (Smallest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(
                                  a.realStateAdsAdditionalDetailLandArea!)
                              .compareTo(int.parse(
                                  b.realStateAdsAdditionalDetailLandArea!));
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '5' || widget.adsCategoryId == '6')
                  PopupMenuItem(
                    child: const Text('Land Area (Highest)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(
                                  b.realStateAdsAdditionalDetailLandArea!)
                              .compareTo(int.parse(
                                  a.realStateAdsAdditionalDetailLandArea!));
                        });
                        setState(() {});
                      }
                    },
                  ),

                ///TODO FOR Vehicle Number
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('Number (Ascending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return a.uploadVehiclesNumbers!
                              .compareTo(b.uploadVehiclesNumbers!);
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('Number (Descending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return int.parse(b.uploadVehiclesNumbers!)
                              .compareTo(int.parse(a.uploadVehiclesNumbers!));
                        });
                        setState(() {});
                      }
                    },
                  ),
                /*
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('Arabic Letter (Ascending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return a.letterNameEnglish!
                              .compareTo(b.letterNameEnglish!);
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('Arabic Letter (Descending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return b.letterNameEnglish!
                              .compareTo(a.letterNameEnglish!);
                        });
                        setState(() {});
                      }
                    },
                  ),*/
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('English Letter (Ascending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return b.letterNameEnglish!
                              .compareTo(a.letterNameEnglish!);
                        });
                        setState(() {});
                      }
                    },
                  ),
                if (widget.adsCategoryId == '4')
                  PopupMenuItem(
                    child: const Text('English Letter (Descending)'),
                    onTap: () {
                      if (getAdsWithCategorySubCategoryResult.isNotEmpty) {
                        getAdsWithCategorySubCategoryResult.sort((a, b) {
                          return a.letterNameEnglish!
                              .compareTo(b.letterNameEnglish!);
                        });
                        setState(() {});
                      }
                    },
                  ),
              ],
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: showProgressBar
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : getAdsWithCategorySubCategoryResult.isEmpty
                  ? Image.asset("assets/images/NoDataFound.png")
                  : Column(
                      children: [
                        if (widget.adsCategoryId == '3')
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FindForSpecificVehicle()));
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 10),
                              width: width,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                      color: Colors.orange, width: .5)),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons_for_car/CarIcon.svg',
                                      height: 30,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Find for Specific Vehicle',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: ListView.builder(
                            itemCount:
                                getAdsWithCategorySubCategoryResult.length,
                            //reverse: true,
                            itemBuilder: (context, index) {
                              return listOfData(index: index);
                            },
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget listOfData({required int index}) {
    if (widget.adsCategoryId.isNotEmpty) {
      if (widget.adsCategoryId == '1' || widget.adsCategoryId == '2') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehicleDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
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
      } else if (widget.adsCategoryId == '3') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehiclePartsAndAccessoriesDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
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
                'NA',
            price:
                getAdsWithCategorySubCategoryResult[index].vehiclePartPrice ??
                    'NA',
            firstText:
                getAdsWithCategorySubCategoryResult[index].partName ?? 'NA',
            secondText:
                getAdsWithCategorySubCategoryResult[index].cityName ?? '',
            thirdText:
                getAdsWithCategorySubCategoryResult[index].modelTrimName ??
                    'NA',
            callText: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.mobile ??
                'NA',
            smsText:
                getAdsWithCategorySubCategoryResult[index].usersDetails?.id ??
                    '',
            image: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.image ??
                'NA',
            userName: getAdsWithCategorySubCategoryResult[index]
                    .usersDetails
                    ?.userName ??
                'NA',
            secondIcon: 'assets/icons_for_car/ic_location.png',
            firstIcon: 'assets/icons_for_car/ic_engine_size.png',
            thirdIcon: 'assets/icons_for_car/ic_transmission.png',
          ),
        );
      } else if (widget.adsCategoryId == '4') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return VehicleNumberDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl:
                getAdsWithCategorySubCategoryResult[index].vehicleNumberImage ??
                    '',
            imageUrlValue: TextEditingController(
                text: getAdsWithCategorySubCategoryResult[index]
                        .vehicleNumberImage ??
                    ''),
            vehicleNumber: TextEditingController(
                text: getAdsWithCategorySubCategoryResult[index]
                        .uploadVehiclesNumbers ??
                    ''),
            vehicleNumber1: TextEditingController(
                text: getAdsWithCategorySubCategoryResult[index]
                        .letterNameEnglish ??
                    ''),
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
      } else if (widget.adsCategoryId == '5' || widget.adsCategoryId == '6') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return RealEstateDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
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
      } else if (widget.adsCategoryId == '7' || widget.adsCategoryId == '8') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ElectronicsDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
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
      } else if (widget.adsCategoryId == '9') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return PhoneNumberDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
                );
              },
            ));
          },
          child: dataContainer(
            imageUrl: getAdsWithCategorySubCategoryResult[index]
                    .phoneNumberAdsImage ??
                '',
            imageUrlValue: TextEditingController(
                text: getAdsWithCategorySubCategoryResult[index]
                        .phoneNumberAdsPhone ??
                    ''),
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
      } else if (widget.adsCategoryId == '10') {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return AnimalsAndSuppliesDetailScreen(
                  ads_post:
                      getAdsWithCategorySubCategoryResult[index].adsType ?? '',
                  ads_post_id:
                      getAdsWithCategorySubCategoryResult[index].adsId ?? '',
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
    return const SizedBox();
  }

  Widget dataContainer(
      {required String imageUrl,
      TextEditingController? imageUrlValue,
      TextEditingController? vehicleNumber,
      TextEditingController? vehicleNumber1,
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
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            border: Border.all(color: Colors.grey.shade100),
            color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * .2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade100),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: imageUrlValue != null &&
                        imageUrlValue.text.trim().isNotEmpty
                    ? ((vehicleNumber != null &&
                                vehicleNumber.text.isNotEmpty) ||
                            (vehicleNumber1 != null &&
                                vehicleNumber1.text.isNotEmpty))
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 36),
                                child: Container(
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffff9900),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: textFieldView(
                                              controller: vehicleNumber!,
                                              borderRadius: const BorderRadius
                                                  .only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10)))),
                                      Expanded(
                                          child: textFieldView(
                                              controller: vehicleNumber1!,
                                              borderRadius: BorderRadius.zero)),
                                      Expanded(
                                        child: textFieldView(
                                          controller: TextEditingController(
                                              text: 'عُمان'),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 45),
                                child: Image.asset(
                                  'assets/images/ic_number_plate_image_one.png',
                                  height: 40,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 36),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  readOnly: true,
                                  maxLines: 1,
                                  maxLength: 8,
                                  autofocus: true,
                                  controller: imageUrlValue,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 8),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    counterText: '',
                                    fillColor: const Color(0xff067445),
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff067445))),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff067445))),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff067445))),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xff067445))),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 45),
                                child: Image.asset(
                                  'assets/images/ic_number_plate_image_one.png',
                                  height: 40,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          )
                    : CachedNetworkImage(
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
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${price} OMR",
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () {
                          try {
                            Uri uri = Uri.parse('https://11way.solutions');
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: Colors.black.withOpacity(0.5),
                                size: 18,
                              ),
                              const SizedBox(
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
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      children: [
                        Image.asset(
                          firstIcon,
                          color: Colors.black.withOpacity(0.4),
                          height: 14,
                          width: 14,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(),
                          ),
                        ),
                        Image.asset(
                          secondIcon,
                          color: Colors.black.withOpacity(0.4),
                          height: 14,
                          width: 14,
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Divider(),
                          ),
                        ),
                        Image.asset(
                          thirdIcon,
                          color: Colors.black.withOpacity(0.4),
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            firstText,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            secondText,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            thirdText,
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade100,
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                            border:
                                Border.all(color: Colors.orange, width: .2)),
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
                  const SizedBox(width: 10),
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
                            border:
                                Border.all(color: Colors.orange, width: .2)),
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
          ],
        ),
      ),
    );
  }

  Widget textFieldView(
      {required TextEditingController controller,
      BorderRadius? borderRadius,
      bool? readOnly,
      bool? autofocus,
      int? maxLength}) {
    return TextField(
      readOnly: readOnly ?? true,
      textAlign: TextAlign.center,
      cursorWidth: 0,
      autofocus: autofocus ?? false,
      cursorHeight: 0,
      cursorOpacityAnimates: false,
      maxLines: 1,
      maxLength: maxLength ?? 8,
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        counterText: '',
        fillColor: const Color(0xffffd500),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff000000), width: .4)),
        disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff000000), width: .4)),
        enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff000000), width: .4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff000000), width: .4)),
      ),
    );
  }
}

class FindForSpecificVehicle extends StatefulWidget {

  const FindForSpecificVehicle(
      {super.key,});

  @override
  State<FindForSpecificVehicle> createState() => _FindForSpecificVehicleState();
}

class _FindForSpecificVehicleState extends State<FindForSpecificVehicle> {
  List<String> topList = [
    'Part',
    'Makes',
    'Vehicle Models',
    'Model Years',
    'Model Trim',
    'Engine Size',
  ];
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  String title = "Part";
  int selectedIndex = -1;
  VehiclePartsResult? vehiclePartsResult;
  List<Part> partsList = [];
  List<SubPartName> subPartList = [];
  List<Maker> makerList = [];
  List<Model> modelList = [];
  List<ModelYear> yearList = [];
  List<ModelTrim> trimList = [];
  List<EngineSize> enginesizeList = [];

  Part? selectedPart;
  SubPartName? selectedSubpart;
  Maker? selectedMaker;
  Model? selectedModel;
  ModelYear? selectedModelyear;
  ModelTrim? selectedModeltrim;
  EngineSize? selectedEnginesize;

  String? selectedImage;

  bool loader = false;
  TextEditingController price = TextEditingController();
  TextEditingController landArea = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController englishTitle = TextEditingController();
  TextEditingController arabicTitle = TextEditingController();
  TextEditingController vehiclePartPartNumber = TextEditingController();

  void _scrollToNextStep() {
    if (_currentStepIndex < topList.length) {
      double offset =
          _currentStepIndex * 100; // Assuming each step's height is 100.0
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  getListData() async {
    var res = await Webservices.getMap(/*widget.type == "Wanted"
        ? "$get_vehicles_parts_accessories_wanted"
        :*/ "$get_vehicles_parts_accessories_for_sell");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehiclePartsModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      vehiclePartsResult = resdata.result!;
      partsList = vehiclePartsResult!.part ?? [];
      makerList = vehiclePartsResult!.maker ?? [];
      enginesizeList = vehiclePartsResult!.engineSize ?? [];

      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  String _getTitleForIndex(int index) {
    if (index == 1 || index < topList.length) {
      return topList[index];
    } else {
      return ""; // Handle out of bounds index gracefully
    }
  }

  @override
  void initState() {
    getListData();
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
            if (_currentStepIndex > 1) {
              _currentStepIndex--;
              title = _getTitleForIndex(_currentStepIndex - 1);
              ;
              setState(() {});
              _scrollToNextStep();
            } else {
              Navigator.pop(context);
            }
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          title, // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: showProgressBar
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            )
          : vehiclePartsResult == null
              ? Image.asset("assets/images/NoDataFound.png")
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xfff8f2ee),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14),
                            topRight: Radius.circular(14),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height - 200,
                        child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: tabsScreens(_currentStepIndex),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget tabsScreens(int index) {
    switch (index) {
      case 1:
        return PartView();
      case 2:
        return MakesView();
      case 3:
        return ModelsView();
      case 4:
        return YearsView();
      case 5:
        return TrimView();
      case 6:
        return SizeView();
      default:
        return PartView();
    }
  }

  Widget PartView() {
    return ListView.builder(
        itemCount: partsList.length,
        itemBuilder: (context, index) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    subPartList = partsList[index].subPartName ?? [];
                    setState(() {});
                    if (selectedIndex != index) {
                      selectedIndex = index;
                      setState(() {});
                    } else {
                      selectedIndex = -1;
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      leading: Icon(
                        selectedIndex == index
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: MyColors.primaryColor,
                        size: 30,
                      ),
                      title: Text('${partsList[index].partName}'),
                      trailing: SvgPicture.asset(
                        "assets/images/EngineIcon.svg",
                        height: 30,
                      ),
                    ),
                  ),
                ),
                if (selectedIndex == index)
                  SizedBox(height: 10),
                if (selectedIndex == index)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: subPartList.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: selectedSubpart == subPartList[i]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: ListTile(
                          leading: SquareRadio(
                            activeColor: MyColors.primaryColor,
                            value: subPartList[i],
                            groupValue: selectedSubpart,
                            onChanged: (value) {
                              _currentStepIndex = 2;
                              selectedSubpart = subPartList[i];
                              title = _getTitleForIndex(_currentStepIndex - 1);
                              _scrollToNextStep();
                              setState(() {});
                            },
                          ),
                          title: Text('${subPartList[i].subPartName}'),
                          onTap: () {
                            _currentStepIndex = 2;
                            selectedSubpart = subPartList[i];
                            title = _getTitleForIndex(_currentStepIndex - 1);
                            _scrollToNextStep();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  )
              ],
            ));
  }

  Widget MakesView() {
    return ListView.builder(
      itemCount: makerList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedMaker == makerList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: makerList[index],
              groupValue: selectedMaker,
              onChanged: (value) {
                _currentStepIndex = 3;
                selectedMaker = makerList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                modelList = selectedMaker?.model ?? [];
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${makerList[index].name}'),
            onTap: () {
              _currentStepIndex = 3;
              selectedMaker = makerList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              modelList = selectedMaker?.model ?? [];
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget ModelsView() {
    return ListView.builder(
      itemCount: modelList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedModel == modelList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: modelList[index],
              groupValue: selectedModel,
              onChanged: (value) {
                _currentStepIndex = 4;
                selectedModel = modelList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                yearList = selectedModel?.modelYear ?? [];
                trimList = selectedModel?.modelTrim ?? [];
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${modelList[index].name}'),
            onTap: () {
              _currentStepIndex = 4;
              selectedModel = modelList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              yearList = selectedModel?.modelYear ?? [];
              trimList = selectedModel?.modelTrim ?? [];
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget YearsView() {
    return ListView.builder(
      itemCount: yearList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedModelyear == yearList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: yearList[index],
              groupValue: selectedModelyear,
              onChanged: (value) {
                _currentStepIndex = 5;
                selectedModelyear = yearList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${yearList[index].yearName}'),
            onTap: () {
              _currentStepIndex = 5;
              selectedModelyear = yearList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget TrimView() {
    return ListView.builder(
      itemCount: trimList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedModeltrim == trimList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: trimList[index],
              groupValue: selectedModeltrim,
              onChanged: (value) {
                _currentStepIndex = 6;
                selectedModeltrim = trimList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${trimList[index].name}'),
            onTap: () {
              _currentStepIndex = 6;
              selectedModeltrim = trimList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget SizeView() {
    return ListView.builder(
      itemCount: enginesizeList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedEnginesize == enginesizeList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: enginesizeList[index],
              groupValue: selectedEnginesize,
              onChanged: (value) {
                //_currentStepIndex = 7;
                selectedEnginesize = enginesizeList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                filterValue();
                //_scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${enginesizeList[index].engineValue}'),
            onTap: () {
              //_currentStepIndex = 7;
              selectedEnginesize = enginesizeList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              filterValue();
              //_scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }


  filterValue(){
    if (selectedPart == null &&
        selectedSubpart == null &&
        selectedMaker == null &&
        selectedModel == null &&
        selectedModelyear == null &&
        selectedModeltrim == null &&
        selectedEnginesize == null &&
        currentPointValue == 0.0) {
      getAdsWithCategorySubCategoryResult =
          getAdsWithCategorySubCategoryResultGlobal;
      setState(() {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPostsScreen(
              value: true,
              adsCategoryId: "3",
              adsSubCategoryId: selectedCategories.toString()),
        ),
      );
    } else {
      List<PostListDetails> filteredAds = [];
      getAdsWithCategorySubCategoryResultGlobal
          .forEach((element) {
        if ((selectedCategories != null &&
            selectedCategories!.isNotEmpty &&
            selectedCategories == element.adsSubCategoryId)) {
          filteredAds.add(element);
          setState(() {});
        }

        if (selectedPart !=
            null &&
            selectedPart!
                .partName!.isNotEmpty &&
            selectedPart!
                .partName!.isNotEmpty &&
            selectedPart!
                .partName ==
                element.partName) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedPart != null &&
              selectedPart!
                  .partName !=
                  null &&
              selectedPart!
                  .partName!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }

        if (selectedSubpart !=
            null &&
            selectedSubpart!
                .subPartName!.isNotEmpty &&
            selectedSubpart!
                .subPartName!.isNotEmpty &&
            selectedSubpart!
                .subPartName ==
                element.subPartName) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedSubpart != null &&
              selectedSubpart!
                  .subPartName !=
                  null &&
              selectedSubpart!
                  .subPartName!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }

        if (selectedMaker !=
            null &&
            selectedMaker!
                .id!.isNotEmpty &&
            selectedMaker!
                .id!.isNotEmpty &&
            selectedMaker!
                .id ==
                element.vehiclePartMakerId) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedMaker != null &&
              selectedMaker!
                  .id !=
                  null &&
              selectedMaker!
                  .id!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }

        if (selectedModel !=
            null &&
            selectedModel!
                .id!.isNotEmpty &&
            selectedModel!
                .id!.isNotEmpty &&
            selectedModel!
                .id ==
                element.vehiclePartPartId) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedModel != null &&
              selectedModel!
                  .id !=
                  null &&
              selectedModel!
                  .id!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }

        if (selectedModeltrim !=
            null &&
            selectedModeltrim!
                .id!.isNotEmpty &&
            selectedModeltrim!
                .id!.isNotEmpty &&
            selectedModeltrim!
                .id ==
                element.vehiclePartModelTrimId) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedModeltrim != null &&
              selectedModeltrim!
                  .id !=
                  null &&
              selectedModeltrim!
                  .id!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }


        if (selectedModelyear !=
            null &&
            selectedModelyear!
                .yearName!.isNotEmpty &&
            selectedModelyear!
                .yearName!.isNotEmpty &&
            selectedModelyear!
                .yearName ==
                element.yearName) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedModelyear != null &&
              selectedModelyear!
                  .yearName !=
                  null &&
              selectedModelyear!
                  .yearName!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }

        if (selectedEnginesize !=
            null &&
            selectedEnginesize!
                .engineValue!.isNotEmpty &&
            selectedEnginesize!
                .engineValue!.isNotEmpty &&
            selectedEnginesize!
                .engineValue ==
                element.engineValue) {
          if (!filteredAds.contains(element)) {
            filteredAds.add(element);
          }
        } else {
          if (selectedEnginesize != null &&
              selectedEnginesize!
                  .engineValue !=
                  null &&
              selectedEnginesize!
                  .engineValue!.isNotEmpty) {
            filteredAds.remove(element);
            setState(() {});
          }
        }
      });
      setState(() {
        getAdsWithCategorySubCategoryResult = filteredAds;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryPostsScreen(
              value: true,
              adsCategoryId: '3',
              adsSubCategoryId: selectedCategories.toString()),
        ),
      );
    }
  }

  String _getSelectedValueForIndex(int index) {
    switch (index) {
      case 0:
        return selectedSubpart?.subPartName ?? "";
      case 1:
        return selectedMaker?.name ?? "";
      case 2:
        return selectedModel?.name ?? "";
      case 3:
        return selectedModelyear?.yearName ?? "";
      case 4:
        return selectedModeltrim?.name ?? "";
      case 5:
        return selectedEnginesize?.engineValue ?? "";
      default:
        return "";
    }
  }
}
