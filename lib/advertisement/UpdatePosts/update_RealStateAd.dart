import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/get_ads_with_category_home_model.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/GeneralModel.dart';
import '../../Model/advertisement_model/RealStateUseModel.dart';
import '../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../ad_bottom_bar.dart';

class UpdateRealStateAd extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  final String ads_post_id;

  const UpdateRealStateAd({
    super.key,
    required this.adType,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id,
    required this.ads_post_id,
  });

  @override
  State<UpdateRealStateAd> createState() => _UpdateRealStateAdState();
}

class _UpdateRealStateAdState extends State<UpdateRealStateAd> {
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

  PostListDetails? result;

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
      getAdsPostDetails();
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
      price.text = result?.realStateAdsAdditionalDetailPrice ?? '';
      phone.text = result?.realStateAdsAdditionalDetailPhone ?? '';
      landArea.text = result?.realStateAdsAdditionalDetailLandArea ?? '';
      description.text = result?.realStateAdsAdditionalDetailDescription ?? '';

      if (useList.isNotEmpty) {
        useList.forEach((element) {
          ///TODO DONE
          if (element.useId == result?.realStateAdsDetailUseId) {
            selectedUse = element;
            setState(() {});
          }
        });
      }

      if (wallList.isNotEmpty) {
        wallList.forEach((element) {
          ///TODO DONE
          if (element.WallId == result?.realStateAdsDetailWallId) {
            selectedWall = element;
            setState(() {});
          }
        });
      }

      if (landTypeList.isNotEmpty) {
        landTypeList.forEach((element) {
          ///TODO DONE
          if (element.landtypeId == result?.realStateAdsDetailLandtypeId) {
            selectedLandType = element;
            setState(() {});
          }
        });
      }

      if (positionList.isNotEmpty) {
        positionList.forEach((element) {
          ///TODO DONE
          if (element.positionId == result?.realStateAdsDetailPositionId) {
            selectedPosition = element;
            setState(() {});
          }
        });
      }

      if (parkingList.isNotEmpty) {
        parkingList.forEach((element) {
          ///TODO DONE
          if (element.parkingId == result?.realStateAdsDetailParkingId) {
            selectedParking = element;
            setState(() {});
          }
        });
      }
      if (governateList.isNotEmpty) {
        governateList.forEach((element) {
          ///TODO DONE
          if (element.governorateId == result?.realStateAdsDetailGovernateId) {
            selectedGovernate = element;
            setState(() {});
            selectedGovernate?.governorateState?.forEach((elementStateList) {
              ///TODO DONE
              if (elementStateList.stateId ==
                  result?.realStateAdsDetailStateId) {
                selectedState = elementStateList;
                setState(() {});
                selectedState?.stateCity?.forEach((elementCityList) {
                  ///TODO DONE
                  if (elementCityList.cityId ==
                      result?.realStateAdsDetailCityId) {
                    selectedCity  = elementCityList;
                    setState(() {});
                  }
                });
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


  PostRealStateAd() async {
    Map<String, dynamic> data;
    var res;
    if(productPicture!=null){
      data = {
        'real_state_ads_detail_id': result?.realStateAdsDetailId ?? '',
        'real_state_ads_detail_use_id': selectedUse?.useId.toString() ?? "",
        'real_state_ads_detail_wall_id': selectedWall?.WallId.toString() ?? "",
        'real_state_ads_detail_landtype_id': selectedLandType?.landtypeId.toString() ?? "",
        'real_state_ads_detail_position_id': selectedPosition?.positionId.toString() ?? "",
        'real_state_ads_detail_parking_id': selectedParking?.parkingId.toString() ?? "",
        'real_state_ads_detail_state_id': selectedState?.stateId.toString() ?? "",
        'real_state_ads_detail_governate_id': selectedGovernate?.governorateId.toString() ?? "",
        'real_state_ads_additional_detail_price': price.text.toString(),
        'real_state_ads_additional_detail_land_area': landArea.text.toString(),
        'real_state_ads_additional_detail_phone': phone.text.toString(),
        'real_state_ads_additional_detail_description': description.text.toString(),
        'real_state_ads_detail_city_id': selectedCity?.cityId.toString() ?? "",
      };
      Map<String, dynamic> files = {'real_state_ads_upload_image': productPicture ?? ''};
      print("request ------------------$data   $files");
      loader = true;
      setState(() {});
      res = await Webservices.postDataWithImageFunction(
          body: data,
          files: files,
          context: context,
          apiUrl:edit_real_state);
      loader = false;
      setState(() {});
    }else{
      data = {
        'real_state_ads_upload_image': '',
        'real_state_ads_detail_id': result?.realStateAdsDetailId ?? '',
        'real_state_ads_detail_use_id': selectedUse?.useId.toString() ?? "",
        'real_state_ads_detail_wall_id': selectedWall?.WallId.toString() ?? "",
        'real_state_ads_detail_landtype_id': selectedLandType?.landtypeId.toString() ?? "",
        'real_state_ads_detail_position_id': selectedPosition?.positionId.toString() ?? "",
        'real_state_ads_detail_parking_id': selectedParking?.parkingId.toString() ?? "",
        'real_state_ads_detail_state_id': selectedState?.stateId.toString() ?? "",
        'real_state_ads_detail_governate_id': selectedGovernate?.governorateId.toString() ?? "",
        'real_state_ads_additional_detail_price': price.text.toString(),
        'real_state_ads_additional_detail_land_area': landArea.text.toString(),
        'real_state_ads_additional_detail_phone': phone.text.toString(),
        'real_state_ads_additional_detail_description': description.text.toString(),
        'real_state_ads_detail_city_id': selectedCity?.cityId.toString() ?? "",
      };
      print("request ------------------$data");
      loader = true;
      setState(() {});
      res = await Webservices.postData(
          body: data,
          context: context,
          apiUrl:edit_real_state);
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
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: useList[index],
                title: Text('${useList[index].useName}'),
                groupValue: selectedUse,
                onChanged: (UseList? value) {
                  _currentStepIndex = 2;
                  selectedUse = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Wall() {
    return ListView.builder(
        itemCount: wallList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: wallList[index],
                title: Text('${wallList[index].WallName}'),
                groupValue: selectedWall,
                onChanged: (WallList? value) {
                  _currentStepIndex = 3;
                  selectedWall = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget LandType() {
    return ListView.builder(
        itemCount: landTypeList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: landTypeList[index],
                title: Text('${landTypeList[index].landtypeName}'),
                groupValue: selectedLandType,
                onFocusChange: (value) {
                  print("gdhjsgj...$value");
                },
                onChanged: (Landtype? value) {
                  _currentStepIndex = 4;
                  selectedLandType = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget Position() {
    return ListView.builder(
        itemCount: positionList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: positionList[index],
                title: Text('${positionList[index].positionName}'),
                groupValue: selectedPosition,
                onChanged: (PositionList? value) {
                  _currentStepIndex = 5;
                  selectedPosition = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget ParkingView() {
    return ListView.builder(
        itemCount: parkingList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: parkingList[index],
                title: Text('${parkingList[index].parkingName}'),
                groupValue: selectedParking,
                onChanged: (Parking? value) {
                  _currentStepIndex = 6;
                  selectedParking = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget GovernateView() {
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
                title: Text('${governateList[index].governorateName}'),
                groupValue: selectedGovernate,
                onChanged: (Governorate? value) {
                  _currentStepIndex = 7;
                  selectedGovernate = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  stateList = governateList[index].governorateState ?? [];
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
                title: Text('${stateList[index].stateName}'),
                groupValue: selectedState,
                onChanged: (GovernorateState? value) {
                  _currentStepIndex = 8;
                  selectedState = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  cityList = stateList[index].stateCity ?? [];

                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget City() {
    return ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: cityList[index],
                title: Text('${cityList[index].cityName}'),
                groupValue: selectedCity,
                onChanged: (StateCity? value) {
                  _currentStepIndex = 9;
                  selectedCity = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
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
                    ? result?.realStateAdsUploadImage != null &&
                    result!.realStateAdsUploadImage!.isNotEmpty
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
                (result != null && result!.realStateAdsUploadImage != null)) {
              print(Uri.parse(result!.realStateAdsUploadImage!).pathSegments.last);
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
            title: 'All Set! Update your Ad',
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


  displayImageNetwork() {
    if (result!.realStateAdsUploadImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          result!.realStateAdsUploadImage!,
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
