import 'dart:io';

import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/GeneralModel.dart';
import '../../../Model/advertisement_model/VehiclePartsModel.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CommonMethods.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/webService.dart';
import '../../../common/common_widgets.dart';
import '../../ad_bottom_bar.dart';

class AdVehiclesPartAdd extends StatefulWidget {
  final String type;
  final String adType;
  final String advertisement_category_id;

  const AdVehiclesPartAdd({super.key, required this.advertisement_category_id,
    required this.adType,
    required this.type});

  @override
  State<AdVehiclesPartAdd> createState() => _AdVehiclesPartAddState();
}

class _AdVehiclesPartAddState extends State<AdVehiclesPartAdd> {
  List<String> topList = [
    'Part',
    'Makes',
    'Vehicle Models',
    'Model Years',
    'Model Trim',
    'Engine Size',
    'Upload Photos',
    'Additional Details',
  ];
  final ScrollController _scrollController = ScrollController();
  bool showProgressBar = true;
  int _currentStepIndex = 1;
  String title = "Part";
  int selectedIndex = -1;
  VehiclePartsResult? vehiclePartsResult;
  List<Part> partsList = [];
  List<SubPartName> subPartList = [];
  List<Maker> makerList = [];
  List<Model> modelList = [];
  List<ModelYear> yearList = [];
  List<ModelTrim> trimList = [];
  List<EngineSize> enginesizeList = [];


  Part? selectedPart;
  SubPartName? selectedSubpart;
  Maker? selectedMaker;
  Model? selectesModel;
  ModelYear? selectedModelyear;
  ModelTrim? selectedModeltrim;
  EngineSize? selectedEnginesize;

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
    var res = await Webservices.getMap(widget.type == "Wanted"
        ? "$get_vehicles_parts_accessories_wanted"
        : "$get_vehicles_parts_accessories_for_sell");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = VehiclePartsModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      vehiclePartsResult = resdata.result!;
      partsList = vehiclePartsResult!.part ?? [];
      makerList = vehiclePartsResult!.maker ?? [];
      enginesizeList = vehiclePartsResult!.engineSize ?? [];

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
      'sub_category_id': '',
      'vehicle_part_part_id': selectedSubpart?.partId ?? '',
      'vehicle_part_sub_part_id': selectedSubpart?.subPartId ?? '',
      'vehicle_part_maker_id': selectedMaker?.id ?? '',
      'vehicle_part_model_id': selectesModel?.id ?? '',
      'vehicle_part_model_trim_id':selectedModeltrim?.id ?? '',
      'vehicle_part_model_year_id':selectedModelyear?.yearId ?? "",
      'vehicle_part_engine_size_id':selectedEnginesize?.engineId ?? "",
      'vehicle_part_price': price.text.toString(),
      'vehicle_part_quantity':'',
      'vehicle_part_part_number': '',
      'vehicle_part_english_title': selectedSubpart?.subPartName ?? '',
      'vehicle_part_arabic_title': '',
      'vehicle_part_phone': phone.text.toString(),
      'vehicle_part_description': description.text.toString(),
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
          : vehiclePartsResult == null
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
        return PartView();
      case 2:
        return MakesView();
      case 3:
        return ModelsView();
      case 4:
        return YearsView();
      case 5:
        return TrimView();
      case 6:
        return SizeView();
      case 7:
        return UploadPhotos();
      case 8:
        return AdditionalDetails();
      default:
        return PartView();
    }
  }

  Widget PartView() {
    return ListView.builder(
        itemCount: partsList.length,
        itemBuilder: (context, index) => Column(
              children: [
                GestureDetector(
                  onTap: (){
                    subPartList = partsList[index].subPartName??[];
                    setState(() {});
                    if(selectedIndex!=index){
                      selectedIndex = index;
                      setState(() {});
                    }
                    else{
                      selectedIndex = -1;
                      setState(() {});
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    margin: EdgeInsets.only(bottom: 15),
                    child: ListTile(
                      leading: Icon(selectedIndex == index?Icons.expand_less:Icons.expand_more,color: MyColors.primaryColor,size: 30,),
                      title: Text('${partsList[index].partName}'),
                      trailing: SvgPicture.asset("assets/images/EngineIcon.svg",height: 30,),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if(selectedIndex==index)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: subPartList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.withOpacity(0.5)),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      margin: EdgeInsets.only(bottom: 15),
                      child: RadioListTile(
                        activeColor: MyColors.primaryColor,
                        value: subPartList[index],
                        title: Text('${subPartList[index].subPartName}'),
                        groupValue: selectedSubpart,
                        onChanged: (SubPartName? value) {
                          _currentStepIndex = 2;
                          selectedSubpart = value;
                          title = _getTitleForIndex(_currentStepIndex - 1);
                          _scrollToNextStep();
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                )
              ],
            ));
  }

  Widget MakesView() {
    return ListView.builder(
        itemCount: makerList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: makerList[index],
            title: Text('${makerList[index].name}'),
            groupValue: selectedMaker,
            onChanged: (Maker? value) {
              _currentStepIndex = 3;
              selectedMaker = value;
              title = _getTitleForIndex(_currentStepIndex - 1);
              modelList = selectedMaker?.model??[];
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget ModelsView() {
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
            groupValue: selectesModel,
            onFocusChange: (value) {
              print("gdhjsgj...$value");
            },
            onChanged: (Model? value) {
              _currentStepIndex = 4;
              selectesModel = value;
              title = _getTitleForIndex(_currentStepIndex - 1);
              yearList = selectesModel?.modelYear??[];
              trimList = selectesModel?.modelTrim??[];
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget YearsView() {
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
            title: Text('${yearList[index].yearName}'),
            groupValue: selectedModelyear,
            onChanged: (ModelYear? value) {
              _currentStepIndex = 5;
              selectedModelyear = value;
              title = _getTitleForIndex(_currentStepIndex - 1);

              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget TrimView() {
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
            groupValue: selectedModeltrim,
            onChanged: (ModelTrim? value) {
              _currentStepIndex = 6;
              selectedModeltrim = value;
              title = _getTitleForIndex(_currentStepIndex - 1);
              _scrollToNextStep();
              setState(() {});
            },
          ),
        ));
  }

  Widget SizeView() {
    return ListView.builder(
        itemCount: enginesizeList.length,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          margin: EdgeInsets.only(bottom: 15),
          child: RadioListTile(
            activeColor: MyColors.primaryColor,
            value: enginesizeList[index],
            title: Text('${enginesizeList[index].engineValue}'),
            groupValue: selectedEnginesize,
            onChanged: (EngineSize? value) {
              _currentStepIndex = 7;
              selectedEnginesize = value;
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
              _currentStepIndex = 8;
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
                /*Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdBottomBar(),
                    ));*/
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
        return selectedPart?.partName ?? "";
      // case 1:
      //   return selectedWall?.WallName ?? "";
      // case 2:
      //   return selectedLandType?.landtypeName ?? "";
      // case 3:
      //   return selectedPosition?.positionName ?? "";
      // case 4:
      //   return selectedParking?.parkingName ?? "";
      // case 5:
      //   return selectedGovernate?.governorateName ?? "";
      // case 6:
      //   return selectedState?.stateName ?? "";
      // case 7:
      //   return selectedCity?.cityName ?? "";
      // case 8:
      //   return selectedImage ?? "";
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
