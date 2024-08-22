import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/VehiclesMakeModel.dart';
import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_condition_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_door_count_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_engine_size_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_year_filter_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_model_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_model_trim_filter_model.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';
import 'animals_filter.dart';

class VehicleForSaleAndRentFilter extends StatefulWidget {
  final String advertisement_category_id;

  const VehicleForSaleAndRentFilter(
      {super.key, required this.advertisement_category_id});

  @override
  State<VehicleForSaleAndRentFilter> createState() =>
      _VehicleForSaleAndRentFilterState();
}

class _VehicleForSaleAndRentFilterState
    extends State<VehicleForSaleAndRentFilter> {
  bool showProgressBar = true;
  List<String> topList = [
    'Body',
    'Make',
    'Modal',
    'Trim',
    'Year',
    'Condition',
    'Engine Size',
    'Door count',
    'Exterior Color',
    'Interior Color',
    'Cylinders',
    'Fuel',
    'Transmission',
    'Drivetrain',
    'Seats',
    'Plate',
    'Origin',
    'Governorate',
    'State',
    'Price',
  ];

  String title = "Make";
  List<VehiclesMakeResult> makeList = [];
  List<GetModelFilterResult> modelList = [];
  List<GetModelTrimFilterResult> trimList = [];
  List<GetYearFilterResult> yearList = [];
  List<GetConditionFilterResult> conditionList = [];
  List<GetEngineSizeFilterResult> engineList = [];
  List<GetDoorCountFilterResult> doorList = [];
  List<IdNameModel> exteriorColorList = [];
  List<IdNameModel> interiorColorList = [];
  List<IdNameModel> cylindersList = [];
  List<IdNameModel> fuelList = [];
  List<IdNameModel> transmissionList = [];
  List<IdNameModel> driverTrainList = [];
  List<IdNameModel> seatsList = [];
  List<IdNameModel> plateList = [];
  List<IdNameModel> originList = [];
  List<IdNameModel> governateList = [];
  List<StateModel> stateList = [];

  VehiclesMakeResult? selectedMake;
  GetModelFilterResult? selectedModel;
  GetModelTrimFilterResult? selectedTrim;
  GetYearFilterResult? selectedYear;
  GetConditionFilterResult? selectedCondition;
  GetEngineSizeFilterResult? selectedEngine;
  GetDoorCountFilterResult? selectedDoor;
  IdNameModel? selectedExteriorColor;
  IdNameModel? selectedInteriorColor;
  IdNameModel? selectedCylinder;
  IdNameModel? selectedFuel;
  IdNameModel? selectedTransmission;
  IdNameModel? selectedDriverTrain;
  IdNameModel? selectedSeat;
  IdNameModel? selectedPlate;
  IdNameModel? selectedOrigin;
  IdNameModel? selectedGovernate;
  StateModel? selectedState;
  String? selectedImage;

  bool loader = false;
  List<SubcategoryResult> subcategoryList = [];

  int _currentStepIndex = 0;

  getListData() async {
    var res = await Webservices.getMap("$get_maker_model?sub_category_id=");
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = VehiclesMakeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      makeList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getMakeFilter() async {
    var res = await Webservices.getMap(get_make_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = VehiclesMakeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      makeList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getModelFilter() async {
    var res = await Webservices.getMap(get_model_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetModelFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      modelList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getModelTrimFilter() async {
    var res = await Webservices.getMap(get_model_trim_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetModelTrimFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      trimList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }


  getYearFilter() async {
    var res = await Webservices.getMap(get_year_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetYearFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      yearList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }


  getConditionFilter() async {
    var res = await Webservices.getMap(get_condition_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetConditionFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      conditionList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }


  getEngineSizeFilter() async {
    var res = await Webservices.getMap(get_EngineSize_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetEngineSizeFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      engineList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getDoorCountFilter() async {
    var res = await Webservices.getMap(get_DoorCount_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetDoorCountFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      doorList = resdata.result!;
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

  String _getTitleForIndex(int index) {
    if (index == 1 || index < topList.length) {
      return topList[index];
    } else {
      return ""; // Handle out of bounds index gracefully
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
                      adsCategoryId: '10',
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
                    selectedType = null;
                    selectedGender = null;
                    selectedAge = null;
                    selectedGovernrate = null;
                    selectedState = null;
                    selectedCity = null;
                    currentPointValue = 0.0;
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
                        selectedType == null &&
                        selectedGender == null &&
                        selectedAge == null &&
                        selectedGovernrate == null &&
                        selectedState == null &&
                        selectedCity == null &&
                        currentPointValue == 0.0) {
                      getAdsWithCategorySubCategoryResult =
                          getAdsWithCategorySubCategoryResultGlobal;
                      setState(() {});
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPostsScreen(
                              value: true,
                              adsCategoryId: '10',
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

                        if (selectedType != null &&
                            selectedType!.isNotEmpty &&
                            selectedType == element.typeName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedType != null &&
                              selectedType!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGender != null &&
                            selectedGender!.isNotEmpty &&
                            selectedGender == element.genderName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGender != null &&
                              selectedGender!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedAge != null &&
                            selectedAge!.isNotEmpty &&
                            selectedAge == element.ageName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedAge != null && selectedAge!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGovernrate != null &&
                            selectedGovernrate!.isNotEmpty &&
                            selectedGovernrate == element.governorateName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGovernrate != null &&
                              selectedGovernrate!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        /*  if (selectedState != null &&
                            selectedState!.isNotEmpty &&
                            selectedState == element.stateName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedState != null &&
                              selectedState!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }*/

                        if (selectedCity != null &&
                            selectedCity!.isNotEmpty &&
                            selectedCity == element.cityName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedCity != null &&
                              selectedCity!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        print(
                            'currentPointValue:::::::::::::::::${currentPointValue}');
                        print(
                            'currentPointValue:::::::::::::::::${double.parse(element.animalsAdsPrice ?? '0')}');
                        print(
                            'currentPointValue:::::::::::::::::${currentPointValue >= double.parse(element.animalsAdsPrice ?? '0')}');

                        if (currentPointValue >=
                            double.parse(element.animalsAdsPrice ?? '0')) {
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
                              adsCategoryId: '10',
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
                                      getMakeFilter();
                                    } else if (_currentStepIndex == 2) {
                                      getModelFilter();
                                    }else if (_currentStepIndex == 3) {
                                      getModelTrimFilter();
                                    }else if (_currentStepIndex == 4) {
                                      getYearFilter();
                                    }else if (_currentStepIndex == 5) {
                                      getConditionFilter();
                                    }else if (_currentStepIndex == 6) {
                                      getEngineSizeFilter();
                                    }else if (_currentStepIndex == 7) {
                                      getDoorCountFilter();
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
        return Make();
      case 2:
        return Modal();
      case 3:
        return Trim();
      case 4:
        return Year();
      case 5:
        return Condition();
      case 6:
        return EngineSize();
      case 7:
        return Door();
      case 8:
        return ExteriorColor();
      case 9:
        return InteriorColor();
      case 10:
        return Cylinders();
      case 11:
        return Fuel();
      case 12:
        return Transmission();
      case 13:
        return DriverTrain();
      case 14:
        return Seats();
      case 15:
        return Plate();
      case 16:
        return Origin();
      case 17:
        return Governate();
      case 18:
        return State();
      default:
        return PriceView();
    }
  }

  Widget CategoriesView() {
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

  Widget Make() {
    return GridView.builder(
      //physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: makeList.length,
      itemBuilder: (context, int index) {
        //  GetClubsResult item = controller.getClubsModel!.result![index];
        return GestureDetector(
          onTap: () {
            selectedMake = makeList[index];
            /*modelList = makeList[index].model ?? [];
            yearList = makeList[index].year ?? [];*/
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
                            color: selectedMake == makeList[index]
                                ? Colors.orange
                                : AppColors.whiteColor)),
                    height: 50,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: makeList[index].image ?? '',
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
                    makeList[index].name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: selectedMake == makeList[index]
                            ? Colors.orange
                            : Colors.black),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              if (selectedMake == makeList[index])
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
  }

  Widget Modal() {
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
                        setState(() {
                          selectedModel = value;
                        });
                      },
                    ),
                    title: Text('${modelList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedModel = modelList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Trim() {
    return ListView.builder(
      itemCount: trimList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedTrim == trimList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: trimList[index],
              groupValue: selectedTrim,
              onChanged: (value) {
                setState(() {
                  selectedTrim = value;
                });
              },
            ),
            title: Text('${trimList[index].name}'),
            onTap: () {
              setState(() {
                selectedTrim = trimList[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget Year() {
    return ListView.builder(
        itemCount: yearList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedYear == yearList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: yearList[index],
                      groupValue: selectedYear,
                      onChanged: (value) {
                        setState(() {
                          selectedYear = value;
                        });
                      },
                    ),
                    title: Text('${yearList[index].year}'),
                    onTap: () {
                      setState(() {
                        selectedYear = yearList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Condition() {
    return ListView.builder(
        itemCount: conditionList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedCondition == conditionList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: conditionList[index],
                      groupValue: selectedCondition,
                      onChanged: (value) {
                        setState(() {
                          selectedCondition = value;
                        });
                      },
                    ),
                    title: Text('${conditionList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedCondition = conditionList[index];
                      });
                    },
                  )),
            ));
  }

  Widget EngineSize() {
    return ListView.builder(
        itemCount: engineList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedEngine == engineList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: engineList[index],
                      groupValue: selectedEngine,
                      onChanged: (value) {
                        setState(() {
                          selectedEngine = value;
                        });
                      },
                    ),
                    title: Text('${engineList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedEngine = engineList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Door() {
    return ListView.builder(
      itemCount: doorList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: selectedDoor == doorList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: doorList[index],
                groupValue: selectedDoor,
                onChanged: (value) {
                  setState(() {
                    selectedDoor = value;
                  });
                },
              ),
              title: Text('${doorList[index].name}'),
              onTap: () {
                setState(() {
                  selectedDoor = doorList[index];
                });
              },
            )),
      ),
    );
  }

  Widget ExteriorColor() {
    return GridView.builder(
      //physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: exteriorColorList.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            selectedExteriorColor = exteriorColorList[index];
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor,
                  border: Border.all(
                    width: .4,
                    color: selectedExteriorColor == exteriorColorList[index]
                        ? Colors.orange
                        : AppColors.grey.withOpacity(.5),
                  ),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: hexToColor(
                                exteriorColorList[index].code ?? '#000000'),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        exteriorColorList[index].name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: selectedExteriorColor ==
                                    exteriorColorList[index]
                                ? Colors.orange
                                : Colors.black),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              if (selectedExteriorColor == exteriorColorList[index])
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
        itemCount: exteriorColorList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedExteriorColor == exteriorColorList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: exteriorColorList[index],
                      groupValue: selectedExteriorColor,
                      onChanged: (value) {
                        setState(() {
                          selectedExteriorColor = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                        });
                      },
                    ),
                    title: Text('${exteriorColorList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedExteriorColor = exteriorColorList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                      });
                    },
                  )),
            ));
  }

  Color hexToColor(String hexString) {
    hexString = hexString.toUpperCase().replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF' + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }

  Widget InteriorColor() {
    return GridView.builder(
      // physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: interiorColorList.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            selectedInteriorColor = interiorColorList[index];
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor,
                  border: Border.all(
                    width: .4,
                    color: selectedInteriorColor == interiorColorList[index]
                        ? Colors.orange
                        : AppColors.grey.withOpacity(.5),
                  ),
                ),
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            color: hexToColor(
                                interiorColorList[index].code ?? '#000000'),
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        interiorColorList[index].name ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: selectedInteriorColor ==
                                    interiorColorList[index]
                                ? Colors.orange
                                : Colors.black),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
              if (selectedInteriorColor == interiorColorList[index])
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
        itemCount: interiorColorList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color:
                              selectedInteriorColor == interiorColorList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: interiorColorList[index],
                      groupValue: selectedInteriorColor,
                      onChanged: (value) {
                        setState(() {
                          selectedInteriorColor = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                        });
                      },
                    ),
                    title: Text('${interiorColorList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedInteriorColor = interiorColorList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                      });
                    },
                  )),
            ));
  }

  Widget Cylinders() {
    return ListView.builder(
      itemCount: cylindersList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedCylinder == cylindersList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: cylindersList[index],
              groupValue: selectedCylinder,
              onChanged: (value) {
                setState(() {
                  selectedCylinder = value;
                });
              },
            ),
            title: Text('${cylindersList[index].name}'),
            onTap: () {
              setState(() {
                selectedCylinder = cylindersList[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget Fuel() {
    return ListView.builder(
        itemCount: fuelList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: selectedFuel == fuelList[index]
                            ? MyColors.primaryColor
                            : Colors.grey.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: fuelList[index],
                      groupValue: selectedFuel,
                      onChanged: (value) {
                        setState(() {
                          selectedFuel = value;
                        });
                      },
                    ),
                    title: Text('${fuelList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedFuel = fuelList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Transmission() {
    return ListView.builder(
        itemCount: transmissionList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedTransmission == transmissionList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: transmissionList[index],
                      groupValue: selectedTransmission,
                      onChanged: (value) {
                        setState(() {
                          selectedTransmission = value;
                        });
                      },
                    ),
                    title: Text('${transmissionList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedTransmission = transmissionList[index];
                      });
                    },
                  )),
            ));
  }

  Widget DriverTrain() {
    return ListView.builder(
        itemCount: driverTrainList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedDriverTrain == driverTrainList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: driverTrainList[index],
                      groupValue: selectedDriverTrain,
                      onChanged: (value) {
                        setState(() {
                          selectedDriverTrain = value;
                        });
                      },
                    ),
                    title: Text('${driverTrainList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedDriverTrain = driverTrainList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Seats() {
    return ListView.builder(
        itemCount: seatsList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedSeat == seatsList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: seatsList[index],
                      groupValue: selectedSeat,
                      onChanged: (value) {
                        setState(() {
                          selectedSeat = value;
                        });
                      },
                    ),
                    title: Text('${seatsList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedSeat = seatsList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Plate() {
    return ListView.builder(
        itemCount: plateList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedPlate == plateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: plateList[index],
                      groupValue: selectedPlate,
                      onChanged: (value) {
                        setState(() {
                          selectedPlate = value;
                        });
                      },
                    ),
                    title: Text('${plateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedPlate = plateList[index];
                      });
                    },
                  )),
            ));
  }

  Widget Origin() {
    return ListView.builder(
        itemCount: originList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedOrigin == originList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: originList[index],
                      groupValue: selectedOrigin,
                      onChanged: (value) {
                        setState(() {
                          selectedOrigin = value;
                        });
                      },
                    ),
                    title: Text('${originList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedOrigin = originList[index];
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
                          color: selectedGovernate == governateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index],
                      groupValue: selectedGovernate,
                      onChanged: (value) {
                        setState(() {
                          selectedGovernate = value;
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedGovernate = governateList[index];
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
                          color: selectedState == stateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index],
                      groupValue: selectedState,
                      onChanged: (value) {
                        setState(() {
                          selectedState = value;
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        selectedState = stateList[index];
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
