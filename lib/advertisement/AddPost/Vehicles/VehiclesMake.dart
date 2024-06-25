import 'dart:io';
import 'package:ealaa_userr/Model/GeneralModel.dart';
import 'package:ealaa_userr/Model/advertisement_model/VehiclesMakeModel.dart';
import 'package:ealaa_userr/advertisement/ad_bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../Model/advertisement_model/AddPostModel.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CommonMethods.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/GlobalData.dart';
import '../../../View/Utils/webService.dart';
import '../../../common/common_widgets.dart';

class VehiclesMake extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;

  const VehiclesMake(
      {super.key,
      required this.adType,
      required this.advertisement_category_id,
      required this.advertisement_sub_category_id});

  @override
  State<VehiclesMake> createState() => _VehiclesMakeState();
}

class _VehiclesMakeState extends State<VehiclesMake> {
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
    'Drivertrain',
    'Seats',
    'Plate',
    'Origin',
    'Governate',
    'State',
    'Upload Photos',
    'Additional Details'
  ];
  String title = "Make";
  List<VehiclesMakeResult> makeList = [];
  List<Model> modelList = [];
  List<ModelTrim> trimList = [];
  List<int> yearList = [];
  List<String> conditionList = [];
  List<String> engineList = [];
  List<int> doorList = [];
  List<String> exteriorColorList = [];
  List<String> interiorColorList = [];
  List<int> cylindersList = [];
  List<String> fuelList = [];
  List<String> transmissionList = [];
  List<String> driverTrainList = [];
  List<int> seatsList = [];
  List<String> plateList = [];
  List<String> originList = [];
  List<String> governateList = [];
  List<String> stateList = [];

  VehiclesMakeResult? selectedMake;
  Model? selectedModel;
  ModelTrim? selectedTrim;
  int? selectedYear;
  String? selectedCondition;
  String? selectedEngine;
  int? selectedDoor;
  String? selectedExteriorColor;
  String? selectedInteriorColor;
  int? selectedCylinder;
  String? selectedFuel;
  String? selectedTransmission;
  String? selectedDriverTrain;
  int? selectedSeat;
  String? selectedPlate;
  String? selectedOrigin;
  String? selectedGovernate;
  String? selectedState;
  String? selectedImage;

  bool loader = false;
  final imgPicker = ImagePicker();
  File? productPicture;
  TextEditingController price = TextEditingController();
  TextEditingController distance = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController description = TextEditingController();

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

  getMakes() async {
    var res = await Webservices.getMap(
        "$get_maker_model?category_id=${widget.advertisement_category_id}");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehiclesMakeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      makeList = resdata.result!;
      // title = _getTitleForIndex(_currentStepIndex);
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

  PostVehicleAd() async {
    Map<String, dynamic> data = {
      'category_id': widget.advertisement_category_id,
      'vehicle_ads_sub_category': widget.advertisement_sub_category_id,
      'vehicle_ads_detail_user_id': userId,
      'vehicle_ads_detail_maker_id': selectedMake?.id ?? "",
      'vehicle_ads_detail_model_id': selectedModel?.id ?? "",
      'vehicle_ads_detail_model_trim_id': selectedTrim?.id ?? "",
      'vehicle_ads_detail_year': selectedYear.toString(),
      'vehicle_ads_detail_condition': selectedCondition,
      'vehicle_ads_detail_engine_size': selectedEngine,
      'vehicle_ads_detail_doors': selectedDoor.toString(),
      'vehicle_ads_detail_exterior_color': selectedExteriorColor,
      'vehicle_ads_detail_interior_color': selectedInteriorColor,
      'vehicle_ads_detail_cylinders': selectedCylinder.toString(),
      'vehicle_ads_detail_fuel': selectedFuel,
      'vehicle_ads_detail_transmission': selectedTransmission,
      'vehicle_ads_detail_drive_train': selectedDriverTrain,
      'vehicle_ads_detail_plate': selectedPlate,
      'vehicle_ads_detail_origin': selectedOrigin,
      'vehicle_ads_detail_governate': selectedGovernate,
      'vehicle_ads_detail_state': selectedState,
      'vehicle_ads_additional_detail_price': price.text.toString(),
      'vehicle_ads_additional_detail_distance_travelled':
          distance.text.toString(),
      'vehicle_ads_additional_detail_phone': phone.text.toString(),
      'vehicle_ads_additional_detail_description': description.text.toString(),
    };
    Map<String, dynamic> files = {'vehicle_ads_upload_image': productPicture};
    print("request ------------------$data   $files");
    loader = true;
    setState(() {});
    var res = await Webservices.postDataWithImageFunction(
        body: data,
        files: files,
        context: context,
        apiUrl:
            widget.adType == 'sell' ? upload_vehicle_sell : upload_vehicle_buy);
    loader = false;
    setState(() {});
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
            if (_currentStepIndex > 0) {
              _currentStepIndex--;
              title = topList[_currentStepIndex];
              setState(() {});
            } else {
              Navigator.pop(context);
            }
            _scrollToNextStep();
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
              : NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      expandedHeight: 100,
                      flexibleSpace: FlexibleSpaceBar(
                        background: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                            child: Row(
                              children: List.generate(topList.length, (index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Divider(
                                      height: 10,
                                      color: Colors.grey,
                                    ),
                                    _currentStepIndex <= index
                                        ? SvgPicture.asset(
                                            "assets/images/card_grey.svg",
                                            height: 40,
                                          )
                                        : _currentStepIndex == index + 1
                                            ? SvgPicture.asset(
                                                'assets/images/card_blue.svg',
                                                height: 45,
                                              )
                                            : SvgPicture.asset(
                                                'assets/images/card_green.svg',
                                                height: 45,
                                              ),
                                    // Container(
                                    //   width: 15,
                                    //   height: 15,
                                    //   decoration: BoxDecoration(
                                    //     borderRadius: BorderRadius.circular(10),
                                    //     color: _currentStepIndex <= index
                                    //         ? Colors.grey
                                    //         : _currentStepIndex == index + 1
                                    //             ? Colors.blue
                                    //             : Colors.green,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              topList[index],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color:
                                                      _currentStepIndex <= index
                                                          ? Colors.grey
                                                          : Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              _getSelectedValueForIndex(index),
                                              style: TextStyle(
                                                fontSize: 13,
                                                color:
                                                    _currentStepIndex <= index
                                                        ? Colors.grey
                                                        : Colors.black,
                                              ),
                                            ),
                                            //
                                            // Text(
                                            //   selectedMake?.name ?? "",
                                            //   style: TextStyle(
                                            //     fontSize: 13,
                                            //     color:
                                            //         _currentStepIndex <= index
                                            //             ? Colors.grey
                                            //             : Colors.black,
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      margin: EdgeInsets.only(right: 15),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                  body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        height: MediaQuery.of(context).size.height - 200,
                        child: tabsScreens(_currentStepIndex)),
                  ),
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
          crossAxisCount: 3, mainAxisExtent: 100, mainAxisSpacing: 5),
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
          child: Container(
            height: 45,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            // padding: const EdgeInsets.only(
            //     left: 3, right: 3, top: 5, bottom: 5),
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: selectedMake == makeList[index]
                              ? Colors.blueAccent
                              : AppColors.grey)),
                  width: 100, // Set the width of the image here
                  height: 60,
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: CachedNetworkImage(
                        imageUrl: makeList[index].image ?? '',
                        height: 40,
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
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  makeList[index].name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: selectedMake == makeList[index]
                          ? Colors.blueAccent
                          : AppColors.grey),
                  maxLines: 1,
                  textAlign: TextAlign.center,
                )
              ],
            ),
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
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: modelList[index],
                title: Text('${modelList[index].name}'),
                groupValue: selectedModel,
                onChanged: (Model? value) {
                  _currentStepIndex = 3;
                  selectedModel = value;
                  trimList = modelList[index].modelTrim ?? [];
                  print("bsbd...$_currentStepIndex");
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Trim() {
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
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: yearList[index],
                title: Text('${yearList[index]}'),
                groupValue: selectedYear,
                onChanged: (int? value) {
                  _currentStepIndex = 5;
                  selectedYear = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);

                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Condition() {
    return ListView.builder(
        itemCount: conditionList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: conditionList[index],
                title: Text('${conditionList[index]}'),
                groupValue: selectedCondition,
                onChanged: (String? value) {
                  _currentStepIndex = 6;
                  selectedCondition = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget EngineSize() {
    return ListView.builder(
        itemCount: engineList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: engineList[index],
                title: Text('${engineList[index]}'),
                groupValue: selectedEngine,
                onChanged: (String? value) {
                  _currentStepIndex = 7;
                  selectedEngine = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Door() {
    return ListView.builder(
        itemCount: doorList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: doorList[index],
                title: Text('${doorList[index]}'),
                groupValue: selectedDoor,
                onChanged: (int? value) {
                  _currentStepIndex = 8;
                  selectedDoor = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget ExteriorColor() {
    return ListView.builder(
        itemCount: exteriorColorList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: exteriorColorList[index],
                title: Text('${exteriorColorList[index]}'),
                groupValue: selectedExteriorColor,
                onChanged: (String? value) {
                  _currentStepIndex = 9;
                  selectedExteriorColor = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget InteriorColor() {
    return ListView.builder(
        itemCount: interiorColorList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: interiorColorList[index],
                title: Text('${interiorColorList[index]}'),
                groupValue: selectedInteriorColor,
                onChanged: (String? value) {
                  _currentStepIndex = 10;
                  selectedInteriorColor = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Cylinders() {
    return ListView.builder(
        itemCount: cylindersList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: cylindersList[index],
                title: Text('${cylindersList[index]}'),
                groupValue: selectedCylinder,
                onChanged: (int? value) {
                  _currentStepIndex = 11;
                  selectedCylinder = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Fuel() {
    return ListView.builder(
        itemCount: fuelList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: fuelList[index],
                title: Text('${fuelList[index]}'),
                groupValue: selectedFuel,
                onChanged: (String? value) {
                  _currentStepIndex = 12;
                  selectedFuel = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Transmission() {
    return ListView.builder(
        itemCount: transmissionList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: transmissionList[index],
                title: Text('${transmissionList[index]}'),
                groupValue: selectedTransmission,
                onChanged: (String? value) {
                  _currentStepIndex = 13;
                  selectedTransmission = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget DriverTrain() {
    return ListView.builder(
        itemCount: driverTrainList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: driverTrainList[index],
                title: Text('${driverTrainList[index]}'),
                groupValue: selectedDriverTrain,
                onChanged: (String? value) {
                  _currentStepIndex = 14;
                  selectedDriverTrain = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Seats() {
    return ListView.builder(
        itemCount: seatsList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: seatsList[index],
                title: Text('${seatsList[index]}'),
                groupValue: selectedSeat,
                onChanged: (int? value) {
                  _currentStepIndex = 15;
                  selectedSeat = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Plate() {
    return ListView.builder(
        itemCount: plateList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: plateList[index],
                title: Text('${plateList[index]}'),
                groupValue: selectedPlate,
                onChanged: (String? value) {
                  _currentStepIndex = 16;
                  selectedPlate = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Origin() {
    return ListView.builder(
        itemCount: originList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: originList[index],
                title: Text('${originList[index]}'),
                groupValue: selectedOrigin,
                onChanged: (String? value) {
                  _currentStepIndex = 17;
                  selectedOrigin = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Governate() {
    return ListView.builder(
        itemCount: governateList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: governateList[index],
                title: Text('${governateList[index]}'),
                groupValue: selectedGovernate,
                onChanged: (String? value) {
                  _currentStepIndex = 18;
                  selectedGovernate = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget State() {
    return ListView.builder(
        itemCount: stateList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: stateList[index],
                title: Text('${stateList[index]}'),
                groupValue: selectedState,
                onChanged: (String? value) {
                  _currentStepIndex = 19;
                  selectedState = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget UploadPhotos() {
    return Column(
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
                    ? Center(child: uploadProductContainer())
                    : Center(child: displayImage())),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        RoundButton(
          height: 45,
          borderRadius: 10,
          title: 'Complete the final step',
          onTap: () {
            if (productPicture != null) {
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
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Price",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                commonTextFormField(
                  controller: price,
                  hintText: 'Enter Price',
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Distance Travelled",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                commonTextFormField(
                  controller: distance,
                  hintText: 'Enter Distance',
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Phone",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                commonTextFormField(
                  controller: phone,
                  hintText: 'Enter Phone',
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                commonTextFormField(
                  maxLines: null,
                  controller: description,
                  hintText: 'Enter Description',
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          RoundButton(
            loading: loader,
            height: 45,
            borderRadius: 10,
            title: 'All Set! Publish your Ad',
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
        return selectedYear?.toString() ?? "";
      case 4:
        return selectedCondition ?? "";
      case 5:
        return selectedEngine ?? "";
      case 6:
        return selectedDoor?.toString() ?? "";
      case 7:
        return selectedExteriorColor ?? "";
      case 8:
        return selectedInteriorColor ?? "";
      case 9:
        return selectedCylinder?.toString() ?? "";
      case 10:
        return selectedFuel ?? "";
      case 11:
        return selectedTransmission ?? "";
      case 12:
        return selectedDriverTrain ?? "";
      case 13:
        return selectedSeat?.toString() ?? "";
      case 14:
        return selectedPlate?.toString() ?? "";
      case 15:
        return selectedOrigin ?? "";
      case 16:
        return selectedGovernate ?? "";
      case 17:
        return selectedState ?? "";
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
            height: 150,
            width: 150,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ));
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
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                MyImages.add,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ParagraphText(
                  text: "Tap here to add a photo",
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
