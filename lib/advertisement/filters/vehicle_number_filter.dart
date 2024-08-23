import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_number_type_model.dart';
import '../../Model/advertisement_model/advertisement_model_for_electronics_for_sale_and_rent/get_operators_model.dart';
import '../../Model/advertisement_model/advertisement_model_vehicle_number_models/get_letters_filter_model.dart';
import '../../Model/advertisement_model/advertisement_model_vehicle_number_models/get_plate_types_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_governate_filter_model.dart';
import '../../Model/advertisement_model/advertisement_models_for_vehicle_for_sale_and_rent/get_states_filter_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../CategoryPostsScreen.dart';
import 'animals_filter.dart';

class VehicleNumberFilter extends StatefulWidget {
  final String advertisement_category_id;

  const VehicleNumberFilter(
      {super.key, required this.advertisement_category_id});

  @override
  State<VehicleNumberFilter> createState() => _VehicleNumberFilterState();
}

class _VehicleNumberFilterState extends State<VehicleNumberFilter> {
  bool showProgressBar = true;
  List<String> topList = [
    'Number',
    'Letter',
    'Letter Count',
    'Plate Type',
    'Transfer Type',
    'Location',
    'Price',
  ];

  List<String> letterCountList = ['Single', 'Similar', 'Different'];

  List<Map<String, dynamic>> transferTypeList = [
    {'type': 'For Sale', 'ads_type': 'NUMBER_PLATE_SALE'},
    {'type': 'Wanted', 'ads_type': 'NUMBER_PLATE_WANTED'}
  ];

  List<SubcategoryResult> subcategoryList = [];
  List<GetOperatorsResult> getNumberResult = [];
  List<GetLettersFilterResult> getLettersFilterResult = [];
  List<GetPlateTypesFilterResult> getPlateTypesFilterResult = [];
  List<GetNumberTypeResult> getNumberTypeResult = [];
  List<GetGovernorateFilterResult> governateList = [];
  List<GetStatesFilterResult> stateList = [];

  bool loader = false;

  int _currentStepIndex = 0;

  getNumberType() async {
    var res = await Webservices.getMap(get_number_type);
    showProgressBar = false;
    final resdata = GetNumberTypeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getNumberTypeResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getNumber() async {
    var res = await Webservices.getMap(get_operators);
    showProgressBar = false;
    final resdata = GetOperatorsModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getNumberResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  letterFilter() async {
    var res = await Webservices.getMap(get_letters_filter);
    showProgressBar = false;
    final resdata = GetLettersFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getLettersFilterResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getPlateTypesFilter() async {
    var res = await Webservices.getMap(get_plate_types_filter);
    showProgressBar = false;
    final resdata = GetPlateTypesFilterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getPlateTypesFilterResult = resdata.result!;
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
    getNumberType();
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
                        selectedGetNumberTypeResultForVehicleNumberFilter ==
                            null &&
                        selectedGetGovernorateFilterResultForVehicleNumberFilter ==
                            null &&
                        selectedGetLettersFilterResultForVehicleNumberFilter ==
                            null &&
                        selectedGetPlateTypesFilterResultForVehicleNumberFilter ==
                            null &&
                        selectedLetterCountListForVehicleNumberFilter == null &&
                        selectedTransferTypeForVehicleNumberFilter == null &&
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
                        if (selectedGetNumberTypeResultForVehicleNumberFilter != null &&
                            selectedGetNumberTypeResultForVehicleNumberFilter!
                                    .vehiclesNumberTypeName !=
                                null &&
                            selectedGetNumberTypeResultForVehicleNumberFilter!
                                .vehiclesNumberTypeName!.isNotEmpty &&
                            selectedGetNumberTypeResultForVehicleNumberFilter!
                                    .vehiclesNumberTypeName ==
                                element.numberType) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetNumberTypeResultForVehicleNumberFilter != null &&
                              selectedGetNumberTypeResultForVehicleNumberFilter!
                                      .vehiclesNumberTypeName !=
                                  null &&
                              selectedGetNumberTypeResultForVehicleNumberFilter!
                                  .vehiclesNumberTypeName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetGovernorateFilterResultForVehicleNumberFilter != null &&
                            selectedGetGovernorateFilterResultForVehicleNumberFilter!
                                    .id !=
                                null &&
                            selectedGetGovernorateFilterResultForVehicleNumberFilter!
                                .id!.isNotEmpty &&
                            selectedGetGovernorateFilterResultForVehicleNumberFilter!
                                    .id ==
                                element.vehicleNumberGovernorateId) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetGovernorateFilterResultForVehicleNumberFilter != null &&
                              selectedGetGovernorateFilterResultForVehicleNumberFilter!
                                      .id !=
                                  null &&
                              selectedGetGovernorateFilterResultForVehicleNumberFilter!
                                  .id!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetLettersFilterResultForVehicleNumberFilter != null &&
                            selectedGetLettersFilterResultForVehicleNumberFilter!
                                    .letterNameEnglish !=
                                null &&
                            selectedGetLettersFilterResultForVehicleNumberFilter!
                                .letterNameEnglish!.isNotEmpty &&
                            selectedGetLettersFilterResultForVehicleNumberFilter!
                                    .letterNameEnglish ==
                                element.letterNameEnglish) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetLettersFilterResultForVehicleNumberFilter != null &&
                              selectedGetLettersFilterResultForVehicleNumberFilter!
                                      .letterNameEnglish !=
                                  null &&
                              selectedGetLettersFilterResultForVehicleNumberFilter!
                                  .letterNameEnglish!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedGetPlateTypesFilterResultForVehicleNumberFilter != null &&
                            selectedGetPlateTypesFilterResultForVehicleNumberFilter!
                                    .plateTypeName !=
                                null &&
                            selectedGetPlateTypesFilterResultForVehicleNumberFilter!
                                .plateTypeName!.isNotEmpty &&
                            selectedGetPlateTypesFilterResultForVehicleNumberFilter!
                                    .plateTypeName ==
                                element.plateTypeName) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedGetPlateTypesFilterResultForVehicleNumberFilter != null &&
                              selectedGetPlateTypesFilterResultForVehicleNumberFilter!
                                      .plateTypeName !=
                                  null &&
                              selectedGetPlateTypesFilterResultForVehicleNumberFilter!
                                  .plateTypeName!.isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedTransferTypeForVehicleNumberFilter !=
                                null &&
                            selectedTransferTypeForVehicleNumberFilter!
                                .isNotEmpty &&
                            selectedTransferTypeForVehicleNumberFilter!['ads_type'] ==
                                element.adsType) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedTransferTypeForVehicleNumberFilter !=
                                  null &&
                              selectedTransferTypeForVehicleNumberFilter!
                                  .isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (selectedLetterCountListForVehicleNumberFilter !=
                                null &&
                            selectedLetterCountListForVehicleNumberFilter!
                                .isNotEmpty &&
                            selectedLetterCountListForVehicleNumberFilter ==
                                element.letterType) {
                          if (!filteredAds.contains(element)) {
                            filteredAds.add(element);
                            setState(() {});
                          }
                        } else {
                          if (selectedLetterCountListForVehicleNumberFilter !=
                                  null &&
                              selectedLetterCountListForVehicleNumberFilter!
                                  .isNotEmpty) {
                            filteredAds.remove(element);
                            setState(() {});
                          }
                        }

                        if (currentPointValue >=
                            double.parse(element.vehicleNumberPrice ?? '0')) {
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
                            adsSubCategoryId: selectedCategories.toString(),
                          ),
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
          : subcategoryList.isNotEmpty
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
                                      letterFilter();
                                    } else if (_currentStepIndex == 3) {
                                      getPlateTypesFilter();
                                    } else if (_currentStepIndex == 5) {
                                      getGovernorateFilter();
                                    } else if (_currentStepIndex == 6) {
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
        return NumberView();
      case 1:
        return LetterView();
      case 2:
        return LetterCountView();
      case 3:
        return PlateTypeView();
      case 4:
        return TransferTypeView();
      case 5:
        return Governate();
      default:
        return PriceView();
    }
  }

  Widget NumberView() {
    return ListView.builder(
      itemCount: getNumberTypeResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedGetNumberTypeResultForVehicleNumberFilter ==
                          getNumberTypeResult[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getNumberTypeResult[index],
              groupValue: selectedGetNumberTypeResultForVehicleNumberFilter,
              onChanged: (value) {
                setState(() {
                  selectedGetNumberTypeResultForVehicleNumberFilter = value;
                });
              },
            ),
            title: Text('${getNumberTypeResult[index].vehiclesNumberTypeName}'),
            onTap: () {
              setState(() {
                selectedGetNumberTypeResultForVehicleNumberFilter =
                    getNumberTypeResult[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget LetterView() {
    return ListView.builder(
      itemCount: getLettersFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedGetLettersFilterResultForVehicleNumberFilter ==
                          getLettersFilterResult[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getLettersFilterResult[index],
              groupValue: selectedGetLettersFilterResultForVehicleNumberFilter,
              onChanged: (value) {
                setState(() {
                  selectedGetLettersFilterResultForVehicleNumberFilter = value;
                });
              },
            ),
            title: Text(
                '${getLettersFilterResult[index].letterNameEnglish} ${getLettersFilterResult[index].letterNameArabic}'),
            onTap: () {
              setState(() {
                selectedGetLettersFilterResultForVehicleNumberFilter =
                    getLettersFilterResult[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget LetterCountView() {
    return ListView.builder(
      itemCount: letterCountList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedLetterCountListForVehicleNumberFilter ==
                          letterCountList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: letterCountList[index],
              groupValue: selectedLetterCountListForVehicleNumberFilter,
              onChanged: (value) {
                setState(() {
                  selectedLetterCountListForVehicleNumberFilter = value;
                });
              },
            ),
            title: Text('${letterCountList[index]}'),
            onTap: () {
              setState(() {
                selectedLetterCountListForVehicleNumberFilter =
                    letterCountList[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget PlateTypeView() {
    return ListView.builder(
      itemCount: getPlateTypesFilterResult.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color:
                      selectedGetPlateTypesFilterResultForVehicleNumberFilter ==
                              getPlateTypesFilterResult[index]
                          ? MyColors.primaryColor
                          : Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: getPlateTypesFilterResult[index],
              groupValue:
                  selectedGetPlateTypesFilterResultForVehicleNumberFilter,
              onChanged: (value) {
                setState(() {
                  selectedGetPlateTypesFilterResultForVehicleNumberFilter =
                      value;
                });
              },
            ),
            title: Text('${getPlateTypesFilterResult[index].plateTypeName}'),
            onTap: () {
              setState(() {
                selectedGetPlateTypesFilterResultForVehicleNumberFilter =
                    getPlateTypesFilterResult[index];
              });
            },
          ),
        ),
      ),
    );
  }

  Widget TransferTypeView() {
    return ListView.builder(
      itemCount: transferTypeList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedTransferTypeForVehicleNumberFilter ==
                          transferTypeList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: transferTypeList[index],
              groupValue: selectedTransferTypeForVehicleNumberFilter,
              onChanged: (value) {
                setState(() {
                  selectedTransferTypeForVehicleNumberFilter = value;
                });
              },
            ),
            title: Text('${transferTypeList[index]['type']}'),
            onTap: () {
              setState(() {
                selectedTransferTypeForVehicleNumberFilter =
                    transferTypeList[index];
              });
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
                              selectedGetGovernorateFilterResultForVehicleNumberFilter ==
                                      governateList[index]
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index],
                      groupValue:
                          selectedGetGovernorateFilterResultForVehicleNumberFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedGetGovernorateFilterResultForVehicleNumberFilter =
                              value;
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        selectedGetGovernorateFilterResultForVehicleNumberFilter =
                            governateList[index];
                      });
                    },
                  )),
            ));
  }

/*
  Widget State() {
    return ListView.builder(
        itemCount: stateList.length,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedStateForVehicleNumberFilter ==
                                  stateList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index],
                      groupValue: selectedStateForVehicleNumberFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedStateForVehicleNumberFilter = value;
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        selectedStateForVehicleNumberFilter = stateList[index];
                      });
                    },
                  )),
            ));
  }*/

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
