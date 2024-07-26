import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/PhoneOperatorModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/GeneralModel.dart';
import '../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../AddPost/Vehicles/VehiclesMake.dart';
import '../ad_bottom_bar.dart';

class UpdatePhoneNumbersAd extends StatefulWidget {

  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  final String ads_post_id;

  const UpdatePhoneNumbersAd({super.key,
    required this.adType,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id,
    required this.ads_post_id,
  });

  @override
  State<UpdatePhoneNumbersAd> createState() => _UpdatePhoneNumbersAdState();
}

class _UpdatePhoneNumbersAdState extends State<UpdatePhoneNumbersAd> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
    'Phone Number',
    'Operators',
    'Governorate',
    'State',
    'City',
    'Upload Photos',
    'Additional Details',
  ];
  String title = "Phone Number";
   PhoneOperatorResult? phoneOperatorResult;
   List<Operators> operatorsList = [];
   List<Governorate> governateList = [];
  List<GovernorateState> stateList = [];
  List<StateCity> cityList = [];

  Operators? selectedOperator;
   Governorate? selectedGovernrate;
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
  //
  getListData() async {
    var res = await Webservices.getMap("$get_phone_number");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = PhoneOperatorModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      phoneOperatorResult = resdata.result!;
      operatorsList = phoneOperatorResult!.operators ?? [];
       governateList = phoneOperatorResult!.governorate??[];
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
      price.text = result?.phoneNumberAdsPrice ?? '';
      phone.text = result?.phoneNumberAdsPhone ?? '';
      description.text = result?.phoneNumberAdsDescription ?? '';
      if (operatorsList.isNotEmpty) {
        operatorsList.forEach((element) {
          ///TODO DONE
          if (element.operatorsId == result?.phoneNumberAdsOperators) {
            selectedOperator = element;
            setState(() {});
          }
        });
      }

      if (governateList.isNotEmpty) {
        governateList.forEach((element) {
          ///TODO DONE
          if (element.governorateId == result?.phoneNumberAdsGovernorate) {
            selectedGovernrate = element;
            setState(() {});
            selectedGovernrate?.governorateState?.forEach((elementStateList) {
              ///TODO DONE
              if (elementStateList.stateId ==
                  result?.phoneNumberAdsState) {
                selectedState = elementStateList;
                setState(() {});
                selectedState?.stateCity?.forEach((elementCityList) {
                  ///TODO DONE
                  if (elementCityList.cityId ==
                      result?.phoneNumberAdsCity) {
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


  String _getTitleForIndex(int index) {
    if (index == 1 || index < topList.length) {
      return topList[index];
    } else {
      return ""; // Handle out of bounds index gracefully
    }
  }


  PostPhoneAd() async {
    Map<String, dynamic> data;
    var res;
    if(productPicture!=null){
      data = {
        'phone_number_ads_id': result?.phoneNumberAdsId ?? '',
        'phone_number_ads_operators': selectedOperator?.operatorsId ?? "",
        'phone_number_ads_governorate': selectedGovernrate?.governorateId ?? "",
        'phone_number_ads_state': selectedState?.stateId ?? "",
        'phone_number_ads_city': selectedCity?.cityId??"",
        'phone_number_ads_phone': phone.text.toString(),
        'phone_number_ads_price':price.text.toString(),
        'phone_number_ads_description': description.text.toString(),
      };
      Map<String, dynamic> files = {'phone_number_ads_image': productPicture};
      print("request ------------------$data   $files");
      loader = true;
      setState(() {});
      res = await Webservices.postDataWithImageFunction(
          body: data,
          files: files,
          context: context,
          apiUrl:edit_phone_number);
      loader = false;
      setState(() {});
    }
    else{
      data = {
        'phone_number_ads_image': '',
        'phone_number_ads_id': result?.phoneNumberAdsId ?? '',
        'phone_number_ads_operators': selectedOperator?.operatorsId ?? "",
        'phone_number_ads_governorate': selectedGovernrate?.governorateId ?? "",
        'phone_number_ads_state': selectedState?.stateId ?? "",
        'phone_number_ads_city': selectedCity?.cityId??"",
        'phone_number_ads_phone': phone.text.toString(),
        'phone_number_ads_price':price.text.toString(),
        'phone_number_ads_description': description.text.toString(),
      };
      print("request ------------------$data");
      loader = true;
      setState(() {});
      res = await Webservices.postData(
          body: data,
          context: context,
          apiUrl:edit_phone_number);
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
            if (_currentStepIndex > 1) {
              _currentStepIndex--;
              title = _getTitleForIndex(_currentStepIndex - 1);
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
      body:
      showProgressBar
          ? Center(
        child: CircularProgressIndicator(
          color: MyColors.primaryColor,
        ),
      )
          : phoneOperatorResult == null
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
                          ? Image.asset('assets/icons/ic_card.png',height: 28,width: 28,)
                          : _currentStepIndex == index + 1
                          ? Image.asset('assets/icons/ic_card_orange.png',height: 40,width: 40,)
                          : Image.asset('assets/icons/ic_card_green.png',height: 40,width: 40,),
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
        return PhoneNumberView();
      case 2:
        return OperatorsView();
      case 3:
        return GovernateView();
      case 4:
        return StateView();
      case 5:
        return CityView();
      case 6:
        return UploadPhotos();
      case 7:
        return AdditionalDetails();
      default:
        return PhoneNumberView();
    }
  }


  Widget PhoneNumberView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: TextField(
              textAlign: TextAlign.center,
              maxLines: 1,
              maxLength: 8,
              autofocus: true,
              cursorWidth: 0,
              cursorHeight: 0,
              cursorOpacityAnimates: false,
              cursorColor: Color(0xff067445),
              controller: phone,
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 8),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                counterText: '',
                fillColor: Color(0xff067445),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff067445))),
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff067445))),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff067445))),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xff067445))),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 45),
            child: Image.asset(
              'assets/images/ic_number_plate_image_one.png',
              height: 40,
            ),
          ),
          SizedBox(height: 20),
          RoundButton(
            loading: loader,
            height: 45,
            borderRadius: 10,
            title: 'Next',
            fontsize: 18,
            fontweight: FontWeight.w500,
            onTap: () {
              if (phone.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else {
                _currentStepIndex = 2;
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }

  Widget OperatorsView() {
    return ListView.builder(
      itemCount: operatorsList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedOperator == operatorsList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: operatorsList[index],
              groupValue: selectedOperator,
              onChanged: (value) {
                _currentStepIndex = 3;
                selectedOperator = operatorsList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${operatorsList[index].operatorsName}'),
            onTap: () {
              _currentStepIndex = 3;
              selectedOperator = operatorsList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
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
                  color: selectedGovernrate == governateList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: governateList[index],
              groupValue: selectedGovernrate,
              onChanged: (value) {
                _currentStepIndex = 4;
                selectedGovernrate = governateList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                stateList = governateList[index].governorateState ?? [];
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${governateList[index].governorateName}'),
            onTap: () {
              _currentStepIndex = 4;
              selectedGovernrate = governateList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              stateList = governateList[index].governorateState ?? [];
              _scrollToNextStep();
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
                  _currentStepIndex = 5;
                  selectedState = stateList[index];
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  cityList = stateList[index].stateCity ?? [];
                  _scrollToNextStep();
                  setState(() {});
                }),
            title: Text('${stateList[index].stateName}'),
            onTap: () {
              _currentStepIndex = 5;
              selectedState = stateList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              cityList = stateList[index].stateCity ?? [];
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
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
                _currentStepIndex = 6;
                selectedCity = cityList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${cityList[index].cityName}'),
            onTap: () {
              _currentStepIndex = 6;
              selectedCity = cityList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
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
                    ? result?.phoneNumberAdsImage != null &&
                    result!.phoneNumberAdsImage!.isNotEmpty
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
                (result != null && result!.phoneNumberAdsImage != null)) {
              print(Uri.parse(result!.phoneNumberAdsImage!).pathSegments.last);
              _currentStepIndex = 7;
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
          Column(
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
                  'Enter Phone',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              commonTextFormField(
                readOnly: true,
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
              if (price.text.isEmpty) {
                showSnackbar(context, "Enter price");
              } else if (phone.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else if (description.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else {
                  PostPhoneAd();
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
        return phone.text;
      case 1:
        return selectedOperator?.operatorsName ?? "";
      case 2:
        return selectedGovernrate?.governorateName ?? "";
      case 3:
        return selectedState?.stateName ?? "";
      case 4 :
        return selectedCity?.cityName ?? "";
      case 5:
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

  displayImageNetwork() {
    if (result!.phoneNumberAdsImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          result!.phoneNumberAdsImage!,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      );
    } else {
      return Text("No file is selected");
    }
  }
}
