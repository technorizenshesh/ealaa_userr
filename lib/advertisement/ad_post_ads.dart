import 'dart:io';

import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../Model/advertisement_model/get_landlord_model.dart';
import '../View/Screens/ChoosePickupLocationMap.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CommonMethods.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';
import '../common/common_widgets.dart';

class AdPostAds extends StatefulWidget {
  const AdPostAds({super.key});

  @override
  State<AdPostAds> createState() => _AdMyAdsState();
}

class _AdMyAdsState extends State<AdPostAds> {
  bool loader = false;
  String currentTime = "";

  final imgPicker = ImagePicker();
  File? productPicture;

  TextEditingController search = TextEditingController();
  TextEditingController bedroom = TextEditingController();
  TextEditingController tourUrl = TextEditingController();
  TextEditingController youtubeUrl = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController describeYourProperty = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController totalClosingFee = TextEditingController();
  TextEditingController developer = TextEditingController();
  TextEditingController readyBy = TextEditingController();
  TextEditingController propertyReferenceId = TextEditingController();
  TextEditingController buyerTransferFee = TextEditingController();
  TextEditingController sellerTransferFee = TextEditingController();
  TextEditingController listedBy = TextEditingController();
  TextEditingController categories = TextEditingController();
  TextEditingController zonedFor = TextEditingController();
  TextEditingController maintenanceFee = TextEditingController();
  TextEditingController occupancyStatus = TextEditingController();
  TextEditingController building = TextEditingController();
  TextEditingController locateYourProperties = TextEditingController();
  TextEditingController address = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;
  String selectedCategory = '';
  String selectedListedBy = '';
  String selectedOccupancyStatus = '';
  String selectedZonedFor = '';

  List<GetLandLordResult> getLandLordResult = [];
  List<GetLandLordResult> getOccupancyStatusResult = [];
  List<GetLandLordResult> zonedForResult = [];

  List<GetAdsWithCategoryHomeResult> getAdvertisementCategoryResult = [];

  getLandlordApi() async {
    var res = await Webservices.getMap("$baseUrl$get_landlord");
    print("status from api ${res}");
    final resdata = GetLandLordModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getLandLordResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getOccupancyStatusApi() async {
    var res = await Webservices.getMap("$baseUrl$get_occupancy_status");
    print("status from api ${res}");
    final resdata = GetLandLordModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getOccupancyStatusResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getRetailApi() async {
    var res = await Webservices.getMap("$baseUrl$get_retail");
    print("status from api ${res}");
    final resdata = GetLandLordModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      zonedForResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  getAdvertisementCategoryApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    final resdata = GetAdsWithCategoryHomeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdvertisementCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  @override
  void initState() {
    getLandlordApi();
    getOccupancyStatusApi();
    getRetailApi();
    getAdvertisementCategoryApi();
    super.initState();
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
          'Post an Ad', // Your badge count here
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
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Property for Sale > Multiple units for Sale',
                  style: TextStyle(fontSize: 12, color: Colors.orange),
                ),
              ),
              const SizedBox(height: 10),
              commonTextFormField(controller: bedroom, hintText: '1 Bedroom'),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    _image_camera_dialog(context);
                  },
                  child: productPicture == null
                      ? Center(child: uploadProductContainer())
                      : Center(child: displayImage())),
              /*const SizedBox(height: 10),
              InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.orange,
                      width: 1,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, color: Colors.orange),
                          SizedBox(
                            width: 20,
                          ),
                          Text('Add Pictures',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                  color: Colors.orange))
                        ]),
                  ),
                ),
              ),*/
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: tourUrl, hintText: '360 Tour URL'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: youtubeUrl, hintText: 'YouTube URL'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: phoneNumber, hintText: 'Phone Number'),
              const SizedBox(height: 10),
              commonTextFormField(controller: price, hintText: 'Price'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: describeYourProperty,
                  hintText: 'Describe your Property',
                  maxLines: 7),
              const SizedBox(height: 10),
              commonTextFormField(controller: size, hintText: 'Size'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: totalClosingFee, hintText: 'Total Closing fee'),
              const SizedBox(height: 10),
              commonTextFormField(controller: developer, hintText: 'Developer'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: readyBy, hintText: 'Ready By (YYYY-MM-DD)'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: propertyReferenceId,
                  hintText: 'Property Reference ID #'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: buyerTransferFee, hintText: 'Buyer Transfer Fee'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: sellerTransferFee,
                  hintText: 'Seller Transfer Fee'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: maintenanceFee, hintText: 'Maintenance Fee'),
              const SizedBox(height: 10),
              commonTextFormField(
                controller: categories,
                hintText: 'Categories',
                readOnly: true,
                suffixIcon: true,
                onTap: () => clickOnCategories(),
              ),
              const SizedBox(height: 10),
              commonTextFormField(
                controller: listedBy,
                hintText: 'Listed By',
                readOnly: true,
                suffixIcon: true,
                onTap: () => clickOnListedBy(),
              ),
              const SizedBox(height: 10),
              commonTextFormField(
                controller: zonedFor,
                hintText: 'Zoned for',
                readOnly: true,
                suffixIcon: true,
                onTap: () => clickOnZonedFor(),
              ),
              const SizedBox(height: 10),
              commonTextFormField(
                controller: occupancyStatus,
                hintText: 'Occupancy Status',
                readOnly: true,
                suffixIcon: true,
                onTap: () => clickOnOccupancyStatus(),
              ),
              const SizedBox(height: 10),
              commonTextFormField(controller: building, hintText: 'Building'),
              const SizedBox(height: 10),
              commonTextFormField(
                  controller: locateYourProperties,
                  hintText: 'Locate your properties'),
              const SizedBox(height: 10),
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
              const SizedBox(height: 10),
              const Text(
                'Is the pin in the right location?',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Click and drag the pin to the exact spot. Users are more likely to respond to ads that are correctly shown on the map.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: width - 32,
                child: Center(
                  child: RoundButton(
                    loading: loader,
                    borderRadius: 8,
                    title: "Post an Ad",
                    onTap: () => clickOnPostAnAd(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  clickOnPostAnAd() async {
    if (bedroom.text.trim().isNotEmpty &&
        tourUrl.text.trim().isNotEmpty &&
        youtubeUrl.text.trim().isNotEmpty &&
        phoneNumber.text.trim().isNotEmpty &&
        price.text.trim().isNotEmpty &&
        describeYourProperty.text.trim().isNotEmpty &&
        size.text.trim().isNotEmpty &&
        totalClosingFee.text.trim().isNotEmpty &&
        developer.text.trim().isNotEmpty &&
        readyBy.text.trim().isNotEmpty &&
        propertyReferenceId.text.trim().isNotEmpty &&
        buyerTransferFee.text.trim().isNotEmpty &&
        sellerTransferFee.text.trim().isNotEmpty &&
        listedBy.text.trim().isNotEmpty &&
        zonedFor.text.trim().isNotEmpty &&
        maintenanceFee.text.trim().isNotEmpty &&
        occupancyStatus.text.trim().isNotEmpty &&
        building.text.trim().isNotEmpty &&
        locateYourProperties.text.trim().isNotEmpty &&
        productPicture != null) {
      Map<String, dynamic> data = {
        'user_id': userId,
        'bedroom': bedroom.text,
        'tour_url_360': tourUrl.text,
        'youtube_url': youtubeUrl.text,
        'phone_number': phoneNumber.text,
        'price': price.text,
        'describe_property': describeYourProperty.text,
        'size': size.text,
        'total_closing_fee': totalClosingFee.text,
        'developer': developer.text,
        'ready_by': readyBy.text,
        'advertisement_category_id': selectedCategory,
        'property_reference_id': propertyReferenceId.text,
        'buyer_transfer_fee': buyerTransferFee.text,
        'seller_transfer_fee': sellerTransferFee.text,
        'landlord': listedBy.text,
        'retail': zonedFor.text,
        'maintenance_fee': maintenanceFee.text,
        'occupancy_status': occupancyStatus.text,
        'building': building.text,
        'locate_property': locateYourProperties.text,
        'location_pin': address.text,
      };
      Map<String, dynamic> files = {'image': productPicture};
      print("request ------------------$data   $files");
      loader = true;
      setState(() {});
      var res = await Webservices.postDataWithImageFunction(
          body: data,
          files: files,
          context: context,
          apiUrl: '${baseUrl}add_advertisement_posts?');
      GetAdsWithCategoryHomeModel getAdvertisementCategoryModel =
      GetAdsWithCategoryHomeModel.fromJson(res);
      if (getAdvertisementCategoryModel.result != null &&
          getAdvertisementCategoryModel.result!.isNotEmpty) {
        bedroom.text = '';
        tourUrl.text = '';
        youtubeUrl.text = '';
        phoneNumber.text = '';
        price.text = '';
        describeYourProperty.text = '';
        size.text = '';
        totalClosingFee.text = '';
        developer.text = '';
        readyBy.text = '';
        propertyReferenceId.text = '';
        buyerTransferFee.text = '';
        sellerTransferFee.text = '';
        listedBy.text = '';
        zonedFor.text = '';
        maintenanceFee.text = '';
        occupancyStatus.text = '';
        building.text = '';
        locateYourProperties.text = '';
        productPicture = null;
      }
      loader = false;
      setState(() {});
      showSnackbar(context, 'Successfully uploaded');
    } else {
      showSnackbar(context, 'All field required!');
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

  clickOnCategories() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Category',
                  style: GoogleFonts.openSans(color: Colors.grey, fontSize: 24),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getAdvertisementCategoryResult.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.orange,
                        title: Text(
                            getAdvertisementCategoryResult[index].name ?? ''),
                        subtitle: Text(
                            getAdvertisementCategoryResult[index].dateTime ??
                                ''),
                        value: getAdvertisementCategoryResult[index].id ?? '',
                        groupValue: selectedCategory,
                        onChanged: (String? value) {
                          setState(() {
                            categories.text =
                                getAdvertisementCategoryResult[index].name ??
                                    '';
                            selectedCategory = value ?? '';
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  clickOnListedBy() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Listed By',
                  style: GoogleFonts.openSans(color: Colors.grey, fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getLandLordResult.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.orange,
                        title: Text(getLandLordResult[index].name ?? ''),
                        subtitle: Text(getLandLordResult[index].dateTime ?? ''),
                        value: getLandLordResult[index].id ?? '',
                        groupValue: selectedListedBy,
                        onChanged: (String? value) {
                          setState(() {
                            listedBy.text = getLandLordResult[index].name ?? '';
                            selectedListedBy = value ?? '';
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  clickOnOccupancyStatus() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select occupancy status',
                  style: GoogleFonts.openSans(color: Colors.grey, fontSize: 24),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getOccupancyStatusResult.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.orange,
                        title: Text(getOccupancyStatusResult[index].name ?? ''),
                        subtitle: Text(
                            getOccupancyStatusResult[index].dateTime ?? ''),
                        value: getOccupancyStatusResult[index].id ?? '',
                        groupValue: selectedOccupancyStatus,
                        onChanged: (String? value) {
                          setState(() {
                            occupancyStatus.text =
                                getOccupancyStatusResult[index].name ?? '';
                            selectedOccupancyStatus = value ?? '';
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  clickOnZonedFor() {
    showModalBottomSheet(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select zoned for',
                  style: GoogleFonts.openSans(color: Colors.grey, fontSize: 24),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: zonedForResult.length,
                    itemBuilder: (context, index) {
                      return RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        activeColor: Colors.orange,
                        title: Text(zonedForResult[index].name ?? ''),
                        subtitle: Text(zonedForResult[index].dateTime ?? ''),
                        value: zonedForResult[index].id ?? '',
                        groupValue: selectedZonedFor,
                        onChanged: (String? value) {
                          setState(() {
                            zonedFor.text = zonedForResult[index].name ?? '';
                            selectedZonedFor = value ?? '';
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
