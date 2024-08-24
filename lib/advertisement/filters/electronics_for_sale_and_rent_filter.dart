import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_electronics_brand_filter_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_electronics_condition_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_governate_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_states_filter_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';
import 'animals_filter.dart';

class ElectronicsForSaleAndRentFilter extends StatefulWidget {
  final String advertisement_category_id;

  const ElectronicsForSaleAndRentFilter(
      {super.key, required this.advertisement_category_id});

  @override
  State<ElectronicsForSaleAndRentFilter> createState() =>
      _ElectronicsForSaleAndRentFilterState();
}

class _ElectronicsForSaleAndRentFilterState
    extends State<ElectronicsForSaleAndRentFilter> {
  bool showProgressBar = true;
  List<String> topList = [
    'Brand',
    'Condition',
    'Governorate',
    'State',
    'Price',
  ];

  List<SubcategoryResult> subcategoryList = [];
  List<GetElectronicsConditionFilterResult> getElectronicsConditionFilterResult = [];
  List<GetElectronicsBrandFilterResult> getElectronicsBrandFilterResult = [];
  List<GetGovernorateFilterResult> governateList = [];
  List<GetStatesFilterResult> stateList = [];

  bool loader = false;

  int _currentStepIndex = 0;

  getListData() async {
    var res = await Webservices.getMap(get_electronics_brand_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetElectronicsBrandFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getElectronicsBrandFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getElectronicsConditionFilter() async {
    var res = await Webservices.getMap(get_electronics_condition_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetElectronicsConditionFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getElectronicsConditionFilterResult = resdata.result!;
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
    getListData();
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
                    clearValues();

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
                        selectedGovernateForElectronicsForSaleAndRentFilter ==
                            null &&
                        selectedStateForElectronicsForSaleAndRentFilter ==
                            null &&
                        currentPointValue == 0.0) {
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

                        if (selectedBrandForElectronicsForSaleAndRentFilter != null &&
                            selectedBrandForElectronicsForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedBrandForElectronicsForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedBrandForElectronicsForSaleAndRentFilter!
                                    .name ==
                                element.electronicsAdsBrandModelName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedBrandForElectronicsForSaleAndRentFilter != null &&
                              selectedBrandForElectronicsForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedBrandForElectronicsForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGovernateForElectronicsForSaleAndRentFilter != null &&
                            selectedGovernateForElectronicsForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedGovernateForElectronicsForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedGovernateForElectronicsForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailGovernate) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGovernateForElectronicsForSaleAndRentFilter != null &&
                              selectedGovernateForElectronicsForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedGovernateForElectronicsForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedStateForElectronicsForSaleAndRentFilter !=
                                null &&
                            selectedStateForElectronicsForSaleAndRentFilter!
                                    .stateName !=
                                null &&
                            selectedStateForElectronicsForSaleAndRentFilter!
                                .stateName!.isNotEmpty &&
                            selectedStateForElectronicsForSaleAndRentFilter!
                                    .stateName ==
                                element.vehicleAdsDetailState) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedStateForElectronicsForSaleAndRentFilter != null &&
                              selectedStateForElectronicsForSaleAndRentFilter!
                                      .stateName !=
                                  null &&
                              selectedStateForElectronicsForSaleAndRentFilter!
                                  .stateName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedConditionForElectronicsForSaleAndRentFilter !=
                                null &&
                            selectedConditionForElectronicsForSaleAndRentFilter!
                                    .conditionName !=
                                null &&
                            selectedConditionForElectronicsForSaleAndRentFilter!
                                .conditionName!.isNotEmpty &&
                            selectedConditionForElectronicsForSaleAndRentFilter!
                                    .conditionName ==
                                element.conditionName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedConditionForElectronicsForSaleAndRentFilter != null &&
                              selectedConditionForElectronicsForSaleAndRentFilter!
                                      .conditionName !=
                                  null &&
                              selectedConditionForElectronicsForSaleAndRentFilter!
                                  .conditionName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentPointValue >=
                            double.parse(element.electronicsAdsPrice ?? '0')) {
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
                                      getElectronicsConditionFilter();
                                    } else if (_currentStepIndex == 2) {
                                      getGovernorateFilter();
                                    } else if (_currentStepIndex == 3) {
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
        return BrandView();
      case 1:
        return ConditionView();
      case 2:
        return Governate();
      case 3:
        return State();
      default:
        return PriceView();
    }
  }

  Widget BrandView() {
    return ListView.builder(
      itemCount: getElectronicsBrandFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedCategories == getElectronicsBrandFilterResult[index].brandId
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getElectronicsBrandFilterResult[index].brandId,
              groupValue: selectedCategories,
              onChanged: (value) {
                selectedCategories = getElectronicsBrandFilterResult[index].brandId;
                setState(() {});
              },
            ),
            title: Text('${getElectronicsBrandFilterResult[index].name}'),
            onTap: () {
              selectedCategories = getElectronicsBrandFilterResult[index].brandId;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget ConditionView() {
    return ListView.builder(
      itemCount: getElectronicsConditionFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedConditionForElectronicsForSaleAndRentFilter == getElectronicsConditionFilterResult[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getElectronicsConditionFilterResult[index],
              groupValue: selectedConditionForElectronicsForSaleAndRentFilter,
              onChanged: (value) {
                selectedConditionForElectronicsForSaleAndRentFilter = getElectronicsConditionFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getElectronicsConditionFilterResult[index].conditionName}'),
            onTap: () {
              selectedConditionForElectronicsForSaleAndRentFilter = getElectronicsConditionFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
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
                              selectedGovernateForElectronicsForSaleAndRentFilter ==
                                      governateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index],
                      groupValue:
                          selectedGovernateForElectronicsForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGovernateForElectronicsForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedGovernateForElectronicsForSaleAndRentFilter =
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
                              selectedStateForElectronicsForSaleAndRentFilter ==
                                      stateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index],
                      groupValue:
                          selectedStateForElectronicsForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedStateForElectronicsForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        selectedStateForElectronicsForSaleAndRentFilter =
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
}
