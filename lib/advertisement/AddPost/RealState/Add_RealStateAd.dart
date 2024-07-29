import 'dart:io';

import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/GeneralModel.dart';
import '../../../Model/advertisement_model/RealStateUseModel.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CommonMethods.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/GlobalData.dart';
import '../../../View/Utils/webService.dart';
import '../../../common/common_widgets.dart';
import '../../UpdatePosts/update_VehiclesMake.dart';
import '../../ad_bottom_bar.dart';

class AddRealStateAd extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;

  const AddRealStateAd(
      {super.key,
      required this.advertisement_category_id,
      required this.advertisement_sub_category_id,
      required this.adType});

  @override
  State<AddRealStateAd> createState() => _AddRealStateAdState();
}

class _AddRealStateAdState extends State<AddRealStateAd> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
    'Use',
    'Wall',
    'Land Type',
    'Position',
    'Parking',
    'Governorate',
    'State',
    'City',
    'Upload Photos',
    'Additional Details',
  ];
  String title = "Use";
  RealStateUseResult? realStateUseResult;
  List<UseList> useList = [];
  List<WallList> wallList = [];
  List<Landtype> landTypeList = [];
  List<PositionList> positionList = [];
  List<Parking> parkingList = [];
  List<Governorate> governateList = [];
  List<GovernorateState> stateList = [];
  List<StateCity> cityList = [];

  UseList? selectedUse;
  WallList? selectedWall;
  Landtype? selectedLandType;
  PositionList? selectedPosition;
  Parking? selectedParking;
  Governorate? selectedGovernate;
  GovernorateState? selectedState;
  StateCity? selectedCity;

  String? selectedImage;

  bool loader = false;
  final imgPicker = ImagePicker();
  File? productPicture;
  TextEditingController price = TextEditingController();
  TextEditingController landArea = TextEditingController();
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

  getListData() async {
    var res = await Webservices.getMap("$get_real_state");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = RealStateUseModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      realStateUseResult = resdata.result!;
      useList = realStateUseResult!.use ?? [];
      wallList = realStateUseResult!.Wall ?? [];
      landTypeList = realStateUseResult!.landtype ?? [];
      positionList = realStateUseResult!.position ?? [];
      parkingList = realStateUseResult!.parking ?? [];
      governateList = realStateUseResult!.governorate ?? [];
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

  PostRealStateAd() async {
    Map<String, dynamic> data = {
      'category_id': widget.advertisement_category_id,
      'sub_catgerory_id': widget.advertisement_sub_category_id,
      'real_state_ads_detail_user_id': userId,
      'real_state_ads_detail_ads_post_id': '',
      'real_state_ads_detail_use_id': selectedUse?.useId.toString() ?? "",
      'real_state_ads_detail_wall_id': selectedWall?.WallId.toString() ?? "",
      'real_state_ads_detail_landtype_id':
          selectedLandType?.landtypeId.toString() ?? "",
      'real_state_ads_detail_position_id':
          selectedPosition?.positionId.toString() ?? "",
      'real_state_ads_detail_parking_id':
          selectedParking?.parkingId.toString() ?? "",
      'real_state_ads_detail_state_id': selectedState?.stateId.toString() ?? "",
      'real_state_ads_detail_governate_id':
          selectedGovernate?.governorateId.toString() ?? "",
      'real_state_ads_additional_detail_price': price.text.toString(),
      'real_state_ads_additional_detail_land_area': landArea.text.toString(),
      'real_state_ads_additional_detail_phone': phone.text.toString(),
      'real_state_ads_additional_detail_description':
          description.text.toString(),
      'real_state_ads_detail_city_id': selectedCity?.cityId.toString() ?? "",
    };
    Map<String, dynamic> files = {
      'real_state_ads_upload_image': productPicture
    };
    print("request ------------------$data   $files");
    loader = true;
    setState(() {});
    var res = await Webservices.postDataWithImageFunction(
        body: data,
        files: files,
        context: context,
        apiUrl: widget.adType == 'sell'
            ? upload_real_state_sell
            : upload_real_state_buy);
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
              title = _getTitleForIndex(_currentStepIndex-1);
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
          : realStateUseResult == null
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
        return Use();
      case 2:
        return Wall();
      case 3:
        return LandType();
      case 4:
        return Position();
      case 5:
        return ParkingView();
      case 6:
        return GovernateView();
      case 7:
        return State();
      case 8:
        return City();
      case 9:
        return UploadPhotos();
      case 10:
        return AdditionalDetails();
      default:
        return Use();
    }
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
                    color: selectedUse == useList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: useList[index],
                groupValue: selectedUse,
                onChanged: (value) {
                  _currentStepIndex = 2;
                  selectedUse = useList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${useList[index].useName}'),
              onTap: () {
                _currentStepIndex = 2;
                selectedUse = useList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),
    );
  }

  Widget Wall() {
    return ListView.builder(
        itemCount: wallList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: selectedWall == wallList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: wallList[index],
                groupValue: selectedWall,
                onChanged: (value) {
                  _currentStepIndex = 3;
                  selectedWall = wallList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${wallList[index].WallName}'),
              onTap: () {
                _currentStepIndex = 3;
                selectedWall = wallList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),
    );
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
                    color: selectedLandType == landTypeList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: landTypeList[index],
                groupValue: selectedLandType,
                onChanged: (value) {
                  _currentStepIndex = 4;
                  selectedLandType = landTypeList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${landTypeList[index].landtypeName}'),
              onTap: () {
                _currentStepIndex = 4;
                selectedLandType = landTypeList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),
    );
  }

  Widget Position() {
    return ListView.builder(
        itemCount: positionList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: selectedPosition == positionList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: positionList[index],
                groupValue: selectedPosition,
                onChanged: (value) {
                  _currentStepIndex = 5;
                  selectedPosition = positionList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${positionList[index].positionName}'),
              onTap: () {
                _currentStepIndex = 5;
                selectedPosition = positionList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              }
            ),
          ),
        ),
        );
  }

  Widget ParkingView() {
    return ListView.builder(
        itemCount: parkingList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: selectedParking == parkingList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: ListTile(
                leading: SquareRadio(
                  activeColor: MyColors.primaryColor,
                  value: parkingList[index],
                  groupValue: selectedParking,
                  onChanged: (value) {
                    _currentStepIndex = 6;
                    selectedParking = parkingList[index];
                    title = _getTitleForIndex(_currentStepIndex - 1);
                    _scrollToNextStep();
                    setState(() {});
                  },
                ),
                title: Text('${parkingList[index].parkingName}'),
                onTap: () {
                  _currentStepIndex = 6;
                  selectedParking = parkingList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                }
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
                  _currentStepIndex = 7;
                  selectedGovernate = governateList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  stateList = governateList[index].governorateState ?? [];
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${governateList[index].governorateName}'),
              onTap: () {
                _currentStepIndex = 7;
                selectedGovernate = governateList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                stateList = governateList[index].governorateState ?? [];
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),);
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
                  _currentStepIndex = 8;
                  selectedState = stateList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  cityList = stateList[index].stateCity ?? [];
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${stateList[index].stateName}'),
              onTap: () {
                _currentStepIndex = 8;
                selectedState = stateList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                cityList = stateList[index].stateCity ?? [];
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),);
  }

  Widget City() {
    return ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: selectedCity == cityList[index]
                        ? MyColors.primaryColor
                        : Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: ListTile(
              leading: SquareRadio(
                activeColor: MyColors.primaryColor,
                value: cityList[index],
                groupValue: selectedCity,
                onChanged: (value) {
                  _currentStepIndex = 9;
                  selectedCity = cityList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
              title: Text('${cityList[index].cityName}'),
              onTap: () {
                _currentStepIndex = 9;
                selectedCity = cityList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
          ),
        ),);
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
        SizedBox(height: 50),
        RoundButton(
          height: 45,
          borderRadius: 10,
          title: 'Complete the final step',
          onTap: () {
            if (productPicture != null) {
              _currentStepIndex = 10;
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
                    "Land Area",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                commonTextFormField(
                  controller: landArea,
                  hintText: 'Enter Land Area',
                ),
                SizedBox(
                  height: 10,
                ),
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
              if (landArea.text.isEmpty) {
                showSnackbar(context, "Enter land area");
              } else if (price.text.isEmpty) {
                showSnackbar(context, "Enter price");
              } else if (phone.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else if (description.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else {
                PostRealStateAd();
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
        return selectedUse?.useName ?? "";
      case 1:
        return selectedWall?.WallName ?? "";
      case 2:
        return selectedLandType?.landtypeName ?? "";
      case 3:
        return selectedPosition?.positionName ?? "";
      case 4:
        return selectedParking?.parkingName ?? "";
      case 5:
        return selectedGovernate?.governorateName ?? "";
      case 6:
        return selectedState?.stateName ?? "";
      case 7:
        return selectedCity?.cityName ?? "";
      case 8:
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
