import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/VehicleLetterModel.dart';
import 'package:ealaa_userr/Model/advertisement_model/get_ads_with_category_home_model.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/GeneralModel.dart';
import '../../Model/advertisement_model/get_ads_post_details_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../ad_bottom_bar.dart';

class UpdateVehicleNumbers extends StatefulWidget {
  final String adType;
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  final String ads_post_id;

  const UpdateVehicleNumbers({
    super.key,
    required this.adType,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id,
    required this.ads_post_id,
  });

  @override
  State<UpdateVehicleNumbers> createState() => _UpdateVehicleNumbersState();
}

class _UpdateVehicleNumbersState extends State<UpdateVehicleNumbers> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
    'Letter',
    'Vehicle Number',
    'Plate Type',
    'Governorate',
    'Upload Photos',
    'Additional Details',
  ];
  String title = "Letter";
  VehicleLetterResult? vehicleLetterResult;
  List<Letters> lettersList = [];
  List<PlateTypes> plateTypeList = [];
  List<Governorate> governateList = [];

  Letters? selectedLetter;
  PlateTypes? selectedPlateType;
  Governorate? selectedgovernate;

  String? selectedImage;

  bool loader = false;
  final imgPicker = ImagePicker();
  File? productPicture;
  TextEditingController price = TextEditingController();
  TextEditingController vehicleNumber = TextEditingController();
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
    var res = await Webservices.getMap("$get_vehicles_numbers_for_sell");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehicleLetterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      vehicleLetterResult = resdata.result!;
      lettersList = vehicleLetterResult?.letters ?? [];
      plateTypeList = vehicleLetterResult?.plateTypes ?? [];
      governateList = vehicleLetterResult?.governorate ?? [];
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
      price.text = result?.vehicleNumberPrice ?? '';
      phone.text = result?.vehicleNumberPhone ?? '';
      description.text = result?.vehicleNumberDescription ?? '';

      if (lettersList.isNotEmpty) {
        lettersList.forEach((element) {
          ///TODO DONE
          if (element.letterId == result?.vehicleNumberLetterId) {
            selectedLetter = element;
            setState(() {});
          }
        });
      }

      if (lettersList.isNotEmpty) {
        lettersList.forEach((element) {
          ///TODO DONE
          if (element.letterId == result?.vehicleNumberLetterId) {
            selectedLetter = element;
            setState(() {});
          }
        });
      }

      if (plateTypeList.isNotEmpty) {
        plateTypeList.forEach((element) {
          ///TODO DONE
          if (element.plateTypeId == result?.vehicleNumberPlateTypeId) {
            selectedPlateType = element;
            setState(() {});
          }
        });
      }

      if (governateList.isNotEmpty) {
        governateList.forEach((element) {
          ///TODO DONE
          if (element.governorateId == result?.vehicleNumberGovernorateId) {
            selectedgovernate = element;
            setState(() {});
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

  editVehiclesNumbers() async {
    Map<String, dynamic> data = {
      'vehicle_number_id': result?.vehicleNumberId ?? "",
      'vehicle_number_letter_id': selectedLetter?.letterId ?? "",
      'vehicle_number_plate_type_id': selectedPlateType?.plateTypeId ?? "",
      'vehicle_number_governorate_id': selectedgovernate?.governorateId ?? "",
      'vehicle_number_state_id': "",
      'vehicle_number_city_id': "",
      'vehicle_number_price': price.text.toString(),
      'vehicle_number_english_title': '',
      'vehicle_number_arabic_title': '',
      'upload_vehicles_numbers': phone.text.toString(),
      'vehicle_number_phone': vehicleNumber.text.toString(),
      'vehicle_number_description': description.text.toString(),
    };
    Map<String, dynamic> files = {'vehicle_number_image': productPicture};
    print("request ------------------$data   $files");
    loader = true;
    setState(() {});
    var res = await Webservices.postDataWithImageFunction(
        body: data,
        files: files,
        context: context,
        apiUrl: edit_vehicles_numbers);
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
          : lettersList.isEmpty
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
        return LetterScreen();
      case 2:
        return VehicleNumberScreen();
      case 3:
        return PlateTypeScreen();
      case 4:
        return GovernateScreen();
      case 5:
        return UploadPhotos();
      case 6:
        return AdditionalDetails();
      default:
        return LetterScreen();
    }
  }

  Widget LetterScreen() {
    return ListView.builder(
        itemCount: lettersList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: lettersList[index],
                title: Text('${lettersList[index].letterNameArabic}'),
                subtitle: Text('${lettersList[index].letterNameEnglish}'),
                groupValue: selectedLetter,
                onChanged: (Letters? value) {
                  _currentStepIndex = 2;
                  selectedLetter = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget VehicleNumberScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Vehicle Number",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              commonTextFormField(
                controller: vehicleNumber,
                hintText: 'Enter vehicle number',
              ),
              SizedBox(
                height: 10,
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
            title: 'Next',
            fontsize: 18,
            fontweight: FontWeight.w500,
            onTap: () {
              if (vehicleNumber.text.isEmpty) {
                showSnackbar(context, "Enter vehicle number");
              } else {
                _currentStepIndex = 3;
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

  Widget PlateTypeScreen() {
    return ListView.builder(
        itemCount: plateTypeList.length,
        itemBuilder: (context, index) => Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(bottom: 15),
              child: RadioListTile(
                activeColor: MyColors.primaryColor,
                value: plateTypeList[index],
                title: Text('${plateTypeList[index].plateTypeName}'),
                groupValue: selectedPlateType,
                onChanged: (PlateTypes? value) {
                  _currentStepIndex = 4;
                  selectedPlateType = value;
                  title = _getTitleForIndex(_currentStepIndex - 1);
                  _scrollToNextStep();
                  setState(() {});
                },
              ),
            ));
  }

  Widget GovernateScreen() {
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
                groupValue: selectedgovernate,
                onChanged: (Governorate? value) {
                  _currentStepIndex = 5;
                  selectedgovernate = value;
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
                    ? result?.vehicleNumberImage != null &&
                    result!.vehicleNumberImage!.isNotEmpty
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
                (result != null && result!.vehicleNumberImage != null)) {
              print(Uri.parse(result!.vehicleNumberImage!).pathSegments.last);
              _currentStepIndex = 6;
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
              Text(
                "Price",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              commonTextFormField(
                controller: price,
                hintText: 'Enter Price',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Phone',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
              ),
              commonTextFormField(
                controller: phone,
                hintText: 'Enter Phone',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Description",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10,
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
                editVehiclesNumbers();
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
        return selectedLetter?.letterNameArabic ?? "";
      case 1:
        return phone.text.toString() ?? "";
      case 2:
        return selectedPlateType?.plateTypeName ?? "";
      case 3:
        return selectedgovernate?.toString() ?? "";
      case 4:
        return selectedImage ?? "";
      default:
        return "";
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
    if (result!.vehicleNumberImage != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          result!.vehicleNumberImage!,
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
              Image.asset(
                MyImages.add,
                height: 45,
                width: 45,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ParagraphText(
                  text: "Upload your card number plate image",
                  textAlign: TextAlign.center,
                ),
              ),
              ParagraphText(
                text: "The image is used for verification only",
                textAlign: TextAlign.center,
                fontSize: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
