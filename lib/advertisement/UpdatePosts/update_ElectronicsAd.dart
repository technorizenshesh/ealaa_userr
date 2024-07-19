import 'dart:io';

import 'package:ealaa_userr/Model/advertisement_model/ElectronicsBrandModel.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/GeneralModel.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CommonMethods.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../ad_bottom_bar.dart';

class UpdateElectronicsAd extends StatefulWidget {
  final String advertisement_category_id;
  final String advertisement_sub_category_id;
  const UpdateElectronicsAd({super.key,
    required this.advertisement_category_id,
    required this.advertisement_sub_category_id});

  @override
  State<UpdateElectronicsAd> createState() => _UpdateElectronicsAdState();
}

class _UpdateElectronicsAdState extends State<UpdateElectronicsAd> {
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

  ElectronicsAd() async {
    Map<String, dynamic> data = {
      'category_id': widget.advertisement_category_id,
      'sub_category_id': widget.advertisement_sub_category_id,
      'electronics_ads_user_id': userId,
      'electronics_ads_storage': selectedStorage?.storageId ?? '',
      'electronics_ads_brand': selectedBrand?.brandId ?? '',
      'electronics_ads_condition': selectedCondition?.conditionId ?? '',
      'electronics_ads_warranty': selectedWarrenty?.warrantyId ?? '',
      'electronics_ads_governorate': selectedGovernate?.governorateId ??'',
      'electronics_ads_state': selectedState?.stateId ??'',
      'electronics_ads_city': selectedCity?.cityId ?? '',
      'electronics_ads_description': description.text,
      'electronics_ads_price': price.text,
      'electronics_ads_post_id': '',
    };
    Map<String, dynamic> files = {'electronics_ads_image': productPicture};
    print("request ------------------$data   $files");
    loader = true;
    setState(() {});
    var res = await Webservices.postDataWithImageFunction(
        body: data, files: files, context: context, apiUrl: widget.advertisement_category_id == '7'? uploadElectronics_sell : uploadElectronics_buy);
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
          : electronicsBrandResult == null
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
            title: Text('${brandList[index].name}'),
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
        Center(
          child: GestureDetector(
              onTap: () {
                _image_camera_dialog(context);
              },
              child: productPicture == null
                  ? Center(child: uploadProductContainer())
                  : Center(child: displayImage())),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  "Land Area",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              commonTextFormField(
                controller: landArea,
                hintText: 'Enter Land Area',
              ),*/
              SizedBox(
                height: 10,
              ),
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
                "Phone",
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
                ElectronicsAd();
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
        return selectedBrand?.name ?? "";
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
