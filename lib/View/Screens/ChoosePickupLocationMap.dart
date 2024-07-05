import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/CustomSnackBar.dart';

class ChoosePickipLocationMap extends StatefulWidget {
  const ChoosePickipLocationMap({super.key});

  @override
  State<ChoosePickipLocationMap> createState() => _ChoosePickipLocationMapState();
}

class _ChoosePickipLocationMapState extends State<ChoosePickipLocationMap> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng? _tappedLocation;
  Set<Marker> _markers = {};
  Position? _currentPosition;
  String currentAddress1="";
  double lat = 0;
  double lon = 0;
  bool buttonVisibility = false;

  @override
  void initState() {
    getValidationData();
    setState(() {

    });
    super.initState();
  }
  getValidationData() async {
    await _getCurrentLocation();
    getAddress();
  }

  Future<Position> _getCurrentLocation() async {
    bool isPermissionGranted = await requestPermission();
    print(isPermissionGranted);
    if (isPermissionGranted) {
      // setState(() async{
      _currentPosition = await Geolocator.getCurrentPosition();
      lat = _currentPosition!.latitude;
      lon = _currentPosition!.longitude;
      _addMarker(LatLng(lat, lon));
      return _currentPosition!;
    } else {
      throw requestPermission();    }
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: appBar(context: context, title: "Order Review".tr),
        body:
        _currentPosition==null?
                Padding(padding: EdgeInsets.only(top: 50),
                    child:LinearProgressIndicator(color:
                MyColors.primaryColor,)) :
       Container(
          width: width,
          child: Container(
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      children: [
                        Container(
                            width:width,
                            height: height*0.75,
                            child:
                            Stack(
                              children: [
                                GoogleMap(
                                  zoomControlsEnabled: false,
                                  mapType: MapType.normal,
                                  //  markers: controller.markers,
                                  // onCameraMove: controller.onCameraMove,
                                  markers: _markers,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(lat, lon),
                                    zoom: 20,),
                                  onMapCreated: (GoogleMapController controller){
                                    _controller.complete(controller);
                                    moveCameraToMarker();
                                  },
                                  myLocationEnabled: true,
                                  onTap: _onMapTapped,
                                  // onCameraIdle: () async {
                                  //   controller.getMoveCamera();
                                  // },
                                ),
                                // Image.asset('assets/images/mapsImage.png',width:width,
                                //   height: height*0.5,),
                              ],
                            )),
                        ListTile(
                          titleAlignment: ListTileTitleAlignment.top,
                          leading: Icon(Icons.location_on_outlined,color:
                          MyColors.primaryColor,size: 30,),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MainHeadingText(
                                text: 'Current Address',
                                fontSize: 18,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              currentAddress1==null?Container():
                              ParagraphText(
                                text: currentAddress1,
                                color: Colors.black,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  // Container(
                  //   width: width,
                  //   height: height,
                  //   child: Align(
                  //     alignment: Alignment.topCenter,
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         SvgPicture.asset('assets/images/LeftArrowIcon.svg'),
                  //         Container(
                  //             height: height * 0.2,
                  //             width: width*0.5,
                  //             child: Image.asset(
                  //               'assets/images/GoldBuiscuitImg.png',
                  //               fit: BoxFit.fill,
                  //             )),
                  //         SvgPicture.asset('assets/images/RightArrowIcon.svg'),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ),
                Visibility(
                    visible:currentAddress1.isEmpty?false:true,
                    child:
                Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: width - 40,
                        padding: EdgeInsets.only(bottom: 10),
                        child:
                        RoundButton(
                          title: 'Save',
                          onTap: () {
                            if(currentAddress1==null){
                              showSnackbar(context, "address not found");
                            }
                            else{
                              Map<String,String>data={
                                'address':currentAddress1,
                                'lat': lat.toString(),
                                'lon':lon.toString()
                              };
                              Navigator.pop(context,data);
                            }

                          },
                          fontsize: 16,
                          fontweight: FontWeight.w700,
                        ),
                        // CustomButton(
                        //   text: "CONFIRM ADDRESS".tr,
                        //   width: width - 40,
                        //   onTap: () {
                        //     currentAddress==null?showSnackbar(context, "address not found"):
                        //     Navigator.pushReplacement(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) => OrderReview(selectedGold: widget.selectedGold,)));
                        //   },
                        // ),
                      ),
                    )))

              ],
            ),
          ),
        ));
  }
  void _onMapTapped(LatLng location) {
    setState(() {
      _tappedLocation = location;
      lat = _tappedLocation!.latitude;
      lon = _tappedLocation!.longitude;
      _addMarker(location);
      getAddress();
      setState(() {});
      print("current lat is...$lat");
    });
  }
  void _addMarker(LatLng location) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker_id'),
          position: location,
          //Icons.location_on_sharp
        ),
      );
    });
  }
  getAddress() async {
    print("call get address...");
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat,
          lon);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        currentAddress1 = '${placemark.street}, ${placemark.locality}, '
            '${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}';
        print("address is....$currentAddress1")  ;
        setState(() {
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void moveCameraToMarker() async {
    if (_controller.isCompleted) {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(lat, lon)),
      );
    }
  }

}
