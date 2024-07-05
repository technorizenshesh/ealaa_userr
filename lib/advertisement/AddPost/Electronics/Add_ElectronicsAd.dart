import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/ElectronicsBrandModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CommonMethods.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../../common/common_widgets.dart';
import '../../ad_bottom_bar.dart';

class AddElectronicsAd extends StatefulWidget {
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  const AddElectronicsAd({super.key,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id});

  @override
  State<AddElectronicsAd> createState() => _AddElectronicsAdState();
}

class _AddElectronicsAdState extends State<AddElectronicsAd> {
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  List<String> topList = [
    'Brand',
    'Model',
    'Storage',
    'Condition',
    'Warrenty',
    'Governate',
    'State',
    'City',
    'Upload Photos',
    'Additional Details',
  ];
  String title = "Brand";
  ElectronicsBrandResult? electronicsBrandResult;
  List<Brand> brandList = [];
  List<BrandModel> modelList = [];
  List<Storage> storageList = [];
  List<Condition> conditionList = [];
  List<Warranty> warrentyList = [];
  List<Governorate> governateList = [];
  List<GovernorateState> stateList = [];
  List<StateCity> cityList = [];

  Brand? selectedBrand;
  BrandModel? selectedModel;
  Storage? selectedStorage;
  Condition? selectedCondition;
  Warranty? selectedWarrenty;
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
    var res = await Webservices.getMap("$get_electronics");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = ElectronicsBrandModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      electronicsBrandResult = resdata.result!;
      brandList = electronicsBrandResult!.brand ?? [];
      storageList = electronicsBrandResult!.storage ?? [];
      conditionList = electronicsBrandResult!.condition??[];
      warrentyList = electronicsBrandResult!.warranty??[];
      governateList = electronicsBrandResult!.governorate??[];
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

  // PostVehicleAd() async {
  //   Map<String, dynamic> data = {
  //     'category_id': "widget.advertisement_category_id",
  //     'vehicle_ads_sub_category': "widget.advertisement_sub_category_id",
  //     'vehicle_ads_detail_user_id': userId,
  //     'vehicle_ads_detail_maker_id': selectedMake?.id ?? "",
  //     'vehicle_ads_detail_model_id': selectedModel?.id ?? "",
  //     'vehicle_ads_detail_model_trim_id': selectedTrim?.id ?? "",
  //     'vehicle_ads_detail_year': selectedYear.toString(),
  //     'vehicle_ads_detail_condition': selectedCondition,
  //     'vehicle_ads_detail_engine_size': selectedEngine,
  //     'vehicle_ads_detail_doors': selectedDoor.toString(),
  //     'vehicle_ads_detail_exterior_color': selectedExteriorColor,
  //     'vehicle_ads_detail_interior_color': selectedInteriorColor,
  //     'vehicle_ads_detail_cylinders': selectedCylinder.toString(),
  //     'vehicle_ads_detail_fuel': selectedFuel,
  //     'vehicle_ads_detail_transmission': selectedTransmission,
  //     'vehicle_ads_detail_drive_train': selectedDriverTrain,
  //     'vehicle_ads_detail_plate': selectedPlate,
  //     'vehicle_ads_detail_origin': selectedOrigin,
  //     'vehicle_ads_detail_governate': selectedGovernate,
  //     'vehicle_ads_detail_state': selectedState,
  //     'vehicle_ads_additional_detail_price': price.text.toString(),
  //     'vehicle_ads_additional_detail_distance_travelled':
  //         landArea.text.toString(),
  //     'vehicle_ads_additional_detail_phone': phone.text.toString(),
  //     'vehicle_ads_additional_detail_description': description.text.toString(),
  //   };
  //   Map<String, dynamic> files = {'vehicle_ads_upload_image': productPicture};
  //   print("request ------------------$data   $files");
  //   loader = true;
  //   setState(() {});
  //   var res = await Webservices.postDataWithImageFunction(
  //       body: data, files: files, context: context, apiUrl: upload_vehicle_buy);
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
          : electronicsBrandResult == null
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
        return BrandView();
      case 2:
        return Models();
      case 3:
        return StorageView();
      case 4:
        return ConditionView();
      case 5:
        return WarrentyView();
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
        return BrandView();
    }
  }

  Widget BrandView() {
    return ListView.builder(
        itemCount: brandList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: brandList[index],
            title: Text('${brandList[index].brandName}'),
            groupValue: selectedBrand,
            onChanged: (Brand? value) {
              _currentStepIndex = 2;
              selectedBrand = value;
              modelList = brandList[index].brandModel??[];
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget Models() {
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
            title: Text('${modelList[index].modelName}'),
            groupValue: selectedModel,
            onChanged: (BrandModel? value) {
              _currentStepIndex = 3;
              selectedModel = value;
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget StorageView() {
    return ListView.builder(
        itemCount: storageList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: storageList[index],
            title: Text('${storageList[index].storageName}'),
            groupValue: selectedStorage,
            onFocusChange: (value) {
              print("gdhjsgj...$value");
            },
            onChanged: (Storage? value) {
              _currentStepIndex = 5;
              selectedStorage = value;
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget ConditionView() {
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
            title: Text('${conditionList[index].conditionName}'),
            groupValue: selectedCondition,
            onChanged: (Condition? value) {
              _currentStepIndex = 5;
              selectedCondition = value;
              title = _getTitleForIndex(_currentStepIndex - 1);

              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget WarrentyView() {
    return ListView.builder(
        itemCount: warrentyList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: warrentyList[index],
            title: Text('${warrentyList[index].warrantyName}'),
            groupValue: selectedWarrenty,
            onChanged: (Warranty? value) {
              _currentStepIndex = 6;
              selectedWarrenty = value;
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
              stateList = governateList[index].governorateState??[];
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
              cityList = stateList[index].stateCity??[];

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
                //  PostVehicleAd();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdBottomBar(),
                        ));
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
        return selectedBrand?.brandName ?? "";
      case 1:
        return selectedModel?.modelName ?? "";
      case 2:
        return selectedStorage?.storageName ?? "";
      case 3:
        return selectedCondition?.conditionName ?? "";
      case 4:
        return selectedWarrenty?.warrantyName ?? "";
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
