import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_governorates_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_model_engines_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_model_year_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_parts_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_sub_parts_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_vehicles_parts_make_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_vehicles_parts_model_filter_model.dart';
import '../../Model/advertisement_model/vehicles_part_and_accessories_models/get_vehicles_parts_model_trim_filter_model.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';
import 'animals_filter.dart';

class VehiclePartsAndAccessoriesFilter extends StatefulWidget {
  final String advertisement_category_id;

  const VehiclePartsAndAccessoriesFilter(
      {super.key, required this.advertisement_category_id});

  @override
  State<VehiclePartsAndAccessoriesFilter> createState() =>
      _VehiclePartsAndAccessoriesFilterState();
}

class _VehiclePartsAndAccessoriesFilterState
    extends State<VehiclePartsAndAccessoriesFilter> {
  bool showProgressBar = false;

  int _currentStepIndex = 0;

  List<String> topList = [
    'Ads Types',
    'Parts',
    'Sub Parts',
    'Makes',
    'Models',
    'Years',
    'Trims',
    'Engine Size',
    //'Governorate',
    //'State',
    'Price',
  ];

  List<Map<String, dynamic>> adsTypesList = [
    {'type': 'Wanted', 'ads_type': 'VEHICLE_PARTS_ACCESSORIES_WANTED'},
    {'type': 'For Sale', 'ads_type': 'VEHICLE_PARTS_ACCESSORIES_SALE'},
  ];

  bool loader = false;
  List<GetPartsFilterResult> getPartsFilterResult = [];
  List<GetSubPartsFilterResult> getSubPartsFilterResult = [];
  List<GetVehiclesPartsMakeFilterResult> getVehiclesPartsMakeFilterResult = [];
  List<GetVehiclesPartsModelFilterResult> getVehiclesPartsModelFilterResult =
      [];
  List<GetVehiclesPartsModelTrimFilterResult>
      getVehiclesPartsModelTrimFilterResult = [];
  List<GetModelYearFilterResult> getModelYearFilterResult = [];
  List<GetModelEnginesFilterResult> getModelEnginesFilterResult = [];
  List<GetGovernoratesFilterResult> getGovernoratesFilterResult = [];

  getPartsFilter() async {
    var res = await Webservices.getMap(get_parts_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetPartsFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getPartsFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getSubPartsFilter() async {
    var res = await Webservices.getMap(get_sub_parts_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetSubPartsFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getSubPartsFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getVehiclesPartsMakeFilter() async {
    var res = await Webservices.getMap(get_vehicles_parts_make_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetVehiclesPartsMakeFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getVehiclesPartsMakeFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getVehiclesPartsModelFilter() async {
    var res = await Webservices.getMap(get_vehicles_parts_model_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetVehiclesPartsModelFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getVehiclesPartsModelFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getVehiclesPartsModelTrimFilter() async {
    var res = await Webservices.getMap(get_vehicles_parts_model_trim_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetVehiclesPartsModelTrimFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getVehiclesPartsModelTrimFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getModelYearFilter() async {
    var res = await Webservices.getMap(get_model_year_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetModelYearFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getModelYearFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getModelEnginesFilter() async {
    var res = await Webservices.getMap(get_model_engines_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetModelEnginesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getModelEnginesFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getGovernoratesFilter() async {
    var res = await Webservices.getMap(get_governorates_filter);
    print("status from api $res");
    showProgressBar = false;
    final resdata = GetGovernoratesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getGovernoratesFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
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
                    if (selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
                        selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter == null &&
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
                        if (selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter!
                                .isNotEmpty &&
                            selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter![
                                    'ads_type'] ==
                                element.adsType) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter !=
                                  null &&
                              selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter!
                                  .isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }


                        if (selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .partName!.isNotEmpty &&
                            selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .partName!.isNotEmpty &&
                            selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .partName ==
                                element.partName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .partName !=
                                  null &&
                              selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .partName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                                             if (selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .subPartName!.isNotEmpty &&
                            selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .subPartName!.isNotEmpty &&
                            selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .subPartName ==
                                element.subPartName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .subPartName !=
                                  null &&
                              selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .subPartName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                          if (selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .id ==
                                element.vehiclePartMakerId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .id !=
                                  null &&
                              selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                           if (selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .id ==
                                element.vehiclePartPartId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .id !=
                                  null &&
                              selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                           if (selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .id!.isNotEmpty &&
                            selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .id ==
                                element.vehiclePartModelTrimId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .id !=
                                  null &&
                              selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }


                               if (selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .yearName!.isNotEmpty &&
                            selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .yearName!.isNotEmpty &&
                            selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .yearName ==
                                element.yearName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .yearName !=
                                  null &&
                              selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .yearName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .engineValue!.isNotEmpty &&
                            selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .engineValue!.isNotEmpty &&
                            selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .engineValue ==
                                element.engineValue) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .engineValue !=
                                  null &&
                              selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .engineValue!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }



                       if (selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter !=
                                null &&
                            selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .governorateName!.isNotEmpty &&
                            selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                .governorateName!.isNotEmpty &&
                            selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                    .governorateName ==
                                element.governorateName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                          }
                        } else {
                          if (selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter != null &&
                              selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                      .governorateName !=
                                  null &&
                              selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter!
                                  .governorateName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentPointValue >=
                            double.parse(element.vehiclePartPrice ?? '0')) {
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
                              if (_currentStepIndex == 1) {
                                getPartsFilter();
                              } else if (_currentStepIndex == 2) {
                                getSubPartsFilter();
                              } else if (_currentStepIndex == 3) {
                                getVehiclesPartsMakeFilter();
                              } else if (_currentStepIndex == 4) {
                                getVehiclesPartsModelFilter();
                              }  else if (_currentStepIndex == 5) {
                                getModelYearFilter();
                              } else if (_currentStepIndex == 6) {
                                getVehiclesPartsModelTrimFilter();
                              }else if (_currentStepIndex == 7) {
                                getModelEnginesFilter();
                              } else if (_currentStepIndex == 8) {
                                getGovernoratesFilter();
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
        return AdsTypesView();
      case 1:
        return GetPartsFilterResultView();
      case 2:
        return GetSubPartsFilterResultView();
      case 3:
        return GetVehiclesPartsMakeFilterResultView();
      case 4:
        return GetVehiclesPartsModelFilterResultView();
      case 5:
        return GetModelYearFilterResultView();
      case 6:
        return GetVehiclesPartsModelTrimFilterResultView();
      case 7:
        return GetModelEnginesFilterResultView();
      case 8:
        return GetGovernoratesFilterResultView();
      default:
        return PriceView();
    }
  }

  Widget AdsTypesView() {
    return ListView.builder(
      itemCount: adsTypesList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter ==
                              adsTypesList[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: adsTypesList[index],
              groupValue:
                  selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter =
                    adsTypesList[index];
                setState(() {});
              },
            ),
            title: Text('${adsTypesList[index]['type']}'),
            onTap: () {
              selectedAdsTypesListForVehicleAPartsAndAccessoriesFilter =
                  adsTypesList[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetPartsFilterResultView() {
    return ListView.builder(
      itemCount: getPartsFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getPartsFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getPartsFilterResult[index],
              groupValue:
                  selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getPartsFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getPartsFilterResult[index].partName}'),
            onTap: () {
              selectedGetPartsFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getPartsFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetSubPartsFilterResultView() {
    return ListView.builder(
      itemCount: getSubPartsFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getSubPartsFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getSubPartsFilterResult[index],
              groupValue:
                  selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getSubPartsFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getSubPartsFilterResult[index].subPartName}'),
            onTap: () {
              selectedGetSubPartsFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getSubPartsFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetVehiclesPartsMakeFilterResultView() {
    return ListView.builder(
      itemCount: getVehiclesPartsMakeFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getVehiclesPartsMakeFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getVehiclesPartsMakeFilterResult[index],
              groupValue:
                  selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getVehiclesPartsMakeFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getVehiclesPartsMakeFilterResult[index].name}'),
            onTap: () {
              selectedGetVehiclesPartsMakeFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getVehiclesPartsMakeFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetVehiclesPartsModelFilterResultView() {
    return ListView.builder(
      itemCount: getVehiclesPartsModelFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getVehiclesPartsModelFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getVehiclesPartsModelFilterResult[index],
              groupValue:
                  selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getVehiclesPartsModelFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getVehiclesPartsModelFilterResult[index].name}'),
            onTap: () {
              selectedGetVehiclesPartsModelFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getVehiclesPartsModelFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetVehiclesPartsModelTrimFilterResultView() {
    return ListView.builder(
      itemCount: getVehiclesPartsModelTrimFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getVehiclesPartsModelTrimFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getVehiclesPartsModelTrimFilterResult[index],
              groupValue:
                  selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getVehiclesPartsModelTrimFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getVehiclesPartsModelTrimFilterResult[index].name}'),
            onTap: () {
              selectedGetVehiclesPartsModelTrimFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getVehiclesPartsModelTrimFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetModelYearFilterResultView() {
    return ListView.builder(
      itemCount: getModelYearFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getModelYearFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getModelYearFilterResult[index],
              groupValue:
                  selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getModelYearFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getModelYearFilterResult[index].yearName}'),
            onTap: () {
              selectedGetModelYearFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getModelYearFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetModelEnginesFilterResultView() {
    return ListView.builder(
      itemCount: getModelEnginesFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getModelEnginesFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getModelEnginesFilterResult[index],
              groupValue:
                  selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getModelEnginesFilterResult[index];
                setState(() {});
              },
            ),
            title: Text('${getModelEnginesFilterResult[index].engineValue}'),
            onTap: () {
              selectedGetModelEnginesFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getModelEnginesFilterResult[index];
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GetGovernoratesFilterResultView() {
    return ListView.builder(
      itemCount: getGovernoratesFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter ==
                              getGovernoratesFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getGovernoratesFilterResult[index],
              groupValue:
                  selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter,
              onChanged: (value) {
                selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter =
                    getGovernoratesFilterResult[index];
                setState(() {});
              },
            ),
            title:
                Text('${getGovernoratesFilterResult[index].governorateName}'),
            onTap: () {
              selectedGetGovernoratesFilterResultForVehicleAPartsAndAccessoriesFilter =
                  getGovernoratesFilterResult[index];
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
