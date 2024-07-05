import 'package:ealaa_userr/Model/GetNearbyDriversModel.dart';
import 'package:ealaa_userr/View/Screens/web_view_screen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../Model/ShipmentDetailDriverModel.dart';
import '../../Model/VehicleCategoryModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class ChooseVehicleScreen extends StatefulWidget {
  final Map<String,dynamic> shipment;

  const ChooseVehicleScreen({
    Key? key,
    required this.shipment,
  }) : super(key: key);

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  TextEditingController name = TextEditingController();
  String? selectedVehicle;
  List<VehicleCategoryResult> vehicleTypes = [];
  bool loader = false;
  List<GetNearbyDriversResult> driversList = [];
  List<LatLng> driversLatLonList = [];

  ShipmentDetailDriverResult? _shipmentDetailResult;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  static LatLng _initialPosition = LatLng(currentLat, currentLong);
//  LatLng _currentPosition = _initialPosition;

  getVehiclesList() async {
    var res = await Webservices.getMap(
        "${get_vehicle_category}?picuplat=${widget.shipment['shipment_pick_lat']}&pickuplon=${widget
        .shipment['shipment_pick_lon']}&droplat=${widget.shipment['shipment_drop_lan']}${widget
            .shipment['shipment_drop_lon']}&user_id=${userId}");
    print("status from api ${res}");
    final resdata = VehicleCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      vehicleTypes = resdata.result;
      //  selectedVehicle = vehicleTypes[0].vehiclesCategoryId;
      print("vehicles are............${vehicleTypes[0]}");
      //   openTrackOrder();
      setState(() {});
      //  createChecker();
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  getNearbyDrivers() async {
    driversLatLonList.clear();
    setState(() {});
    Map<String, dynamic> data = {
      "lat": currentLat.toString(),
      "lon": currentLong.toString()
    };
    var res = await Webservices.postData(
        apiUrl: "$get_nearby_drivers", body: data, context: context);
    print("status from api ${res}");
    final resdata = GetNearbyDriversModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      driversList = resdata.result;
      for (int i = 0; i < driversList.length; i++) {
        driversLatLonList.add(
          LatLng(double.parse(driversList[i].lat),
              double.parse(driversList[i].lon)),
        );
      }
      _getOtherVehiclesLocations();
    } else {}
  }

  addDriverShipmentDetails() async {
    Map<String, dynamic> data = {
      'shipment_details_users_id': userId,
      'shipment_details_sender_name': widget.shipment['shipment_details_sender_name'],
      'shipment_details_receiver_name': widget.shipment['shipment_details_receiver_name'],
      'shipment_details_weight': widget.shipment['shipment_details_weight'],
      'shipment_details_weight_unit': widget.shipment['shipment_details_weight_unit'],
      'shipment_details_length': widget.shipment['shipment_details_length'],
      'shipment_details_width': widget.shipment['shipment_details_width'],
      'shipment_details_height': widget.shipment['shipment_details_height'],
      'shipment_details_size_unit': widget.shipment['shipment_details_size_unit'],
      'shipment_details_pick_location': widget.shipment['shipment_details_pick_location'],
      'shipment_details_drop_location': widget.shipment['shipment_details_drop_location'],
      'shipment_details_receiver_phone_number': widget.shipment['shipment_details_receiver_phone_number'],
      'shipment_details_receiver_address_1': widget.shipment['shipment_details_receiver_address_1'],
      'shipment_details_receiver_address_2': widget.shipment['shipment_details_receiver_address_2'],
      'shipment_details_receiver_country': widget.shipment['shipment_details_receiver_country'],
      'shipment_details_receiver_city': widget.shipment['shipment_details_receiver_city'],
      'city': widget.shipment['shipment_details_receiver_city'],
      'shipment_details_receiver_postal_code': widget.shipment['shipment_details_receiver_postal_code'],
      'shipment_details_receiver_house_no': widget.shipment['shipment_details_receiver_house_no'],
      'vehicle_id': selectedVehicle,
      'shipment_pick_lat': widget.shipment['shipment_pick_lat'],
      'shipment_pick_lon': widget.shipment['shipment_pick_lon'],
      'shipment_drop_lan': widget.shipment['shipment_drop_lan'],
      'shipment_drop_lon': widget.shipment['shipment_drop_lon']
    };
    Map<String, dynamic> files = {'shipment_details_photo': widget.shipment['shipment_details_photo']};
    print("request ------------------$data   $files");
    loader = true;
    setState(() {});
    var res = await Webservices.postDataWithImageFunction(
        body: data,
        files: files,
        context: context,
        apiUrl: '${baseUrl}insert_shipment_driver?');

    setState(() {
      loader = false;
    });
    print("res from api ------------------$res");
    final resdata = ShipmentDetailDriverModel.fromJson(res);

    if (resdata.status == '1') {
      _shipmentDetailResult = resdata.result;
      String dimension =
          "${_shipmentDetailResult!.shipmentDetailsLength}${_shipmentDetailResult!.shipmentDetailsSizeUnit} * ${_shipmentDetailResult!.shipmentDetailsWidth}${_shipmentDetailResult!.shipmentDetailsSizeUnit} * ${_shipmentDetailResult!.shipmentDetailsHeight}${_shipmentDetailResult!.shipmentDetailsSizeUnit}";
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) =>IndividualOffersScreen(shipmentId: _shipmentDetailResult!.shipmentDetailsId, name:_shipmentDetailResult!.shipmentDetailsSenderName, recieverName:_shipmentDetailResult!.shipmentDetailsReceiverName, postalcode: _shipmentDetailResult!.shipmentDetailsReceiverPostalCode, recieverNumber:_shipmentDetailResult!.shipmentDetailsReceiverPhoneNumber, dimension: dimension, weight:"${_shipmentDetailResult!.shipmentDetailsWeight}${_shipmentDetailResult!.shipmentDetailsWeightUnit}", address: _shipmentDetailResult!.shipmentDetailsDropLocation, proImage: _shipmentDetailResult!.shipmentDetailsPhoto, amount: _shipmentDetailResult!.companyAmount,),
      //     ),
      //         (route) => false);
      String url =
          'https://11way.solutions/webservice/payment?amount=100&user_id=$userId&shipment_id=${_shipmentDetailResult!.shipmentDetailsId}&name=${_shipmentDetailResult!.shipmentDetailsSenderName}';
      print("url::::::::::::::::::::::$url");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewScreen(
                url: url,
                shipmentId: _shipmentDetailResult!.shipmentDetailsId, type: 'Individual',shipmentDetailResult: _shipmentDetailResult,),
          ));
      // Navigator.pushReplacement(
      //     context,
      //     CupertinoPageRoute(
      //         builder: (context) => IndividualOffersScreen(
      //               shipmentId: _shipmentDetailResult!.shipmentDetailsId,
      //               name: _shipmentDetailResult!.shipmentDetailsSenderName,
      //               recieverName:
      //                   _shipmentDetailResult!.shipmentDetailsReceiverName,
      //               postalcode: _shipmentDetailResult!
      //                   .shipmentDetailsReceiverPostalCode,
      //               recieverNumber: _shipmentDetailResult!
      //                   .shipmentDetailsReceiverPhoneNumber,
      //               dimension: dimension,
      //               weight:
      //                   "${_shipmentDetailResult!.shipmentDetailsWeight}${_shipmentDetailResult!.shipmentDetailsWeightUnit}",
      //               address: _shipmentDetailResult!.shipmentDetailsDropLocation,
      //               proImage: _shipmentDetailResult!.shipmentDetailsPhoto,
      //               amount: _shipmentDetailResult!.companyAmount,
      //             )));
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    _markers.add(Marker(
      //add start location marker
      markerId: MarkerId(currentLat.toString()),
      position: _initialPosition, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    getVehiclesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20),
        child: RoundButton(
          loading: loader,
          title: "Confirm",
          onTap: () {
            if (selectedVehicle == null) {
              showSnackbar(context, "Please select a vehicle first");
            } else {
              _showConfirmDialog(context);
            }
          },
        ),
      ),
      body: Stack(
        children: [
          mapContainer(),
          //VehicleMapScreen(),
          Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight:
                          Radius.circular(30) // Adjust the radius as needed
                      ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                height: MediaQuery.of(context).size.height * 0.35,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    MainHeadingText(
                      text: 'Select Type',
                      fontSize: 18,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < vehicleTypes.length; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedVehicle =
                                        vehicleTypes[i].vehiclesCategoryId;
                                    //_getOtherVehiclesLocations();
                                    getNearbyDrivers();
                                    print(
                                        "selected vehicle id.........$selectedVehicle");
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: selectedVehicle ==
                                                  vehicleTypes[i]
                                                      .vehiclesCategoryId
                                              ? MyColors.primaryColor
                                              : Colors.grey,
                                          width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width*0.25,child: SvgPicture.network(vehicleTypes[i].image)),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vehicleTypes[i]
                                                .vehiclesCategoryName,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: selectedVehicle ==
                                                        vehicleTypes[i]
                                                            .vehiclesCategoryId
                                                    ? MyColors.primaryColor
                                                    : Colors.grey),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${vehicleTypes[i].amount} \$",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: selectedVehicle ==
                                                        vehicleTypes[i]
                                                            .vehiclesCategoryId
                                                    ? MyColors.primaryColor
                                                    : Colors.grey),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.only(right: 15),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Image.asset(
                      "assets/images/delivery5 [Converted] 1.png",
                      height: 120,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }

  void _getOtherVehiclesLocations() {
    // Simulated list of other car locations.
    // List<LatLng> otherCarLocations = [
    //   LatLng(22.9676, 76.0534),
    //   LatLng(22.5981, 75.3040),
    //   LatLng(22.7533, 75.8937),
    // ];

    for (int i = 0; i < driversLatLonList.length; i++) {
      LatLng carPosition = driversLatLonList[i];
      print("cars...............${driversLatLonList[i]}");
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          devicePixelRatio: 2,
        ),
        'assets/images/Truck@2x.png', // Replace with your custom marker image path
      ).then((BitmapDescriptor customIcon) {
        setState(() {
          print(": 1 :");
          _markers.add(
            Marker(
              markerId: MarkerId('custom_marker car_$i}'),
              position: carPosition, // Custom marker position
              icon: customIcon,
              infoWindow: InfoWindow(title: '${driversList[i].drFullName}'),
            ),
          );
          print("length of marker --------${_markers.length}");
          // setState(() {
        });
      });
      // _markers.add(
      //   Marker(
      //     markerId: MarkerId("car_$i"),
      //     position: carPosition,
      //     infoWindow: const InfoWindow(
      //       //popup info
      //       title: 'end Point ',
      //       snippet: 'Start Marker',
      //     ),
      //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      //   ),
      // );
    }
  }

  mapContainer() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: _initialPosition,
        zoom: 10.0,
      ),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _markers,
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text(
            "Do you want to confirm this Shipment?\n Payment required before confirming the shipment",
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("No",
                  style: TextStyle(
                      fontSize: 18,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      fontSize: 18,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.of(context).pop();
                addDriverShipmentDetails();
              },
            ),
          ],
        );
      },
    );
  }
}
