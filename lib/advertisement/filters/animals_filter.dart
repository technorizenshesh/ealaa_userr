import 'package:ealaa_userr/Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_electronics_condition_filter_model.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../../Model/advertisement_model/AnimalTypeModel.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/VehiclesMakeModel.dart';
import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_electronics_brand_filter_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_number_type_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_operators_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_condition_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_cylinders_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_door_count_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_drivetrain_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_engine_size_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_exterior_color_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_fuel_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_governate_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_model_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_model_trim_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_origin_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_plate_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_seats_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_states_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_transmission_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_year_filter_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';

String? selectedCategories;
String? selectedType;
String? selectedGender;
String? selectedAge;
String? selectedGovernrate;
String? selectedState;
String? selectedCity;
double currentPointValue = 0.0;



VehiclesMakeResult? selectedMakeForVehicleForSaleAndRentFilter;
GetModelFilterResult? selectedModelForVehicleForSaleAndRentFilter;
GetModelTrimFilterResult? selectedTrimForVehicleForSaleAndRentFilter;
GetYearFilterResult? selectedYearForVehicleForSaleAndRentFilter;
GetConditionFilterResult? selectedConditionForVehicleForSaleAndRentFilter;
GetEngineSizeFilterResult? selectedEngineForVehicleForSaleAndRentFilter;
GetDoorCountFilterResult? selectedDoorForVehicleForSaleAndRentFilter;
GetExteriorColorFilterResult? selectedExteriorColorForVehicleForSaleAndRentFilter;
GetExteriorColorFilterResult? selectedInteriorColorForVehicleForSaleAndRentFilter;
GetCylindersFilterResult? selectedCylinderForVehicleForSaleAndRentFilter;
GetFuelFilterResult? selectedFuelForVehicleForSaleAndRentFilter;
GetTransmissionFilterResult? selectedTransmissionForVehicleForSaleAndRentFilter;
GetDrivetrainFilterResult? selectedDriverTrainForVehicleForSaleAndRentFilter;
GetSeatsFilterResult? selectedSeatForVehicleForSaleAndRentFilter;
GetPlateFilterResult? selectedPlateForVehicleForSaleAndRentFilter;
GetOriginFilterResult? selectedOriginForVehicleForSaleAndRentFilter;
GetGovernorateFilterResult? selectedGovernateForVehicleForSaleAndRentFilter;
GetStatesFilterResult? selectedStateForVehicleForSaleAndRentFilter;


GetElectronicsBrandFilterResult?   selectedBrandForElectronicsForSaleAndRentFilter;
GetElectronicsConditionFilterResult?   selectedConditionForElectronicsForSaleAndRentFilter;
GetGovernorateFilterResult? selectedGovernateForElectronicsForSaleAndRentFilter;
GetStatesFilterResult? selectedStateForElectronicsForSaleAndRentFilter;

GetNumberTypeResult? selectedGetNumberTypeResultForPhoneNumberFilter;
GetOperatorsResult? selectedGetOperatorsResultForPhoneNumberFilter;
GetGovernorateFilterResult? selectedGovernateForPhoneNumberFilter;
GetStatesFilterResult? selectedStateForPhoneNumberFilter;


class AnimalsFilter extends StatefulWidget {
  final String advertisement_category_id;

  const AnimalsFilter({super.key, required this.advertisement_category_id});

  @override
  State<AnimalsFilter> createState() => _AnimalsFilterState();
}

class _AnimalsFilterState extends State<AnimalsFilter> {
  bool showProgressBar = true;
  int _currentStepIndex = 0;
  List<String> topList = [
    'Categories',
    'Ads Types',
    'Gender',
    'Age',
    'Governorate',
    'State',
    'Price',
  ];

  String title = "Type";
  AnimalTypeResult? animalTypeResult;
  List<Type> typeList = [];
  List<Gender> genderList = [];
  List<Age> ageList = [];
  List<BreedOrigin> breedList = [];
  List<Governorate> governateList = [];
  List<GovernorateState> stateList = [];
  List<StateCity> cityList = [];

  bool loader = false;
  List<SubcategoryResult> subcategoryList = [];

  getListData() async {
    var res = await Webservices.getMap(get_animals);
    print("status from api $res");
    showProgressBar = false;
    final resdata = AnimalTypeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      animalTypeResult = resdata.result!;
      typeList = animalTypeResult!.type ?? [];
      genderList = animalTypeResult!.gender ?? [];
      ageList = animalTypeResult!.age ?? [];
      breedList = animalTypeResult!.breedOrigin ?? [];
      governateList = animalTypeResult!.governorate ?? [];
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

                        if (selectedState != null &&
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
                        }

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
          : animalTypeResult == null
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(topList.length, (index) {
                              return GestureDetector(
                                onTap: () {
                                  _currentStepIndex = index;
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
                                              color: _currentStepIndex != index
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
        return TypeView();
      case 2:
        return GenderView();
      case 3:
        return AgeView();
      case 4:
        return GovernateView();
      case 5:
        return StateView();
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

  Widget TypeView() {
    return ListView.builder(
      itemCount: typeList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: selectedType == typeList[index].typeName
                  ? MyColors.primaryColor
                  : Colors.grey.withOpacity(0.5),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: typeList[index].typeName,
              groupValue: selectedType,
              onChanged: (value) {
                selectedType = typeList[index].typeName;
                setState(() {});
              },
            ),
            title: Text('${typeList[index].typeName}'),
            onTap: () {
              selectedType = typeList[index].typeName;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GenderView() {
    return ListView.builder(
      itemCount: genderList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedGender == genderList[index].name
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: genderList[index].name,
              groupValue: selectedGender,
              onChanged: (value) {
                selectedGender = genderList[index].name;
                setState(() {});
              },
            ),
            title: Text('${genderList[index].name}'),
            onTap: () {
              selectedGender = genderList[index].name;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget AgeView() {
    return ListView.builder(
      itemCount: ageList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedAge == ageList[index].ageName
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: ageList[index].ageName,
              groupValue: selectedAge,
              onChanged: (value) {
                selectedAge = ageList[index].ageName;
                setState(() {});
              },
            ),
            title: Text('${ageList[index].ageName}'),
            onTap: () {
              selectedAge = ageList[index].ageName;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GovernateView() {
    return ListView.builder(
      itemCount: governateList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGovernrate == governateList[index].governorateName
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: governateList[index].governorateName,
              groupValue: selectedGovernrate,
              onChanged: (value) {
                selectedGovernrate = governateList[index].governorateName;
                stateList = governateList[index].governorateState ?? [];
                setState(() {});
              },
            ),
            title: Text('${governateList[index].governorateName}'),
            onTap: () {
              selectedGovernrate = governateList[index].governorateName;
              stateList = governateList[index].governorateState ?? [];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget StateView() {
    return ListView.builder(
      itemCount: stateList.length,
      itemBuilder: (context, index) => Column(
        children: [
          GestureDetector(
            onTap: () {
              selectedState = stateList[index].stateName;
              setState(() {});
              if (selectedState != stateList[index].stateName) {
                selectedState = stateList[index].stateName;
                setState(() {});
              } else {
                //selectedState = -1;
                setState(() {});
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.only(bottom: 15),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 4),
                trailing: Icon(
                  selectedState == stateList[index].stateName
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: MyColors.primaryColor,
                  size: 24,
                ),
                title: Text('${stateList[index].stateName}'),
              ),
            ),
          ),
          if (selectedState == stateList[index].stateName)
            ListView.builder(
              shrinkWrap: true,
              itemCount: stateList[index].stateCity?.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: selectedCity ==
                                stateList[index].stateCity![i].cityName
                            ? MyColors.primaryColor
                            : Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index].stateCity![i].cityName,
                      groupValue: selectedCity,
                      onChanged: (value) {
                        selectedCity = stateList[index].stateCity![i].cityName;
                        setState(() {});
                      },
                    ),
                    title: Text('${stateList[index].stateCity![i].cityName}'),
                    onTap: () {
                      selectedCity = stateList[index].stateCity![i].cityName;
                      setState(() {});
                    },
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget CityView() {
    return ListView.builder(
      itemCount: cityList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedCity == cityList[index].cityName
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: cityList[index].cityName,
              groupValue: selectedCity,
              onChanged: (value) {
                selectedCity = value;
              },
            ),
            title: Text('${cityList[index].cityName}'),
            onTap: () {
              selectedCity = cityList[index].cityName;
              setState(() {});
            },
          ),
        ),
      ),
    );
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
