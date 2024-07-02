import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/VehicleLetterModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../ad_bottom_bar.dart';

class VehicleNumbers extends StatefulWidget {
  final String type;
  const VehicleNumbers({super.key, required this.type});

  @override
  State<VehicleNumbers> createState() => _VehicleNumbersState();
}

class _VehicleNumbersState extends State<VehicleNumbers> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
    'Letter',
    'Vehicle Number',
    'Plate Type',
    'Governate',
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
    var res = await Webservices.getMap("$get_vehicles_numbers_for_sell");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehicleLetterModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      vehicleLetterResult = resdata.result!;
      lettersList = vehicleLetterResult?.letters??[];
      plateTypeList = vehicleLetterResult?.plateTypes??[];
      governateList = vehicleLetterResult?.governorate??[];

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

  // PostRealStateAd() async {
  //   Map<String, dynamic> data = {
  //     'category_id': widget.advertisement_category_id,
  //     'sub_catgerory_id': widget.advertisement_sub_category_id,
  //     'real_state_ads_detail_user_id': userId,
  //     'real_state_ads_detail_ads_post_id': '1',
  //     'real_state_ads_detail_use_id': selectedUse?.useId.toString() ?? "",
  //     'real_state_ads_detail_wall_id': selectedWall?.WallId.toString() ?? "",
  //     'real_state_ads_detail_landtype_id':
  //     selectedLandType?.landtypeId.toString() ?? "",
  //     'real_state_ads_detail_position_id':
  //     selectedPosition?.positionId.toString() ?? "",
  //     'real_state_ads_detail_parking_id':
  //     selectedParking?.parkingId.toString() ?? "",
  //     'real_state_ads_detail_state_id': selectedState?.stateId.toString() ?? "",
  //     'real_state_ads_detail_governate_id':
  //     selectedGovernate?.governorateId.toString() ?? "",
  //     'real_state_ads_additional_detail_price': price.text.toString(),
  //     'real_state_ads_additional_detail_land_area': landArea.text.toString(),
  //     'real_state_ads_additional_detail_phone': phone.text.toString(),
  //     'real_state_ads_additional_detail_description':
  //     description.text.toString(),
  //     'real_state_ads_detail_city_id': selectedCity?.cityId.toString() ?? "",
  //   };
  //   Map<String, dynamic> files = {
  //     'real_state_ads_upload_image': productPicture
  //   };
  //   print("request ------------------$data   $files");
  //   loader = true;
  //   setState(() {});
  //   var res = await Webservices.postDataWithImageFunction(
  //       body: data,
  //       files: files,
  //       context: context,
  //       apiUrl: widget.adType == 'sell'
  //           ? upload_real_state_sell
  //           : upload_real_state_buy);
  //   loader = false;
  //   setState(() {});
  //   final resdata = GeneralModel.fromJson(res);
  //   if (res['status'] == "1") {
  //     showSnackbar(context, resdata.message!);
  //     Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => AdBottomBar(),
  //         ));
  //   } else {
  //     showSnackbar(context, resdata.message!);
  //   }
  // }

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
            title: 'Next',
            fontsize: 18,
            fontweight: FontWeight.w500,
            onTap: () {
              if (phone.text.isEmpty) {

                showSnackbar(context, "Enter phone number");
              } else {
                _currentStepIndex = 3;
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {

                });
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
                    phone.text.toString(),
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
              } else if (phone.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else if (description.text.isEmpty) {
                showSnackbar(context, "Enter phone number");
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdBottomBar(),
                    ));
              //  PostPhoneAd();
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
