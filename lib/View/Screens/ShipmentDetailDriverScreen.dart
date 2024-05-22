import 'package:ealaa_userr/Model/ShipmentDetailDriverModel.dart';
import 'package:ealaa_userr/View/Screens/ChoosePickupLocationMap.dart';
import 'package:ealaa_userr/View/Screens/ChooseVehicleScreen.dart';
import 'package:ealaa_userr/View/Screens/IndividualListScreen.dart';
import 'package:ealaa_userr/View/Screens/IndividualOffersScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../Model/CityModel.dart';
import '../../Model/CountryModel.dart';
import '../../Model/VehicleCategoryModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CommonMethods.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../Utils/webService.dart';

class ShipmentDetailDriverScreen extends StatefulWidget {
  const ShipmentDetailDriverScreen({Key? key}) : super(key: key);

  @override
  State<ShipmentDetailDriverScreen> createState() =>
      _ShipmentDetailDriverScreenState();
}

class _ShipmentDetailDriverScreenState
    extends State<ShipmentDetailDriverScreen> {
  bool loader = false;
  String currentTime = "";

  final imgPicker = ImagePicker();
  File? productPicture;

  TextEditingController sendername = TextEditingController();
  TextEditingController reicevername = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController length = TextEditingController();
  TextEditingController widthh = TextEditingController();
  TextEditingController heightt = TextEditingController();
  TextEditingController pickloc = TextEditingController();
  TextEditingController droploc = TextEditingController();
  TextEditingController recieverphone = TextEditingController();
  TextEditingController add1 = TextEditingController();
  TextEditingController add2 = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postalcode = TextEditingController();
  TextEditingController housenumber = TextEditingController();

  String? categoryValue;
  String? cityValue;
  String? cityId;
  String? countryValue;
  String? weightValue = 'gm';
  String? sizeValue = 'cm';
  List<String> weights = ['gm', 'kg'];
  List<String> sizes = ['cm', 'm'];
  List<CountryResult> countryList = [];
  List<CityResult> cityList = [];

//  List<VehicleCategoryResult> vehicleTypes = [];
  String pickLat = '';
  String pickLon = '';
  String dropLat = '';
  String dropLon = '';
  Map<String, dynamic> shipmentData = {};

  ShipmentDetailDriverResult? _shipmentDetailResult;

  getContriesList() async {
    var res = await Webservices.getMap(get_countries);
    print("status from api ${res}");
    final resdata = CountryModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      countryList = resdata.result;
      setState(() {});
      //  createChecker();
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getCitiesList() async {
    var res = await Webservices.getMap(get_city);
    print("status from api ${res}");
    final resdata = CityModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      cityList = resdata.result;
      setState(() {});
      //  createChecker();
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  //
  // getVehiclesList() async
  // {
  //   var res = await Webservices.getMap(get_vehicle_category);
  //   print("status from api ${res}");
  //   final resdata = VehicleCategoryModel.fromJson(res);
  //   print(resdata);
  //   if (resdata.status == '1') {
  //     vehicleTypes = resdata.result;
  //     setState(() {
  //
  //     });
  //     //  createChecker();
  //   } else {
  //     showSnackbar(context, resdata.message);
  //   }
  // }
  currentDate() {
    var now = new DateTime.now();
    var formatter = new DateFormat.MMMEd();
    currentTime = formatter.format(now);
    print(currentTime); // 2016-01-25
  }

  @override
  void initState() {
    currentDate();
    getContriesList();
    getCitiesList();
    // getVehiclesList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            height: height * 0.2,
            width: width,
            color: MyColors.primaryColor,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ParagraphText(
                            text: currentTime,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          MainHeadingText(
                            text: profileResult!.userName == ""
                                ? "hii there!"
                                : profileResult!.userName!,
                            fontSize: 18,
                          )
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: profileResult!.image!,
                          width: 36,
                          height: 36,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Add more containers as needed

          // Positioned Column
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            bottom: 10,
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      sizeBox_mq(context, height: 0.03, width: width),
                      MainHeadingText(
                        text: "Shipment Details",
                        fontSize: 20,
                      ),
                      sizeBox_mq(context, height: 0.03, width: width),
                      GestureDetector(
                          onTap: () {
                            _image_camera_dialog(context);
                          },
                          child: productPicture == null
                              ? Center(child: uploadProductContainer())
                              : Center(child: displayImage())),
                      // sizeBox_mq(context, width: 1, height: 0.02),
                      // CommonWidgets.commonTextFieldForLoginSignUP(
                      //
                      //   title: "Email",
                      //   controller: sendername,
                      //   hintText: "Please enter Email Id",
                      // ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: sendername,
                        hintText: "Sender Name",
                        labelText: "Sender Name",
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: reicevername,
                        hintText: "Reciever name",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextFieldwithoutshadow(
                              width: width * 0.4,
                              controller: weight,
                              hintText: "Weight",
                              labelText: "Name",
                              keyBoardType: TextInputType.number,
                              bgColor: Color(0xffF7F8F8),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: width * 0.4,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF7F8F8),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: weightValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  'gm',
                                  style: GoogleFonts.aBeeZee(
                                      color: MyColors.grey2color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                items: weights.map((String weights) {
                                  return DropdownMenuItem(
                                    value: weights,
                                    child: Text(
                                      weights,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    weightValue = newValue!.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextFieldwithoutshadow(
                              width: width * 0.4,
                              controller: length,
                              hintText: "Length",
                              labelText: "Name",
                              keyBoardType: TextInputType.number,
                              bgColor: Color(0xffF7F8F8),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: width * 0.4,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF7F8F8),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: sizeValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  sizeValue!,
                                  style: GoogleFonts.aBeeZee(
                                      color: MyColors.grey2color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                items: sizes.map((String sizes) {
                                  return DropdownMenuItem(
                                    value: sizes,
                                    child: Text(
                                      sizes,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sizeValue = newValue!.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextFieldwithoutshadow(
                              width: width * 0.4,
                              controller: widthh,
                              hintText: "Width",
                              labelText: "Name",
                              keyBoardType: TextInputType.number,
                              bgColor: Color(0xffF7F8F8),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: width * 0.4,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF7F8F8),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: sizeValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  sizeValue!,
                                  style: GoogleFonts.aBeeZee(
                                      color: MyColors.grey2color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                items: sizes.map((String sizes) {
                                  return DropdownMenuItem(
                                    value: sizes,
                                    child: Text(
                                      sizes,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sizeValue = newValue!.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextFieldwithoutshadow(
                              width: width * 0.4,
                              controller: heightt,
                              hintText: "Height",
                              labelText: "Name",
                              keyBoardType: TextInputType.number,
                              bgColor: Color(0xffF7F8F8),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: width * 0.4,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color(0xffF7F8F8),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                value: sizeValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                hint: Text(
                                  sizeValue!,
                                  style: GoogleFonts.aBeeZee(
                                      color: MyColors.grey2color,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                                isExpanded: true,
                                items: sizes.map((String sizes) {
                                  return DropdownMenuItem(
                                    value: sizes,
                                    child: Text(
                                      sizes,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    sizeValue = newValue!.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      getCountryList(),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      getcityList(),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: pickloc,
                        hintText: "Pickup Location",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                        readonly: true,
                        suffixIcon: 'assets/images/arrow.png',
                        paddingsuffix: 17,
                        onTapsuffix: () async {
                          Map<String, String> data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChoosePickipLocationMap()));
                          print("pickloc.........${data['picklat']}");
                          pickloc.text = data['address']!;
                          pickLat = data['lat']!;
                          pickLon = data['lon']!;
                          setState(() {});
                        },
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: droploc,
                        hintText: "Drop Location",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                        readonly: true,
                        suffixIcon: 'assets/images/arrow.png',
                        paddingsuffix: 17,
                        onTapsuffix: () async {
                          Map<String, String> data = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChoosePickipLocationMap()));
                          print("droplat.........${{data['droplat']}}");
                          droploc.text = data['address']!;
                          dropLat = data['lat']!;
                          dropLon = data['lon']!;
                        },
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: recieverphone,
                        hintText: "Reciever Phone Number",
                        labelText: "Name",
                        keyBoardType: TextInputType.number,
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: add1,
                        hintText: "Address 1",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: add2,
                        hintText: "Address 2 (Optional)",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: postalcode,
                        hintText: "Postal Code",
                        labelText: "Name",
                        keyBoardType: TextInputType.number,
                        bgColor: Color(0xffF7F8F8),
                      ),
                      sizeBox_mq(context, width: 1, height: 0.02),
                      CustomTextFieldwithoutshadow(
                        controller: housenumber,
                        hintText: "House Number",
                        labelText: "Name",
                        bgColor: Color(0xffF7F8F8),
                      ),
                      // sizeBox_mq(context, width: 1, height: 0.02),
                      // getVehicleList(),
                      sizeBox_mq(context, width: 1, height: 0.03),
                      RoundButton(
                          loading: loader,
                          title: "Next",
                          fontsize: 20,
                          onTap: () {
                            if (productPicture == null) {
                              showSnackbar(context, "Add Product Image");
                            } else if (sendername.text == "") {
                              showSnackbar(context, "Enter Sender name");
                            } else if (reicevername.text == "") {
                              showSnackbar(context, "Enter Reciever name");
                            } else if (weight.text == "") {
                              showSnackbar(context, "Enter Weight");
                            } else if (length.text == "") {
                              showSnackbar(context, "Enter Length");
                            } else if (widthh.text == "") {
                              showSnackbar(context, "Enter Width");
                            } else if (heightt.text == "") {
                              showSnackbar(context, "Enter Height");
                            } else if (countryValue == null) {
                              showSnackbar(context, "Enter Country");
                            } else if (cityValue == null) {
                              showSnackbar(context, "Enter City");
                            } else if (pickloc.text == "") {
                              showSnackbar(context, "Choose Pickup Location");
                            } else if (droploc.text == "") {
                              showSnackbar(context, "Choose Drop Location");
                            } else if (recieverphone.text == "") {
                              showSnackbar(
                                  context, "Enter Reciever Phone number");
                            } else {
                              setShipmentData();
                              push(
                                  context: context,
                                  screen: ChooseVehicleScreen(
                                      shipment: shipmentData));
                              //  addDriverShipmentDetails();
                            }
                          }),
                      sizeBox_mq(context, width: 1, height: 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  getCountryList() {
    return Center(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.2))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: countryValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            hint: Text(
              'Choose Country',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            isExpanded: true,
            items: countryList.map((CountryResult items) {
              return DropdownMenuItem(
                value: items.id,
                child: Text(
                  items.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                countryValue = newValue!.toString();
              });
            },
          ),
        ),
      ),
    );
  }

  getcityList() {
    return Center(
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Color(0xffF7F8F8),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.2))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: cityValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            hint: Text(
              'Choose City',
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            isExpanded: true,
            items: cityList.map((CityResult items) {
              return DropdownMenuItem(
                value: items.name,
                child: Text(
                  items.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  cityId = items.id;
                  print('city id is.........$cityId');
                  setState(() {});
                },
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                cityValue = newValue.toString();
                setState(() {});
              });
            },
          ),
        ),
      ),
    );
  }

  // getVehicleList() {
  //   return Center(
  //     child: Container(
  //       height: 50,
  //       width: MediaQuery.of(context).size.width,
  //       padding: EdgeInsets.symmetric(horizontal: 10),
  //       decoration: BoxDecoration(
  //           color: Color(0xffF7F8F8), borderRadius: BorderRadius.circular(8)),
  //       child: DropdownButtonHideUnderline(
  //         child: DropdownButton(
  //           value: categoryValue,
  //           icon: const Icon(Icons.keyboard_arrow_down),
  //           hint: Text(
  //             'Choose vehicle',
  //             style: GoogleFonts.aBeeZee(
  //                 color: MyColors.grey2color,
  //                 fontSize: 14,
  //                 fontWeight: FontWeight.w400),
  //           ),
  //           isExpanded: true,
  //           items: vehicleTypes.map((VehicleCategoryResult items) {
  //             return DropdownMenuItem(
  //               value: items.vehiclesCategoryId,
  //               child: Text(
  //                 items.vehiclesCategoryName,
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 16,
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //           onChanged: (newValue) {
  //             setState(() {
  //               categoryValue = newValue!.toString();
  //               print("categoryValue-----------------${newValue}");
  //             });
  //           },
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  void setShipmentData() {
    shipmentData = {
      'shipment_details_users_id': userId,
      'shipment_details_sender_name': sendername.text,
      'shipment_details_receiver_name': reicevername.text,
      'shipment_details_weight': weight.text,
      'shipment_details_weight_unit': weightValue,
      'shipment_details_length': length.text,
      'shipment_details_width': widthh.text,
      'shipment_details_height': heightt.text,
      'shipment_details_size_unit': sizeValue,
      'shipment_details_pick_location': pickloc.text,
      'shipment_details_drop_location': droploc.text,
      'shipment_details_receiver_phone_number': recieverphone.text,
      'shipment_details_receiver_address_1': add1.text,
      'shipment_details_receiver_address_2': add2.text,
      'shipment_details_receiver_country': countryValue,
      'shipment_details_receiver_city': cityValue,
      'city': cityId,
      'shipment_details_receiver_postal_code': postalcode.text,
      'shipment_details_receiver_house_no': housenumber.text,
      'vehicle_id': categoryValue,
      'shipment_pick_lat': pickLat,
      'shipment_pick_lon': pickLon,
      'shipment_drop_lan': dropLat,
      'shipment_drop_lon': dropLon,
      'shipment_details_photo': productPicture,
    };
  }
}
