import 'dart:io';

import 'package:ealaa_userr/Model/GeneralModel.dart';
import 'package:ealaa_userr/Model/advertisement_model/VehiclesMakeModel.dart';
import 'package:ealaa_userr/Model/advertisement_model/get_ads_with_category_home_model.dart';
import 'package:ealaa_userr/advertisement/ad_bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';

class UpdateVehiclesMake extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  final String ads_post_id;

  const UpdateVehiclesMake({
    super.key,
    required this.adType,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id,
    required this.ads_post_id,
  });

  @override
  State<UpdateVehiclesMake> createState() => _UpdateVehiclesMakeState();
}

class _UpdateVehiclesMakeState extends State<UpdateVehiclesMake> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
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
    'Upload Photos',
    'Additional Details'
  ];

  String title = "Make";
  List<VehiclesMakeResult> makeList = [];
  List<Model> modelList = [];
  List<ModelTrim> trimList = [];
  List<YearModelForIdName> yearList = [];
  List<IdNameModel> conditionList = [];
  List<IdNameModel> engineList = [];
  List<IdNameModel> doorList = [];
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
  Model? selectedModel;
  ModelTrim? selectedTrim;
  YearModelForIdName? selectedYear;
  IdNameModel? selectedCondition;
  IdNameModel? selectedEngine;
  IdNameModel? selectedDoor;
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
  final imgPicker = ImagePicker();
  File? productPicture;
  TextEditingController price = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();

  PostListDetails? result;

  String selectedDis = 'Miles';

  void _scrollToNextStep() {
    if (_currentStepIndex < topList.length) {
      double screenWidth = MediaQuery.of(context).size.width;
      double itemWidth = 110.0; // Assuming each item's width is 110.0
      double offset =
          (_currentStepIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      double maxScrollExtent = _scrollController.position.maxScrollExtent;
      offset = offset.clamp(0.0, maxScrollExtent);
      _scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  getMakes() async {
    var res = await Webservices.getMap(
        "$get_maker_model?sub_category_id=${widget.advertisement_sub_category_id}");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehiclesMakeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      makeList = resdata.result!;
      setState(() {});
      getAdsPostDetails();
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getAdsPostDetails() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_ads_post_details?ads_post=${widget.adType}&ads_post_id=${widget.ads_post_id}&user_id=$userId");
    showProgressBar = false;
    GetAdsPostDetailsModel getAdsPostDetailsModel =
        GetAdsPostDetailsModel.fromJson(res);
    setState(() {});
    if (getAdsPostDetailsModel.result != null) {
      result = getAdsPostDetailsModel.result!;
      setState(() {});
      price.text = result?.vehicleAdsAdditionalDetailPrice ?? '';
      distance.text = result?.vehicleAdsAdditionalDetailDistanceTravelled ?? '';
      phone.text = result?.vehicleAdsAdditionalDetailPhone ?? '';
      description.text = result?.vehicleAdsAdditionalDetailDescription ?? '';
      if (makeList.isNotEmpty) {
        makeList.forEach((element) {
          ///TODO DONE
          if (element.id == result?.vehicleAdsDetailMakerId) {
            selectedMake = element;
            setState(() {});
          }
          ///TODO DONE
          if (element.model != null && element.model!.isNotEmpty) {
            element.model?.forEach((elementModel) {
              if (elementModel.id == result?.vehicleAdsDetailModelId) {
                selectedModel = elementModel;
                setState(() {});
                selectedModel?.modelTrim?.forEach((elementModelTrim) {
                  if (elementModelTrim.id ==
                      result?.vehicleAdsDetailModelTrimId) {
                    selectedTrim = elementModelTrim;
                    setState(() {});
                  }
                });
              }
            });
          }
          ///TODO DONE
          if (element.year != null && element.year!.isNotEmpty) {
            element.year?.forEach((elementYear) {
              if (elementYear.year == result?.vehicleAdsDetailYear) {
                selectedYear = elementYear;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.condition != null && element.condition!.isNotEmpty) {
            element.condition?.forEach((elementCondition) {
              if (elementCondition.name == result?.vehicleAdsDetailCondition) {
                selectedCondition = elementCondition;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.engineSize != null && element.engineSize!.isNotEmpty) {
            element.engineSize?.forEach((elementEngineSize) {
              if (elementEngineSize.name ==
                  result?.vehicleAdsDetailEngineSize) {
                selectedEngine = elementEngineSize;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.doors != null && element.doors!.isNotEmpty) {
            element.doors?.forEach((elementDoors) {
              if (elementDoors.name == result?.vehicleAdsDetailDoors) {
                selectedDoor = elementDoors;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.exteriorColor != null &&
              element.exteriorColor!.isNotEmpty) {
            element.exteriorColor?.forEach((elementExteriorColor) {
              if (elementExteriorColor.name ==
                  result?.vehicleAdsDetailExteriorColor) {
                selectedExteriorColor = elementExteriorColor;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.interiorColor != null &&
              element.interiorColor!.isNotEmpty) {
            element.interiorColor?.forEach((elementInteriorColor) {
              if (elementInteriorColor.name ==
                  result?.vehicleAdsDetailInteriorColor) {
                selectedInteriorColor = elementInteriorColor;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.cylinders != null && element.cylinders!.isNotEmpty) {
            element.cylinders?.forEach((elementCylinders) {
              if (elementCylinders.name == result?.vehicleAdsDetailCylinders) {
                selectedCylinder = elementCylinders;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.fuel != null && element.fuel!.isNotEmpty) {
            element.fuel?.forEach((elementFuel) {
              if (elementFuel.name == result?.vehicleAdsDetailFuel) {
                selectedFuel = elementFuel;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.transmission != null &&
              element.transmission!.isNotEmpty) {
            element.transmission?.forEach((elementTrasmission) {
              if (elementTrasmission.name ==
                  result?.vehicleAdsDetailTransmission) {
                selectedTransmission = elementTrasmission;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.drivetrain != null && element.drivetrain!.isNotEmpty) {
            element.drivetrain?.forEach((elementDrivetrain) {
              if (elementDrivetrain.name ==
                  result?.vehicleAdsDetailDriveTrain) {
                selectedDriverTrain = elementDrivetrain;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.seats != null && element.seats!.isNotEmpty) {
            element.seats?.forEach((elementSeats) {
              if (elementSeats.name == result?.vehicleAdsDetailSeats) {
                selectedSeat = elementSeats;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.state != null && element.state!.isNotEmpty) {
            element.state?.forEach((elementState) {
              if (elementState.stateName == result?.vehicleAdsDetailState) {
                selectedState = elementState;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.plate != null && element.plate!.isNotEmpty) {
            element.plate?.forEach((elementPlate) {
              if (elementPlate.name == result?.vehicleAdsDetailPlate) {
                selectedPlate = elementPlate;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.origin != null && element.origin!.isNotEmpty) {
            element.origin?.forEach((elementOrigin) {
              if (elementOrigin.name == result?.vehicleAdsDetailOrigin) {
                selectedOrigin = elementOrigin;
                setState(() {});
              }
            });
          }
          ///TODO DONE
          if (element.governate != null && element.governate!.isNotEmpty) {
            element.governate?.forEach((elementGovernorate) {
              if (elementGovernorate.name ==
                  result?.vehicleAdsDetailGovernate) {
                selectedGovernate = elementGovernorate;
                setState(() {});
              }
            });
          }
        });
      }
      setState(() {});
    } else {
      showSnackbar(context, 'Something went wrong!');
      showProgressBar = false;
      setState(() {});
    }
  }

  String _getTitleForIndex(int index) {
    if (index == 1 || index < topList.length) {
      return topList[index];
    } else {
      return ""; // Handle out of bounds index gracefully
    }
  }

  PostVehicleAd() async {
    Map<String, dynamic> data;
    var res;
     if(productPicture!=null){
       data = {
         'category_id': widget.advertisement_category_id,
         'sub_category_id': widget.advertisement_sub_category_id,
         'vehicle_ads_detail_id': result?.vehicleAdsDetailId ?? '',
         'vehicle_ads_detail_user_id': userId,
         'vehicle_ads_detail_maker_id': selectedMake?.id ?? "",
         'vehicle_ads_detail_model_id': selectedModel?.id ?? "",
         'vehicle_ads_detail_model_trim_id': selectedTrim?.id ?? "",
         'vehicle_ads_detail_year': selectedYear?.year ?? '',
         'vehicle_ads_detail_condition': selectedCondition?.name ?? '',
         'vehicle_ads_detail_engine_size': selectedEngine?.name ?? '',
         'vehicle_ads_detail_doors': selectedDoor?.name ?? '',
         'vehicle_ads_detail_exterior_color': selectedExteriorColor?.name ?? '',
         'vehicle_ads_detail_interior_color': selectedInteriorColor?.name ?? '',
         'vehicle_ads_detail_cylinders': selectedCylinder?.name ?? '',
         'vehicle_ads_detail_fuel': selectedFuel?.name ?? '',
         'vehicle_ads_detail_transmission': selectedTransmission?.name ?? '',
         'vehicle_ads_detail_drive_train': selectedDriverTrain?.name ?? '',
         'vehicle_ads_detail_plate': selectedPlate?.name ?? '',
         'vehicle_ads_detail_origin': selectedOrigin?.name ?? '',
         'vehicle_ads_detail_governate': selectedGovernate?.name ?? '',
         'vehicle_ads_detail_state': selectedState?.stateName ?? '',
         'vehicle_ads_detail_seats': selectedSeat?.name ?? '',
         'vehicle_ads_additional_detail_price': price.text,
         'vehicle_ads_additional_detail_distance_travelled': distance.text,
         'vehicle_ads_additional_miles_kilometer': selectedDis,
         'vehicle_ads_additional_detail_phone': phone.text,
         'vehicle_ads_additional_detail_description': description.text,
       };
       Map<String, dynamic> files = {'vehicle_ads_upload_image': productPicture ?? ''};
       print("request ------------------$data   $files");
       loader = true;
       setState(() {});
       res = await Webservices.postDataWithImageFunction(
           body: data,
           files: files,
           context: context,
           apiUrl:
           /*widget.adType == 'sell' ?*/ edit_vehicle_sell /*: edit_vehicle_buy*/);
       loader = false;
       setState(() {});
     }
     else{
       data = {
         'vehicle_ads_upload_image': '',
         'category_id': widget.advertisement_category_id,
         'sub_category_id': widget.advertisement_sub_category_id,
         'vehicle_ads_detail_id': result?.vehicleAdsDetailId ?? '',
         'vehicle_ads_detail_user_id': userId,
         'vehicle_ads_detail_maker_id': selectedMake?.id ?? "",
         'vehicle_ads_detail_model_id': selectedModel?.id ?? "",
         'vehicle_ads_detail_model_trim_id': selectedTrim?.id ?? "",
         'vehicle_ads_detail_year': selectedYear?.year ?? '',
         'vehicle_ads_detail_condition': selectedCondition?.name ?? '',
         'vehicle_ads_detail_engine_size': selectedEngine?.name ?? '',
         'vehicle_ads_detail_doors': selectedDoor?.name ?? '',
         'vehicle_ads_detail_exterior_color': selectedExteriorColor?.name ?? '',
         'vehicle_ads_detail_interior_color': selectedInteriorColor?.name ?? '',
         'vehicle_ads_detail_cylinders': selectedCylinder?.name ?? '',
         'vehicle_ads_detail_fuel': selectedFuel?.name ?? '',
         'vehicle_ads_detail_transmission': selectedTransmission?.name ?? '',
         'vehicle_ads_detail_drive_train': selectedDriverTrain?.name ?? '',
         'vehicle_ads_detail_plate': selectedPlate?.name ?? '',
         'vehicle_ads_detail_origin': selectedOrigin?.name ?? '',
         'vehicle_ads_detail_governate': selectedGovernate?.name ?? '',
         'vehicle_ads_detail_state': selectedState?.stateName ?? '',
         'vehicle_ads_detail_seats': selectedSeat?.name ?? '',
         'vehicle_ads_additional_detail_price': price.text,
         'vehicle_ads_additional_detail_distance_travelled': distance.text,
         'vehicle_ads_additional_miles_kilometer': selectedDis,
         'vehicle_ads_additional_detail_phone': phone.text,
         'vehicle_ads_additional_detail_description': description.text,
       };
       print("request ------------------$data");
       loader = true;
       setState(() {});
       res = await Webservices.postData(
           body: data,
           context: context,
           apiUrl:
           /*widget.adType == 'sell' ?*/ edit_vehicle_sell /*: edit_vehicle_buy*/);
       loader = false;
       setState(() {});
     }
    final resdata = GeneralModel.fromJson(res);
    if (res['status'] == "1") {
      showSnackbar(context, resdata.message!);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdBottomBar(),
          ));
    } else {
      showSnackbar(context, resdata.message!);
    }
  }

  @override
  void initState() {
    getMakes();
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
              title = topList[_currentStepIndex];
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
          : makeList.isEmpty
              ? Image.asset("assets/images/NoDataFound.png")
              : Column(
                  children: [
                    SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                        child: Row(
                          children: List.generate(topList.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /* _currentStepIndex <= index
                                    ? SvgPicture.asset(
                                        "assets/images/card_grey.svg",
                                        height: 40,
                                      )
                                    : _currentStepIndex == index + 1
                                        ? SvgPicture.asset(
                                            'assets/images/card_orange.svg',
                                            height: 45,
                                          )
                                        : SvgPicture.asset(
                                            'assets/images/card_green.svg',
                                            height: 45,
                                          ),*/
                                _currentStepIndex <= index
                                    ? Image.asset(
                                        'assets/icons/ic_card.png',
                                        height: 28,
                                        width: 28,
                                      )
                                    : _currentStepIndex == index + 1
                                        ? Image.asset(
                                            'assets/icons/ic_card_orange.png',
                                            height: 40,
                                            width: 40,
                                          )
                                        : Image.asset(
                                            'assets/icons/ic_card_green.png',
                                            height: 40,
                                            width: 40,
                                          ),
                                SizedBox(width: 14),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      topList[index],
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: _currentStepIndex <= index
                                              ? Colors.grey
                                              : Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    if (_getSelectedValueForIndex(index)
                                        .isNotEmpty)
                                      Text(
                                        _getSelectedValueForIndex(index),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _currentStepIndex <= index
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(width: 7),
                                if (index != topList.length - 1)
                                  SizedBox(
                                      width: 20,
                                      child: Divider(
                                        color: Colors.grey.withOpacity(.2),
                                        thickness: 2,
                                      )),
                                if (index != topList.length - 1)
                                  SizedBox(width: 7),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
      case 19:
        return UploadPhotos();
      case 20:
        return AdditionalDetails();
      default:
        return Make();
    }
  }

  Widget Make() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
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
            modelList = makeList[index].model ?? [];
            yearList = makeList[index].year ?? [];
            conditionList = makeList[index].condition ?? [];
            engineList = makeList[index].engineSize ?? [];
            doorList = makeList[index].doors ?? [];
            exteriorColorList = makeList[index].exteriorColor ?? [];
            interiorColorList = makeList[index].interiorColor ?? [];
            cylindersList = makeList[index].cylinders ?? [];
            fuelList = makeList[index].fuel ?? [];
            transmissionList = makeList[index].transmission ?? [];
            driverTrainList = makeList[index].drivetrain ?? [];
            seatsList = makeList[index].seats ?? [];
            plateList = makeList[index].plate ?? [];
            originList = makeList[index].origin ?? [];
            governateList = makeList[index].governate ?? [];
            stateList = makeList[index].state ?? [];
            _currentStepIndex = 2;
            title = _getTitleForIndex(_currentStepIndex - 1);
            _scrollToNextStep();
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
        itemBuilder: (context, index) => Container(
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
                    _currentStepIndex = 3;
                    selectedModel = value;
                    trimList = modelList[index].modelTrim ?? [];
                    title = _getTitleForIndex(_currentStepIndex - 1);
                    _scrollToNextStep();
                  });
                },
              ),
              title: Text('${modelList[index].name}'),
              onTap: () {
                setState(() {
                  _currentStepIndex = 3;
                  selectedModel = modelList[index];
                  trimList = modelList[index].modelTrim ?? [];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                });
              },
            )));
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
                          _currentStepIndex = 4;
                          selectedTrim = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${trimList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 4;
                        selectedTrim = trimList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
                      });
                    },
                  )),
            ));

    return ListView.builder(
        itemCount: trimList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: trimList[index],
                title: Text('${trimList[index].name}'),
                groupValue: selectedTrim,
                onFocusChange: (value) {
                  print("gdhjsgj...$value");
                },
                onChanged: (ModelTrim? value) {
                  _currentStepIndex = 4;
                  selectedTrim = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
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
                          color: selectedYear?.id == yearList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: yearList[index].id,
                      groupValue: selectedYear?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 5;
                          selectedYear = yearList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${yearList[index].year}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 5;
                        selectedYear = yearList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                              selectedCondition?.id == conditionList[index].id
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: conditionList[index].id,
                      groupValue: selectedCondition?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 6;
                          selectedCondition = conditionList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${conditionList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 6;
                        selectedCondition = conditionList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedEngine?.id == engineList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: engineList[index].id,
                      groupValue: selectedEngine?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 7;
                          selectedEngine = engineList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${engineList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 7;
                        selectedEngine = engineList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                    color: selectedDoor?.id == doorList[index].id
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: doorList[index].id,
                groupValue: selectedDoor?.id,
                onChanged: (value) {
                  setState(() {
                    _currentStepIndex = 8;
                    selectedDoor = doorList[index];
                    title = _getTitleForIndex(_currentStepIndex - 1);
                    _scrollToNextStep();
                  });
                },
              ),
              title: Text('${doorList[index].name}'),
              onTap: () {
                setState(() {
                  _currentStepIndex = 8;
                  selectedDoor = doorList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                });
              },
            )),
      ),
    );
  }

  Widget ExteriorColor() {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: exteriorColorList.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            _currentStepIndex = 9;
            selectedExteriorColor = exteriorColorList[index];
            title = _getTitleForIndex(_currentStepIndex - 1);
            _scrollToNextStep();
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
                        selectedExteriorColor?.id == exteriorColorList[index].id
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
              if (selectedExteriorColor?.id == exteriorColorList[index].id)
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
                          _currentStepIndex = 9;
                          selectedExteriorColor = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${exteriorColorList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 9;
                        selectedExteriorColor = exteriorColorList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisExtent: 80,
          mainAxisSpacing: 5,
          crossAxisSpacing: 10),
      itemCount: interiorColorList.length,
      itemBuilder: (context, int index) {
        return GestureDetector(
          onTap: () {
            _currentStepIndex = 10;
            selectedInteriorColor = interiorColorList[index];
            title = _getTitleForIndex(_currentStepIndex - 1);
            _scrollToNextStep();
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
                        selectedInteriorColor?.id == interiorColorList[index].id
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
              if (selectedInteriorColor?.id == interiorColorList[index].id)
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
                          _currentStepIndex = 10;
                          selectedInteriorColor = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${interiorColorList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 10;
                        selectedInteriorColor = interiorColorList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                  color: selectedCylinder?.id == cylindersList[index].id
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: cylindersList[index].id,
              groupValue: selectedCylinder?.id,
              onChanged: (value) {
                setState(() {
                  _currentStepIndex = 11;
                  selectedCylinder = cylindersList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                });
              },
            ),
            title: Text('${cylindersList[index].name}'),
            onTap: () {
              setState(() {
                _currentStepIndex = 11;
                selectedCylinder = cylindersList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
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
                        color: selectedFuel?.id == fuelList[index].id
                            ? MyColors.primaryColor
                            : Colors.grey.withOpacity(0.5)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: fuelList[index].id,
                      groupValue: selectedFuel?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 12;
                          selectedFuel = fuelList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${fuelList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 12;
                        selectedFuel = fuelList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedTransmission?.id ==
                                  transmissionList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: transmissionList[index].id,
                      groupValue: selectedTransmission?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 13;
                          selectedTransmission = transmissionList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${transmissionList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 13;
                        selectedTransmission = transmissionList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedDriverTrain?.id ==
                                  driverTrainList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: driverTrainList[index].id,
                      groupValue: selectedDriverTrain?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 14;
                          selectedDriverTrain = driverTrainList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${driverTrainList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 14;
                        selectedDriverTrain = driverTrainList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedSeat?.id == seatsList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: seatsList[index].id,
                      groupValue: selectedSeat?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 15;
                          selectedSeat = seatsList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${seatsList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 15;
                        selectedSeat = seatsList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedPlate?.id == plateList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: plateList[index].id,
                      groupValue: selectedPlate?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 16;
                          selectedPlate = plateList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${plateList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 16;
                        selectedPlate = plateList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                          color: selectedOrigin?.id == originList[index].id
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: originList[index].id,
                      groupValue: selectedOrigin?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 17;
                          selectedOrigin = originList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${originList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 17;
                        selectedOrigin = originList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                              selectedGovernate?.id == governateList[index].id
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: governateList[index].id,
                      groupValue: selectedGovernate?.id,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 18;
                          selectedGovernate = governateList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${governateList[index].name}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 18;
                        selectedGovernate = governateList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
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
                              selectedState?.stateId == stateList[index].stateId
                                  ? MyColors.primaryColor
                                  : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: stateList[index].stateId,
                      groupValue: selectedState?.stateId,
                      onChanged: (value) {
                        setState(() {
                          _currentStepIndex = 19;
                          selectedState = stateList[index];
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                        });
                      },
                    ),
                    title: Text('${stateList[index].stateName}'),
                    onTap: () {
                      setState(() {
                        _currentStepIndex = 19;
                        selectedState = stateList[index];
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
                      });
                    },
                  )),
            ));
  }

  Widget UploadPhotos() {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: GestureDetector(
                onTap: () {
                  _image_camera_dialog(context);
                },
                child: productPicture == null
                    ? result?.vehicleAdsUploadImage != null &&
                            result!.vehicleAdsUploadImage!.isNotEmpty
                        ? Center(child: displayImageNetwork())
                        : Center(child: uploadProductContainer())
                    : Center(child: displayImage())),
          ),
        ),
        SizedBox(height: 20),
        RoundButton(
          height: 45,
          borderRadius: 10,
          title: 'Complete the final step',
          onTap: () {
            if (productPicture != null ||
                (result != null && result!.vehicleAdsUploadImage != null)) {
              print(Uri.parse(result!.vehicleAdsUploadImage!).pathSegments.last);
              _currentStepIndex = 20;
              selectedImage = "1 image";
              title = _getTitleForIndex(_currentStepIndex - 1);
              setState(() {});
            } else {
              showSnackbar(context, "Please Add Images");
            }
          },
          fontsize: 18,
          fontweight: FontWeight.w500,
        ),
      ],
    );
  }

  Widget AdditionalDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: BoxDecoration(
                //color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Price (OMR)",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                commonTextFormField(
                  controller: price,
                  hintText: 'Enter Price in (OMR)',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Distance Travelled",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(color: Colors.grey.withOpacity(.5))),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              selectedDis = 'Miles';
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedDis == 'Miles'
                                      ? Colors.orange
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                child: Text(
                                  "Miles",
                                  style: TextStyle(
                                      color: selectedDis != 'Miles'
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedDis = 'Kilometers';
                              setState(() {});
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: selectedDis == 'Kilometers'
                                      ? Colors.orange
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: Text(
                                  "Kilometers",
                                  style: TextStyle(
                                      color: selectedDis != 'Kilometers'
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                commonTextFormField(
                  controller: distance,
                  hintText: 'Enter Distance',
                ),
                SizedBox(height: 10),
                Text(
                  "Phone",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                commonTextFormField(controller: phone, hintText: 'Enter Phone'),
                SizedBox(height: 10),
                Text(
                  "Description",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                commonTextFormField(
                  maxLines: 4,
                  controller: description,
                  hintText: 'Provide more information about your ad',
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          RoundButton(
            loading: loader,
            height: 45,
            borderRadius: 10,
            title: 'All Set! Update your Ad',
            fontsize: 18,
            fontweight: FontWeight.w500,
            onTap: () {
              if (price.text.isEmpty) {
                showSnackbar(context, "Enter price");
              } else if (distance.text.isEmpty) {
                showSnackbar(context, "Enter distance");
              } else if (phone.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else if (description.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else {
                PostVehicleAd();
              }
            },
          ),
        ],
      ),
    );
  }

  String _getSelectedValueForIndex(int index) {
    switch (index) {
      case 0:
        return selectedMake?.name ?? "";
      case 1:
        return selectedModel?.name ?? "";
      case 2:
        return selectedTrim?.name ?? "";
      case 3:
        return selectedYear?.year ?? "";
      case 4:
        return selectedCondition?.name ?? "";
      case 5:
        return selectedEngine?.name ?? "";
      case 6:
        return selectedDoor?.name ?? "";
      case 7:
        return selectedExteriorColor?.name ?? "";
      case 8:
        return selectedInteriorColor?.name ?? "";
      case 9:
        return selectedCylinder?.name ?? "";
      case 10:
        return selectedFuel?.name ?? "";
      case 11:
        return selectedTransmission?.name ?? "";
      case 12:
        return selectedDriverTrain?.name ?? "";
      case 13:
        return selectedSeat?.name ?? "";
      case 14:
        return selectedPlate?.name ?? "";
      case 15:
        return selectedOrigin?.name ?? "";
      case 16:
        return selectedGovernate?.name ?? "";
      case 17:
        return selectedState?.stateName ?? "";
      case 18:
        return selectedImage ?? "";
      default:
        return "";
    }
  }

  void openCamera() async {
    final imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
    if (imgCamera != null) {
      productPicture = await compressImage(File(imgCamera.path));
      print('store image upload by camera $productPicture');
      setState(() {});
    } else {
      print("no image is selected");
    }
  }

  void _image_camera_dialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text(
          'Select an Image',
          style: GoogleFonts.openSans(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
              onPressed: () {
                openGallery();
                Navigator.pop(context);
              },
              child: Text(
                'Select a photo from Gallery',
                style: GoogleFonts.openSans(color: Colors.grey, fontSize: 15),
              )),
          CupertinoActionSheetAction(
              onPressed: () {
                openCamera();
                Navigator.pop(context);
              },
              child: Text(
                'Take a photo with the camera',
                style: GoogleFonts.openSans(color: Colors.grey, fontSize: 15),
              )),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel',
              style: GoogleFonts.openSans(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  void openGallery() async {
    var imgGallery = await imgPicker.pickImage(
      source: ImageSource.gallery,
    );
    if (imgGallery != null) {
      productPicture = await compressImage(File(imgGallery.path));
      print('store image upload by gallery $productPicture');
      setState(() {});
    } else {
      print("no image is selected");
    }
  }

  displayImage() {
    if (productPicture != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          productPicture!,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      );
    } else {
      return Text("No file is selected");
    }
  }

  displayImageNetwork() {
    if (result!.vehicleAdsUploadImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          result!.vehicleAdsUploadImage!,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      );
    } else {
      return Text("No file is selected");
    }
  }

  uploadProductContainer() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      padding: EdgeInsets.all(6),
      dashPattern: [6, 9],
      color: MyColors.primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ParagraphText(
                  text: "Attractive photo influence 90% of buyer decisions.",
                  textAlign: TextAlign.center,
                ),
              ),
              Image.asset(
                MyImages.add,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ParagraphText(
                  text: "Click to add image from gallery and camera",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SquareRadio extends StatelessWidget {
  final Color activeColor;
  final dynamic value;
  final dynamic groupValue;
  final ValueChanged<dynamic> onChanged;

  const SquareRadio({
    required this.activeColor,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = value == groupValue;
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey,
            width: .4,
          ),
        ),
        child: isSelected
            ? Center(
                child: Icon(
                  Icons.done,
                  size: 16,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
