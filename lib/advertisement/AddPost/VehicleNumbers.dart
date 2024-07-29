import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/VehicleLetterModel.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/GeneralModel.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../UpdatePosts/update_VehiclesMake.dart';
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
  TextEditingController vehicleNumber1 = TextEditingController();
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
      lettersList = vehicleLetterResult?.letters ?? [];
      plateTypeList = vehicleLetterResult?.plateTypes ?? [];
      governateList = vehicleLetterResult?.governorate ?? [];
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

  VehicleNumbersAd() async {
    Map<String, dynamic> data = {
      'vehicle_number_letter_id': selectedLetter?.letterId ?? "",
      'vehicle_number_plate_type_id': selectedPlateType?.plateTypeId ?? "",
      'vehicle_number_governorate_id': selectedgovernate?.governorateId ?? "",
      'vehicle_number_ads_user_id': userId,
      'vehicle_number_state_id': "",
      'vehicle_number_city_id': "",
      'vehicle_number_price': price.text.toString(),
      'vehicle_number_english_title': '',
      'vehicle_number_arabic_title': '',
      'upload_vehicles_numbers': phone.text.toString(),
      'vehicle_number': vehicleNumber.text.toString(),
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
        apiUrl: (widget.type == 'For Sale')
            ? upload_vehicles_numbers_for_sale
            : (widget.type == 'For Rent')
                ? upload_vehicles_numbers_for_rent
                : upload_vehicles_numbers_for_wanted);
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
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffff9900),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: textFieldView(
                            controller: vehicleNumber,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)))),
                    Expanded(
                        child: textFieldView(
                            controller: vehicleNumber1,
                            borderRadius: BorderRadius.zero)),
                    Expanded(
                      child: textFieldView(
                        controller: TextEditingController(text: 'عُمان'),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: lettersList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: selectedLetter == lettersList[index]
                              ? MyColors.primaryColor
                              : Colors.grey.withOpacity(0.5)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ListTile(
                    leading: SquareRadio(
                      activeColor: MyColors.primaryColor,
                      value: lettersList[index],
                      groupValue: selectedLetter,
                      onChanged: (value) {
                        _currentStepIndex = 2;
                        selectedLetter = lettersList[index];
                        vehicleNumber1.text = selectedLetter?.letterNameArabic ?? '';
                        title = _getTitleForIndex(_currentStepIndex - 1);
                        _scrollToNextStep();
                        setState(() {});
                      },
                    ),
                    title: Text('${lettersList[index].letterNameArabic}'),
                    subtitle: Text('${lettersList[index].letterNameEnglish}'),
                    onTap: () {
                      _currentStepIndex = 2;
                      selectedLetter = lettersList[index];
                      vehicleNumber1.text = selectedLetter?.letterNameArabic ?? '';
                      title = _getTitleForIndex(_currentStepIndex - 1);
                      _scrollToNextStep();
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget textFieldView(
      {required TextEditingController controller,
      BorderRadius? borderRadius,
      bool? readOnly,
      bool? autofocus,
      int? maxLength}) {
    return TextField(
      readOnly: readOnly ?? true,
      textAlign: TextAlign.center,
      cursorWidth: 0,
      autofocus: autofocus ?? false,
      cursorHeight: 0,
      cursorOpacityAnimates: false,
      maxLines: 1,
      maxLength: maxLength ?? 8,
      controller: controller,
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        counterText: '',
        fillColor: Color(0xffffd500),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff000000), width: .4)),
        disabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff000000), width: .4)),
        enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff000000), width: .4)),
        focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0xff000000), width: .4)),
      ),
    );
  }

  Widget VehicleNumberScreen() {
    return ListView(
      children: [
        Column(
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Container(
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffff9900),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: textFieldView(
                            controller: vehicleNumber,
                            maxLength: 5,
                            autofocus: true,
                            readOnly: false,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10)))),
                    Expanded(
                        child: textFieldView(
                            controller: vehicleNumber1,
                            borderRadius: BorderRadius.zero)),
                    Expanded(
                      child: textFieldView(
                        controller: TextEditingController(text: 'عُمان'),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                    ),
                  ],
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
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget PlateTypeScreen() {
    return ListView.builder(
      itemCount: plateTypeList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedPlateType == plateTypeList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: plateTypeList[index],
              groupValue: selectedPlateType,
              onChanged: (value) {
                _currentStepIndex = 4;
                selectedPlateType = plateTypeList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${plateTypeList[index].plateTypeName}'),
            onTap: () {
              _currentStepIndex = 4;
              selectedPlateType = plateTypeList[index];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  Widget GovernateScreen() {
    return ListView.builder(
      itemCount: governateList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: selectedgovernate == governateList[index]
                      ? MyColors.primaryColor
                      : Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            leading: SquareRadio(
              activeColor: MyColors.primaryColor,
              value: governateList[index],
              groupValue: selectedgovernate,
              onChanged: (value) {
                _currentStepIndex = 5;
                selectedgovernate = governateList[index];
                title = _getTitleForIndex(_currentStepIndex - 1);
                _scrollToNextStep();
                setState(() {});
              },
            ),
            title: Text('${governateList[index].governorateName}'),
            onTap: () {
              _currentStepIndex = 5;
              selectedgovernate = governateList[index];
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
          height: 50
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
          Column(
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
                maxLines: 4,
                controller: description,
                hintText: 'Provide more information about your ad',
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
                VehicleNumbersAd();
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
