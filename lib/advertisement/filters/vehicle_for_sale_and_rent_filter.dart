import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/VehiclesMakeModel.dart';
import '../../Model/advertisement_model/ad_subcategory_model.dart';
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

  List<SubcategoryResult> subcategoryList = [];
  List<VehiclesMakeResult> makeList = [];
  List<GetModelFilterResult> modelList = [];
  List<GetModelTrimFilterResult> trimList = [];
  List<GetYearFilterResult> yearList = [];
  List<GetConditionFilterResult> conditionList = [];
  List<GetEngineSizeFilterResult> engineList = [];
  List<GetDoorCountFilterResult> doorList = [];
  List<GetExteriorColorFilterResult> exteriorColorList = [];
  List<GetExteriorColorFilterResult> interiorColorList = [];
  List<GetCylindersFilterResult> cylindersList = [];
  List<GetFuelFilterResult> fuelList = [];
  List<GetTransmissionFilterResult> transmissionList = [];
  List<GetDrivetrainFilterResult> driverTrainList = [];
  List<GetSeatsFilterResult> seatsList = [];
  List<GetPlateFilterResult> plateList = [];
  List<GetOriginFilterResult> originList = [];
  List<GetGovernorateFilterResult> governateList = [];
  List<GetStatesFilterResult> stateList = [];

  bool loader = false;

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

  getExteriorColorFilter() async {
    var res = await Webservices.getMap(get_exteriorColor_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetExteriorColorFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      exteriorColorList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getInteriorColorFilter() async {
    var res = await Webservices.getMap(get_interiorColor_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetExteriorColorFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      interiorColorList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getCylindersFilter() async {
    var res = await Webservices.getMap(get_cylinders_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetCylindersFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      cylindersList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getFuelFilter() async {
    var res = await Webservices.getMap(get_fuel_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetFuelFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      fuelList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getTransmissionFilter() async {
    var res = await Webservices.getMap(get_transmission_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetTransmissionFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      transmissionList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getDrivetrainFilter() async {
    var res = await Webservices.getMap(get_drivetrain_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetDrivetrainFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      driverTrainList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getSeatsFilter() async {
    var res = await Webservices.getMap(get_seats_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetSeatsFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      seatsList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getPlateFilter() async {
    var res = await Webservices.getMap(get_plate_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetPlateFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      plateList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getOriginFilter() async {
    var res = await Webservices.getMap(get_origin_filter);
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetOriginFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      originList = resdata.result!;
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
                  onTap: () {
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
                        selectedMakeForVehicleForSaleAndRentFilter == null &&
                        selectedModelForVehicleForSaleAndRentFilter == null &&
                        selectedTrimForVehicleForSaleAndRentFilter == null &&
                        selectedYearForVehicleForSaleAndRentFilter == null &&
                        selectedConditionForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedEngineForVehicleForSaleAndRentFilter == null &&
                        selectedDoorForVehicleForSaleAndRentFilter == null &&
                        selectedExteriorColorForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedInteriorColorForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedCylinderForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedFuelForVehicleForSaleAndRentFilter == null &&
                        selectedTransmissionForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedDriverTrainForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedSeatForVehicleForSaleAndRentFilter == null &&
                        selectedPlateForVehicleForSaleAndRentFilter == null &&
                        selectedOriginForVehicleForSaleAndRentFilter == null &&
                        selectedGovernateForVehicleForSaleAndRentFilter ==
                            null &&
                        selectedStateForVehicleForSaleAndRentFilter == null &&
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

                        if (selectedMakeForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedMakeForVehicleForSaleAndRentFilter!.id !=
                                null &&
                            selectedMakeForVehicleForSaleAndRentFilter!
                                .id!.isNotEmpty &&
                            selectedMakeForVehicleForSaleAndRentFilter!.id ==
                                element.vehicleAdsDetailMakerId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedMakeForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedMakeForVehicleForSaleAndRentFilter!.id !=
                                  null &&
                              selectedMakeForVehicleForSaleAndRentFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedModelForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedModelForVehicleForSaleAndRentFilter!.id !=
                                null &&
                            selectedModelForVehicleForSaleAndRentFilter!
                                .id!.isNotEmpty &&
                            selectedModelForVehicleForSaleAndRentFilter!.id ==
                                element.vehicleAdsDetailModelId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedModelForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedModelForVehicleForSaleAndRentFilter!.id !=
                                  null &&
                              selectedModelForVehicleForSaleAndRentFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedTrimForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedTrimForVehicleForSaleAndRentFilter!.id !=
                                null &&
                            selectedTrimForVehicleForSaleAndRentFilter!
                                .id!.isNotEmpty &&
                            selectedTrimForVehicleForSaleAndRentFilter!.id ==
                                element.vehicleAdsDetailModelTrimId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedTrimForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedTrimForVehicleForSaleAndRentFilter!.id !=
                                  null &&
                              selectedTrimForVehicleForSaleAndRentFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedYearForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedYearForVehicleForSaleAndRentFilter!.year !=
                                null &&
                            selectedYearForVehicleForSaleAndRentFilter!
                                .year!.isNotEmpty &&
                            selectedYearForVehicleForSaleAndRentFilter!.year ==
                                element.vehicleAdsDetailYear) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedYearForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedYearForVehicleForSaleAndRentFilter!
                                      .year !=
                                  null &&
                              selectedYearForVehicleForSaleAndRentFilter!
                                  .year!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedConditionForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedConditionForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedConditionForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedConditionForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailCondition) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedConditionForVehicleForSaleAndRentFilter != null &&
                              selectedConditionForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedConditionForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedEngineForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedEngineForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedEngineForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedEngineForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailEngineSize) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedEngineForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedEngineForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedEngineForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedDoorForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedDoorForVehicleForSaleAndRentFilter!.name !=
                                null &&
                            selectedDoorForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedDoorForVehicleForSaleAndRentFilter!.name ==
                                element.vehicleAdsDetailDoors) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedDoorForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedDoorForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedDoorForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedExteriorColorForVehicleForSaleAndRentFilter != null &&
                            selectedExteriorColorForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedExteriorColorForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedExteriorColorForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailExteriorColor) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedExteriorColorForVehicleForSaleAndRentFilter != null &&
                              selectedExteriorColorForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedExteriorColorForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedInteriorColorForVehicleForSaleAndRentFilter != null &&
                            selectedInteriorColorForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedInteriorColorForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedInteriorColorForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailInteriorColor) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedInteriorColorForVehicleForSaleAndRentFilter != null &&
                              selectedInteriorColorForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedInteriorColorForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedCylinderForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedCylinderForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedCylinderForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedCylinderForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailCylinders) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedCylinderForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedCylinderForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedCylinderForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedFuelForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedFuelForVehicleForSaleAndRentFilter!.name !=
                                null &&
                            selectedFuelForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedFuelForVehicleForSaleAndRentFilter!.name ==
                                element.vehicleAdsDetailFuel) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedFuelForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedFuelForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedFuelForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }
                        if (selectedTransmissionForVehicleForSaleAndRentFilter != null &&
                            selectedTransmissionForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedTransmissionForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedTransmissionForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailTransmission) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedTransmissionForVehicleForSaleAndRentFilter != null &&
                              selectedTransmissionForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedTransmissionForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedDriverTrainForVehicleForSaleAndRentFilter != null &&
                            selectedDriverTrainForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedDriverTrainForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedDriverTrainForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailDriveTrain) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedDriverTrainForVehicleForSaleAndRentFilter != null &&
                              selectedDriverTrainForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedDriverTrainForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedSeatForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedSeatForVehicleForSaleAndRentFilter!.name !=
                                null &&
                            selectedSeatForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedSeatForVehicleForSaleAndRentFilter!.name ==
                                element.vehicleAdsDetailSeats) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedSeatForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedSeatForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedSeatForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedPlateForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedPlateForVehicleForSaleAndRentFilter!.name !=
                                null &&
                            selectedPlateForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedPlateForVehicleForSaleAndRentFilter!.name ==
                                element.vehicleAdsDetailPlate) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedPlateForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedPlateForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedPlateForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedOriginForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedOriginForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedOriginForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedOriginForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailOrigin) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedOriginForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedOriginForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedOriginForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGovernateForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedGovernateForVehicleForSaleAndRentFilter!
                                    .name !=
                                null &&
                            selectedGovernateForVehicleForSaleAndRentFilter!
                                .name!.isNotEmpty &&
                            selectedGovernateForVehicleForSaleAndRentFilter!
                                    .name ==
                                element.vehicleAdsDetailGovernate) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGovernateForVehicleForSaleAndRentFilter != null &&
                              selectedGovernateForVehicleForSaleAndRentFilter!
                                      .name !=
                                  null &&
                              selectedGovernateForVehicleForSaleAndRentFilter!
                                  .name!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedStateForVehicleForSaleAndRentFilter !=
                                null &&
                            selectedStateForVehicleForSaleAndRentFilter!
                                    .stateName !=
                                null &&
                            selectedStateForVehicleForSaleAndRentFilter!
                                .stateName!.isNotEmpty &&
                            selectedStateForVehicleForSaleAndRentFilter!
                                    .stateName ==
                                element.vehicleAdsDetailState) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedStateForVehicleForSaleAndRentFilter !=
                                  null &&
                              selectedStateForVehicleForSaleAndRentFilter!
                                      .stateName !=
                                  null &&
                              selectedStateForVehicleForSaleAndRentFilter!
                                  .stateName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentPointValue >=
                            double.parse(
                                element.vehicleAdsAdditionalDetailPrice ??
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
                      print(
                          'getAdsWithCategorySubCategoryResult::::::::::::::::${getAdsWithCategorySubCategoryResult}');
                      print(
                          'getAdsWithCategorySubCategoryResult::::::::::::::::${getAdsWithCategorySubCategoryResult.length}');
                      print('filteredAds::::::::::::::::${filteredAds.length}');
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
                                      getMakeFilter();
                                    } else if (_currentStepIndex == 2) {
                                      getModelFilter();
                                    } else if (_currentStepIndex == 3) {
                                      getModelTrimFilter();
                                    } else if (_currentStepIndex == 4) {
                                      getYearFilter();
                                    } else if (_currentStepIndex == 5) {
                                      getConditionFilter();
                                    } else if (_currentStepIndex == 6) {
                                      getEngineSizeFilter();
                                    } else if (_currentStepIndex == 7) {
                                      getDoorCountFilter();
                                    } else if (_currentStepIndex == 8) {
                                      getExteriorColorFilter();
                                    } else if (_currentStepIndex == 9) {
                                      getInteriorColorFilter();
                                    } else if (_currentStepIndex == 10) {
                                      getCylindersFilter();
                                    } else if (_currentStepIndex == 11) {
                                      getFuelFilter();
                                    } else if (_currentStepIndex == 12) {
                                      getTransmissionFilter();
                                    } else if (_currentStepIndex == 13) {
                                      getDrivetrainFilter();
                                    } else if (_currentStepIndex == 14) {
                                      getSeatsFilter();
                                    } else if (_currentStepIndex == 15) {
                                      getPlateFilter();
                                    } else if (_currentStepIndex == 16) {
                                      getOriginFilter();
                                    } else if (_currentStepIndex == 17) {
                                      getGovernorateFilter();
                                    } else if (_currentStepIndex == 18) {
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
            selectedMakeForVehicleForSaleAndRentFilter = makeList[index];
            setState(() {});
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
                            color: selectedMakeForVehicleForSaleAndRentFilter
                                        ?.id ==
                                    makeList[index].id
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
                        color: selectedMakeForVehicleForSaleAndRentFilter?.id ==
                                makeList[index].id
                            ? Colors.orange
                            : Colors.black),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              if (selectedMakeForVehicleForSaleAndRentFilter?.id ==
                  makeList[index].id)
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
                          color: selectedModelForVehicleForSaleAndRentFilter ==
                                  modelList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: modelList[index],
                      groupValue: selectedModelForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedModelForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${modelList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedModelForVehicleForSaleAndRentFilter =
                            modelList[index];
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
                  color: selectedTrimForVehicleForSaleAndRentFilter ==
                          trimList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: trimList[index],
              groupValue: selectedTrimForVehicleForSaleAndRentFilter,
              onChanged: (value) {
                setState(() {
                  selectedTrimForVehicleForSaleAndRentFilter = value;
                });
              },
            ),
            title: Text('${trimList[index].name}'),
            onTap: () {
              setState(() {
                selectedTrimForVehicleForSaleAndRentFilter = trimList[index];
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
                          color: selectedYearForVehicleForSaleAndRentFilter ==
                                  yearList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: yearList[index],
                      groupValue: selectedYearForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedYearForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${yearList[index].year}'),
                    onTap: () {
                      setState(() {
                        selectedYearForVehicleForSaleAndRentFilter =
                            yearList[index];
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
                          color:
                              selectedConditionForVehicleForSaleAndRentFilter ==
                                      conditionList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: conditionList[index],
                      groupValue:
                          selectedConditionForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedConditionForVehicleForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${conditionList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedConditionForVehicleForSaleAndRentFilter =
                            conditionList[index];
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
                          color: selectedEngineForVehicleForSaleAndRentFilter ==
                                  engineList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: engineList[index],
                      groupValue: selectedEngineForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedEngineForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${engineList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedEngineForVehicleForSaleAndRentFilter =
                            engineList[index];
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
                    color: selectedDoorForVehicleForSaleAndRentFilter ==
                            doorList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: doorList[index],
                groupValue: selectedDoorForVehicleForSaleAndRentFilter,
                onChanged: (value) {
                  setState(() {
                    selectedDoorForVehicleForSaleAndRentFilter = value;
                  });
                },
              ),
              title: Text('${doorList[index].name}'),
              onTap: () {
                setState(() {
                  selectedDoorForVehicleForSaleAndRentFilter = doorList[index];
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
            selectedExteriorColorForVehicleForSaleAndRentFilter =
                exteriorColorList[index];
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
                    color:
                        selectedExteriorColorForVehicleForSaleAndRentFilter ==
                                exteriorColorList[index]
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
                            color:
                                selectedExteriorColorForVehicleForSaleAndRentFilter ==
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
              if (selectedExteriorColorForVehicleForSaleAndRentFilter ==
                  exteriorColorList[index])
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

  Color hexToColor(String hexString) {
    hexString = hexString.toUpperCase().replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
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
            selectedInteriorColorForVehicleForSaleAndRentFilter =
                interiorColorList[index];
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
                    color:
                        selectedInteriorColorForVehicleForSaleAndRentFilter ==
                                interiorColorList[index]
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
                            color:
                                selectedInteriorColorForVehicleForSaleAndRentFilter ==
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
              if (selectedInteriorColorForVehicleForSaleAndRentFilter ==
                  interiorColorList[index])
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

  Widget Cylinders() {
    return ListView.builder(
      itemCount: cylindersList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedCylinderForVehicleForSaleAndRentFilter ==
                          cylindersList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: cylindersList[index],
              groupValue: selectedCylinderForVehicleForSaleAndRentFilter,
              onChanged: (value) {
                setState(() {
                  selectedCylinderForVehicleForSaleAndRentFilter = value;
                });
              },
            ),
            title: Text('${cylindersList[index].name}'),
            onTap: () {
              setState(() {
                selectedCylinderForVehicleForSaleAndRentFilter =
                    cylindersList[index];
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
                        color: selectedFuelForVehicleForSaleAndRentFilter ==
                                fuelList[index]
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
                      groupValue: selectedFuelForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedFuelForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${fuelList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedFuelForVehicleForSaleAndRentFilter =
                            fuelList[index];
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
                          color:
                              selectedTransmissionForVehicleForSaleAndRentFilter ==
                                      transmissionList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: transmissionList[index],
                      groupValue:
                          selectedTransmissionForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedTransmissionForVehicleForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${transmissionList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedTransmissionForVehicleForSaleAndRentFilter =
                            transmissionList[index];
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
                          color:
                              selectedDriverTrainForVehicleForSaleAndRentFilter ==
                                      driverTrainList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: driverTrainList[index],
                      groupValue:
                          selectedDriverTrainForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedDriverTrainForVehicleForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${driverTrainList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedDriverTrainForVehicleForSaleAndRentFilter =
                            driverTrainList[index];
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
                          color: selectedSeatForVehicleForSaleAndRentFilter ==
                                  seatsList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: seatsList[index],
                      groupValue: selectedSeatForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedSeatForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${seatsList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedSeatForVehicleForSaleAndRentFilter =
                            seatsList[index];
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
                          color: selectedPlateForVehicleForSaleAndRentFilter ==
                                  plateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: plateList[index],
                      groupValue: selectedPlateForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedPlateForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${plateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedPlateForVehicleForSaleAndRentFilter =
                            plateList[index];
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
                          color: selectedOriginForVehicleForSaleAndRentFilter ==
                                  originList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: originList[index],
                      groupValue: selectedOriginForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedOriginForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${originList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedOriginForVehicleForSaleAndRentFilter =
                            originList[index];
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
                              selectedGovernateForVehicleForSaleAndRentFilter ==
                                      governateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index],
                      groupValue:
                          selectedGovernateForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGovernateForVehicleForSaleAndRentFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedGovernateForVehicleForSaleAndRentFilter =
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
                          color: selectedStateForVehicleForSaleAndRentFilter ==
                                  stateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index],
                      groupValue: selectedStateForVehicleForSaleAndRentFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedStateForVehicleForSaleAndRentFilter = value;
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        selectedStateForVehicleForSaleAndRentFilter =
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
