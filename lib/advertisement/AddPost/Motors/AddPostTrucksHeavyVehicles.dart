import 'dart:io';

import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/CityModel.dart';
import '../../../Model/advertisement_model/AddPostModel.dart';
import '../../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../../Model/advertisement_model/get_advertisement_category_model.dart';
import '../../../View/Screens/ChoosePickupLocationMap.dart';
import '../../../View/Utils/ApiConstants.dart';
import '../../../View/Utils/CommonMethods.dart';
import '../../../View/Utils/CustomSnackBar.dart';
import '../../../View/Utils/GlobalData.dart';
import '../../../View/Utils/webService.dart';
import '../../../common/common_widgets.dart';
import '../../ad_bottom_bar.dart';

class AddPostTruckHeavyVehicles extends StatefulWidget {
  final GetAdsWithCategoryHomeResult selectedCategory;
  final SubcategoryResult selectedSubcategory;
  final CityResult selectedCity;
  final String description;
  const AddPostTruckHeavyVehicles({super.key,
    required this.selectedCategory,
    required this.selectedCity,
    required this.description,
    required this.selectedSubcategory});

  @override
  State<AddPostTruckHeavyVehicles> createState() => _AddPOstTruckHeavyVehiclesState();
}

class _AddPOstTruckHeavyVehiclesState extends State<AddPostTruckHeavyVehicles> {
  bool loader = false;
  final imgPicker = ImagePicker();
  File? productPicture;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController VIN = TextEditingController();
  TextEditingController truckType = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController make = TextEditingController();
  TextEditingController modelYear = TextEditingController();
  TextEditingController condition = TextEditingController();
  TextEditingController specs = TextEditingController();
  TextEditingController kilometer = TextEditingController();
  TextEditingController enginecapacity = TextEditingController();
  TextEditingController cylinder = TextEditingController();
  TextEditingController transmissionType = TextEditingController();
  TextEditingController bodycolor = TextEditingController();
  TextEditingController fuelType = TextEditingController();
  TextEditingController doors = TextEditingController();
  TextEditingController warrenty = TextEditingController();
  TextEditingController horsePower = TextEditingController();
  TextEditingController serviceHistory = TextEditingController();
  TextEditingController seats = TextEditingController();
  TextEditingController rimsize = TextEditingController();
  TextEditingController features = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController toururl = TextEditingController();
  TextEditingController youtubeurl = TextEditingController();
  TextEditingController address = TextEditingController();

  clickOnPostAnAd() async {
    if (productPicture != null &&
        phoneNumber.text.trim().isNotEmpty &&
        VIN.text.trim().isNotEmpty &&
        truckType.text.trim().isNotEmpty &&
        price.text.trim().isNotEmpty&&
        make.text.trim().isNotEmpty&&
        modelYear.text.trim().isNotEmpty &&
        condition.text.trim().isNotEmpty&&
        specs.text.trim().isNotEmpty&&
        kilometer.text.trim().isNotEmpty&&
        enginecapacity.text.trim().isNotEmpty&&
        cylinder.text.trim().isNotEmpty&&
        transmissionType.text.trim().isNotEmpty&&
        bodycolor.text.trim().isNotEmpty&&
        fuelType.text.trim().isNotEmpty&&
        doors.text.trim().isNotEmpty&&
        warrenty.text.trim().isNotEmpty&&
      //  horsePower.text.trim().isNotEmpty&&
        serviceHistory.text.trim().isNotEmpty &&
        seats.text.trim().isNotEmpty &&
        rimsize.text.trim().isNotEmpty &&
        features.text.trim().isNotEmpty &&
        description.text.trim().isNotEmpty &&
        toururl.text.trim().isNotEmpty &&
        youtubeurl.text.trim().isNotEmpty &&
        address.text.trim().isNotEmpty) {
      Map<String, dynamic> data = {
        'user_id': userId,
        'category_id': widget.selectedCategory.id,
        'city_id': widget.selectedCity.id,
        'shorts_description': widget.description,
        'sub_category_id': widget.selectedSubcategory.id,
        'VIN':VIN.text.trim(),
        'TruckType': truckType.text.trim(),
        'price': price.text.trim(),
        'TruckMake': make.text.trim(),
        'ModelYear': modelYear.text.trim(),
        'condition': condition.text.trim(),
        'RegionalSpecs': specs.text.trim(),
        'Kilometer': kilometer.text.trim(),
        'EngineCapacity': enginecapacity.text.trim(),
        'Numberofcylinders': cylinder.text.trim(),
        'TransmissionType': transmissionType.text.trim(),
        'color': bodycolor.text.trim(),
        'FuelType': fuelType.text.trim(),
        'NumberofDoors': doors.text.trim(),
        'under_warranty': warrenty.text.trim(),
        'HorsePower': horsePower.text.trim(),
        'ServiceHistory': serviceHistory.text.trim(),
        'Noofseats': seats.text.trim(),
        'Rimsize': rimsize.text.trim(),
        'extra_features': features.text.trim(),
        'description': description.text.trim(),
        'tour_url': toururl.text.trim(),
        'youtube_url': youtubeurl.text.trim(),
        'address': address.text.trim(),
        'mobile':phoneNumber.text.trim()
      };
      Map<String, dynamic> files = {'image': productPicture};
      print("request ------------------$data   $files");
      loader = true;
      setState(() {});
      var res = await Webservices.postDataWithImageFunction(
          body: data,
          files: files,
          context: context,
          apiUrl: add_advertisement_TrucksHeavyVehicles_posts);
      loader = false;
      setState(() {});
      final resdata = AddPostModel.fromJson(res);
      if (resdata.status == "1") {
        showSnackbar(context, resdata.message!);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdBottomBar(),
            ));
      } else {
        showSnackbar(context, resdata.message!);
      }
    } else {
      showSnackbar(context, 'All field required!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Post an Add', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'You\'re almost there!',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Include as much details and pictures as possible,and set the right price!',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${widget.selectedCategory.name} > ${widget.selectedSubcategory.subCategoryName}',
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    _image_camera_dialog(context);
                  },
                  child: productPicture == null
                      ? Center(child: uploadProductContainer())
                      : Center(child: displayImage())),
              const SizedBox(height: 20),
              commonTextFormField(
                  controller: phoneNumber, hintText: 'Phone number'),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: VIN,
                        hintText: 'Vehicle Identification Number (VIN)'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: truckType,
                        hintText: 'Truck Type'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: price,
                        hintText: 'Truck Price *'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: make,
                        hintText: 'Truck Make'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: modelYear,
                        hintText: 'Model Year'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: condition,
                        hintText: 'Condition'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: specs,
                        hintText: 'Regional Specs'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: kilometer,
                        hintText: 'Kilometer'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: enginecapacity,
                        hintText: 'Engine Capacity'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: cylinder,
                        hintText: 'Number of cylinders'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: transmissionType,
                        hintText: 'Transmission Type'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: bodycolor,
                        hintText: 'Body color'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: fuelType,
                        hintText: 'Fuel Type'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: doors,
                        hintText: 'Number of Doors'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: horsePower,
                        hintText: 'Horse Power'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: serviceHistory,
                        hintText: 'Service History'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    commonTextFormField(
                        width: width * 0.43,
                        controller: seats,
                        hintText: 'No. of seats'),
                    commonTextFormField(
                        width: width * 0.43,
                        controller: rimsize,
                        hintText: 'Rim size'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              commonTextFormField(
                  controller: warrenty, hintText: 'Under Warranty'),
              const SizedBox(height: 20),
              commonTextFormField(
                  controller: features, hintText: 'Extra features'),
              const SizedBox(height: 20),
              commonTextFormField(
                  controller: description, hintText: 'Description'),
              const SizedBox(height: 20),
              commonTextFormField(controller: toururl, hintText: 'Tour Url'),
              const SizedBox(height: 20),
              commonTextFormField(
                  controller: youtubeurl, hintText: 'Youtube Url'),
              const SizedBox(height: 20),
              commonTextFormField(
                controller: address,
                readOnly: true,
                hintText: 'Select Address',
                onTap: () async {
                  Map<String, String> data = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoosePickipLocationMap()));
                  print("pickloc.........${data}");
                  address.text = data['address']!;
                  /*storeLat = data['lat']!;
                  storeLon = data['lon']!;*/
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              RoundButton(
                loading: loader,
                borderRadius: 8,
                title: "Post an Ad",
                onTap: () {
                  clickOnPostAnAd();

                },
              ),
            ],
          ),
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
