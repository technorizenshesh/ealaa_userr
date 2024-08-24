import 'package:ealaa_userr/Model/advertisement_model/advertisement_models_for_realstate_for_sale_and_rent/gat_land_type_filter_model.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_realstate_for_sale_and_rent/get_use_types_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_governate_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_states_filter_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/webService.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';
import 'animals_filter.dart';

class RealstateForSaleAndRentFilter extends StatefulWidget {
  final String advertisement_category_id;

  const RealstateForSaleAndRentFilter(
      {super.key, required this.advertisement_category_id});

  @override
  State<RealstateForSaleAndRentFilter> createState() =>
      _RealstateForSaleAndRentFilterState();
}

class _RealstateForSaleAndRentFilterState
    extends State<RealstateForSaleAndRentFilter> {
  bool showProgressBar = true;
  List<String> topList = [
    'Property Type',
    'Use',
    'Land Type',
    'Governorate',
    'State',
    'Price',
    'Building Area',
    'Land Area',
  ];

  List<SubcategoryResult> subcategoryList = [];
  List<GetUseTypesFilterResult> useList = [];
  List<GetLandTypesFilterResult> landTypeList = [];
  List<GetGovernorateFilterResult> governateList = [];
  List<GetStatesFilterResult> stateList = [];

  bool loader = false;

  int _currentStepIndex = 0;

  getUseFilter() async {
    var res = await Webservices.getMap(get_use_types_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetUseTypesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      useList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getLandTypeFilter() async {
    var res = await Webservices.getMap(get_land_types_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetLandTypesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      landTypeList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getGovernorateFilter() async {
    var res = await Webservices.getMap(get_governate_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetGovernorateFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      governateList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getStatesFilter() async {
    var res = await Webservices.getMap(get_states_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetStatesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      stateList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_sub_category?category_id=${widget.advertisement_category_id}");
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetSubcategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      subcategoryList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    getAdSubcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const Text(
          'Filters', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryPostsScreen(
                      value: true,
                      adsCategoryId: widget.advertisement_category_id,
                      adsSubCategoryId: selectedCategories.toString()),
                ),
              );
            },
            child: const Icon(
              Icons.cancel_outlined,
              size: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10)
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    selectedCategories = null;
                    setState(() {});
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey)),
                    child: const Center(
                      child: Text(
                        'Clear Filter',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    if (selectedCategories == null &&
                        selectedUseListForRealEstatesForSaleAndRentFilter ==
                            null &&
                        selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter ==
                            null &&
                        selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter ==
                            null &&
                        selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter ==
                            null &&
                        currentPointValue == 0.0 &&
                        currentBuildingArea == 0.0 &&
                        currentLandArea == 0.0) {
                      getAdsWithCategorySubCategoryResult =
                          getAdsWithCategorySubCategoryResultGlobal;
                      setState(() {});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPostsScreen(
                              value: true,
                              adsCategoryId: widget.advertisement_category_id,
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

                        if (selectedUseListForRealEstatesForSaleAndRentFilter != null &&
                            selectedUseListForRealEstatesForSaleAndRentFilter!
                                    .useId !=
                                null &&
                            selectedUseListForRealEstatesForSaleAndRentFilter!
                                .useId!.isNotEmpty &&
                            selectedUseListForRealEstatesForSaleAndRentFilter!
                                    .useId ==
                                element.realStateAdsDetailUseId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedUseListForRealEstatesForSaleAndRentFilter != null &&
                              selectedUseListForRealEstatesForSaleAndRentFilter!
                                      .useId !=
                                  null &&
                              selectedUseListForRealEstatesForSaleAndRentFilter!
                                  .useId!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter != null &&
                            selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter!.landtypeId !=
                                null &&
                            selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter!
                                .landtypeId!.isNotEmpty &&
                            selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter!
                                    .landtypeId ==
                                element.realStateAdsDetailLandtypeId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter != null &&
                              selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter!
                                      .landtypeId !=
                                  null &&
                              selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter!
                                  .landtypeId!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter != null &&
                            selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter!
                                    .id !=
                                null &&
                            selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter!
                                .id!.isNotEmpty &&
                            selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter!
                                    .id ==
                                element.realStateAdsDetailGovernateId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter != null &&
                              selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter!
                                      .id !=
                                  null &&
                              selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter != null &&
                            selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter!
                                    .stateId !=
                                null &&
                            selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter!
                                .stateId!.isNotEmpty &&
                            selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter!
                                    .stateId ==
                                element.realStateAdsDetailStateId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter != null &&
                              selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter!
                                      .stateId !=
                                  null &&
                              selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter!
                                  .stateId!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentBuildingArea >=
                            double.parse(
                                element.realStateAdsAdditionalDetailLandArea ??
                                    '0')) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (currentBuildingArea != 0.0) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }
                        if (currentLandArea >=
                            double.parse(
                                element.realStateAdsAdditionalDetailLandArea ??
                                    '0')) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (currentLandArea != 0.0) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentPointValue >=
                            double.parse(
                                element.realStateAdsAdditionalDetailPrice ??
                                    '0')) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (currentPointValue != 0.0) {
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
                              adsCategoryId: widget.advertisement_category_id,
                              adsSubCategoryId: selectedCategories.toString()),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey)),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Ads',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
      body: showProgressBar
          ? const Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            )
          : subcategoryList == null
              ? Image.asset("assets/images/NoDataFound.png")
              : Container(
                  color: const Color(0xfff8f2ee),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(topList.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    _currentStepIndex = index;
                                    if (_currentStepIndex == 1) {
                                      getUseFilter();
                                    } else if (_currentStepIndex == 2) {
                                      getLandTypeFilter();
                                    } else if (_currentStepIndex == 3) {
                                      getGovernorateFilter();
                                    } else if (_currentStepIndex == 4) {
                                      getStatesFilter();
                                    }
                                    setState(() {});
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: _currentStepIndex == index
                                                ? const Color(0xfff8f2ee)
                                                : null),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                            vertical: 20,
                                          ),
                                          child: Text(
                                            topList[index],
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    _currentStepIndex != index
                                                        ? Colors.grey
                                                        : Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      const Divider(height: 0),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xfff8f2ee),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: tabsScreens(_currentStepIndex),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget tabsScreens(int index) {
    switch (index) {
      case 0:
        return CategoriesView();
      case 1:
        return Use();
      case 2:
        return LandType();
      case 3:
        return Governate();
      case 4:
        return State();
      case 5:
        return PriceView();
      case 6:
        return BuildingAreaView();
      case 7:
        return LandAreaView();
      default:
        return PriceView();
    }
  }

  Widget CategoriesView() {
    return GridView.builder(
      //physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: subcategoryList.length,
      itemBuilder: (context, int index) {
        //  GetClubsResult item = controller.getClubsModel!.result![index];
        return GestureDetector(
          onTap: () {
            selectedCategories = subcategoryList[index].id;
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.whiteColor,
                      border: Border.all(
                        width: .4,
                        color: selectedCategories == subcategoryList[index].id
                            ? Colors.orange
                            : AppColors.whiteColor,
                      ),
                    ),
                    height: 50,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: subcategoryList[index].image ?? '',
                          height: 30,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                            baseColor: MyColors.onSecondary.withOpacity(0.4),
                            highlightColor:
                                Theme.of(context).colorScheme.onSecondary,
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.onSecondary.withOpacity(0.4),
                              ),
                            ),
                          )),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subcategoryList[index].subCategoryName ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: selectedCategories == subcategoryList[index].id
                            ? Colors.orange
                            : Colors.black),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              if (selectedCategories == subcategoryList[index].id)
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 14,
                      ))),
                )
            ],
          ),
        );
      },
    );

    return ListView.builder(
      itemCount: subcategoryList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedCategories == subcategoryList[index].id
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: subcategoryList[index].id,
              groupValue: selectedCategories,
              onChanged: (value) {
                selectedCategories = subcategoryList[index].id;
                setState(() {});
              },
            ),
            title: Text('${subcategoryList[index].subCategoryName}'),
            onTap: () {
              selectedCategories = subcategoryList[index].id;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget Use() {
    return ListView.builder(
        itemCount: useList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedUseListForRealEstatesForSaleAndRentFilter ==
                                      useList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: useList[index],
                      groupValue:
                          selectedUseListForRealEstatesForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedUseListForRealEstatesForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${useList[index].useName}'),
                    onTap: () {
                      setState(() {
                        selectedUseListForRealEstatesForSaleAndRentFilter =
                            useList[index];
                      });
                    },
                  )),
            ));
  }

  Widget LandType() {
    return ListView.builder(
        itemCount: landTypeList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter ==
                                      landTypeList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: landTypeList[index],
                      groupValue:
                          selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${landTypeList[index].landtypeName}'),
                    onTap: () {
                      setState(() {
                        selectedGetLandTypesFilterResultForRealEstatesForSaleAndRentFilter =
                            landTypeList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Governate() {
    return ListView.builder(
        itemCount: governateList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter ==
                                      governateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index],
                      groupValue:
                          selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedGetGovernorateFilterResultForRealEstatesForSaleAndRentFilter =
                            governateList[index];
                      });
                    },
                  )),
            ));
  }

  Widget State() {
    return ListView.builder(
        itemCount: stateList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter ==
                                      stateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index],
                      groupValue:
                          selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        selectedGetStatesFilterResultForRealEstatesForSaleAndRentFilter =
                            stateList[index];
                      });
                    },
                  )),
            ));
  }

  Widget PriceView() {
    return Column(
      children: [
        const Text('500000 Max(OMR)'),
        const SizedBox(height: 10),
        Container(
          height: 300, // Adjust the height as needed
          child: RotatedBox(
            quarterTurns: 3, // Rotate the slider to make it vertical
            child: Slider(
              value: currentPointValue,
              activeColor: Colors.orange,
              max: 500000,
              min: 0,
              label: currentPointValue.toStringAsFixed(2).toString(),
              divisions: 500000,
              allowedInteraction: SliderInteraction.tapAndSlide,
              onChanged: (double value) {
                setState(() {
                  currentPointValue = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text('0.0 Min(OMR)'),
      ],
    );
  }

  Widget BuildingAreaView() {
    return Column(
      children: [
        const Text('10000 Max(SQM)'),
        const SizedBox(height: 10),
        Container(
          height: 300, // Adjust the height as needed
          child: RotatedBox(
            quarterTurns: 3, // Rotate the slider to make it vertical
            child: Slider(
              value: currentBuildingArea,
              activeColor: Colors.orange,
              max: 10000,
              min: 0,
              label: currentBuildingArea.toStringAsFixed(2).toString(),
              divisions: 10000,
              allowedInteraction: SliderInteraction.tapAndSlide,
              onChanged: (double value) {
                setState(() {
                  currentBuildingArea = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text('0.0 Min(SQM)'),
      ],
    );
  }

  Widget LandAreaView() {
    return Column(
      children: [
        const Text('10000 Max(SQM)'),
        const SizedBox(height: 10),
        Container(
          height: 300, // Adjust the height as needed
          child: RotatedBox(
            quarterTurns: 3, // Rotate the slider to make it vertical
            child: Slider(
              value: currentLandArea,
              activeColor: Colors.orange,
              max: 10000,
              min: 0,
              label: currentLandArea.toStringAsFixed(2).toString(),
              divisions: 10000,
              allowedInteraction: SliderInteraction.tapAndSlide,
              onChanged: (double value) {
                setState(() {
                  currentLandArea = value;
                });
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text('0.0 Min(SQM)'),
      ],
    );
  }
}
