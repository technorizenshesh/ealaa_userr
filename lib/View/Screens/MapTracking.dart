  import 'dart:async';
import 'package:ealaa_userr/Model/GetDriverLatLonModel.dart';
import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/View/Utils/MySizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as webservice;
import 'dart:math';
import 'package:location/location.dart' as loct;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Utils/ApiConstants.dart';
import '../Utils/location.dart';
import '../Utils/webService.dart';



class GoogleMapService extends StatefulWidget {
  const GoogleMapService({Key? key}) : super(key: key);

  @override
  State<GoogleMapService> createState() => _GoogleMapServiceState();
}

class _GoogleMapServiceState extends State<GoogleMapService> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool drawerOpen = true;
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  Set<Polyline> _polylines = {};
//  static LatLng _initialPosition = LatLng(currentLat, currentLong);
  static LatLng _initialPosition = BookingPickLat==""?LatLng(currentLat, currentLong)
      :LatLng(double.parse
    (BookingPickLat), double.parse(BookingPickLong));
  LatLng? driverPosition;
  GetDriverLatLonResult? driverLatLonResult;
  // ignore: non_constant_identifier_names
//   String? Location;
//   String? stopLocation;
//   int pline=0;
//   String googleApikey = 'AIzaSyCjm3GS5HaNLYXnxqqF_IhsufMpQgcx8T0';
//   GoogleMapController? mapController; //contrller for Google map
//   CameraPosition? cameraPosition;
//   LatLng startLocation =  LatLng(22.234,75.24546);
//   LatLng? endLocation;
//   double distance = 0.0;
//   double price = 0.0;
//   double priceConfort = 0.0;
//   String location = "Select Destination";
//   PolylinePoints polylinePoints = PolylinePoints();
//   Set<Marker> markers = {}; //markers for google map
//   Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
//
//   Position? position;
//
//
//
//
//   getData()async{
//     setState(() {
//     });
//     await getCurrentLocation();
//     // currentAddress= await getCurrentAddress();
//     setState(() {
//     });
//     // getCurrentLocation();
//   }
//   var savedUid, savedtoken;
//   int getlat=0;
//   getUserProfileData() async {
//     try{
//       Map<String, dynamic> data = {
//         "driver_id": DriverId,
//       };
//       print("url-------${getDriverLatLong}");
//       var res = await Webservices.getMap("{getDriverLatLong}?driver_id=$DriverId");
//       if(res['status'].toString()=='1'){
//         getlat++;
//
//         print('Delayed action after 2 seconds');
//         BitmapDescriptor.fromAssetImage(
//           ImageConfiguration(devicePixelRatio: 2.5),
//           'mailto:assets/images/truck@2x.png', // Replace with your custom marker image path
//         ).then((BitmapDescriptor customIcon) {
//           setState(() {
//             print("ccc : $getlat :");
//
//             markers.add(
//               Marker(
//                 markerId: MarkerId('drver_marker'),
//                 position: LatLng(double.parse(res['result']['lat'].toString()), double.parse(res['result']['lon'].toString())), // Custom marker position
//                 icon: customIcon,
//                 // infoWindow: InfoWindow(title: '${latlong.toString()}'),
//               ),
//             );
//             print("length of marker --------${markers.length}");
//             // setState(() {
//
//           });});
//         if(getlat==1){
//           getDirections(LatLng(double.parse(res['result']['lat']),double
//               .parse(res['result']['long'])), LatLng(double.parse
//             (BookingDropLat),double.parse(BookingDropLong)));
//         }
//         else {
//
//           getDirections2(LatLng(double.parse(res['result']['lat']),double
//               .parse(res['result']['long'])), LatLng(double.parse
//             (BookingDropLat),double.parse(BookingDropLong)));
//         }
//
//
//
//       }
//       else {
//         showSnackbar(context, 'resdata.message');
//       }
//     }catch(err){}
//   }
//   @override
//   void initState() {
//
//     getData();
//
//     getUserPosition().then((position) {
//       startLocation = LatLng(position.latitude, position.longitude);
//       markers.add(Marker(
//         //add start location marker
//         markerId: MarkerId(startLocation.toString()),
//         position: startLocation, //position of marker
//         infoWindow: const InfoWindow(
//           //popup info
//           title: 'Starting Point ',
//           snippet: 'Start Marker',
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(100), //Icon for Marker
//       ));
//     });
//
//     // if(BookingStatus=="Approve"){
//     Timer.periodic(Duration(seconds: 10), (timer) async {
//       getUserProfileData();
//
//     });
//
//     // }
//
//     //fetch direction polylines from Google API
//
//     super.initState();
//   }
//
//   Future<Position> getUserPosition() async {
//     return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//   }
//   loct.LocationData? currentLocation;
//   getCurrentLocation()async{
//     loct.Location location=loct.Location();
//     location.getLocation().then((location) async {
//       currentLocation = location;
//       print("location---------------$location");
//       print("location---------------${currentLocation!.latitude!}");
//       print("location---------------${currentLocation!.longitude!}");
//       List<Placemark> placemarks =
//       await placemarkFromCoordinates(
//           currentLocation!.latitude!,currentLocation!.longitude!);
//       var placemarkaddress = placemarks;
//       print("placemarksmapsearch   ${placemarks}");
//       print("placemarks   ${placemarks[0].administrativeArea}");
//       currentAddress='${placemarks[0].street??""}, ${placemarks[0].name??""} '
//           '${placemarks[0].subLocality??""} ,${placemarks[0].locality??""}';
//
//     });
//     location.changeSettings(accuracy: loct.LocationAccuracy.navigation,interval: 8000,distanceFilter: 5);
//     location.onLocationChanged.listen((newloc) {
//       currentLocation=newloc;
//       if(polyline!=null&&startLocation!=null&&endLocation!=null){
//         print("location---------------${currentLocation!.latitude!}");
//         print("location---------------${currentLocation!.longitude!}");
//         LatLng startLocation2 =  LatLng(currentLocation!.latitude!,currentLocation!.longitude!);
//
//         getDirections2(startLocation2,endLocation!);
//       }
//       else{
//       }
//       setState(() {
//
//       });
//     });
//   }
//   getDirections(LatLng from, LatLng to) async {
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApikey,
//       PointLatLng(from.latitude, from.longitude),
//       PointLatLng(to.latitude, to.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     } else {
//       print(result.errorMessage);
//     }
//     double totalDistance = 0;
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       // totalDistance += calculateDistance(
//       //     polylineCoordinates[i].latitude,
//       //     polylineCoordinates[i].longitude,
//       //     polylineCoordinates[i + 1].latitude,
//       //     polylineCoordinates[i + 1].longitude);
//     }
//     print(from);
//     print(to);
//     print("Distance");
//
// // https://api.distancematrix.ai/distancematrix?origins=51.4822656,-0.1933769&destinations=51.4994794,-0.1269979&key=<your_access_token>
//
//     print(totalDistance);
//     double distanceInMeters = Geolocator.distanceBetween(
//         from.latitude, from.longitude, to.latitude, to.longitude);
//
//     print(distanceInMeters);
//
//     setState(() {
//       distance = totalDistance;
//       // price = totalDistance * pricePerKilometer;
//       // priceConfort = totalDistance * pricePerKilometerConfort;
//     });
//     print("price");
//
//     print(price);
//     print("priceConfort");
//
//     print(priceConfort);
//
//     addPolyLine(polylineCoordinates);
//   }
//   newgetDirections(LatLng from, LatLng to) async {
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       googleApikey,
//       PointLatLng(from.latitude, from.longitude),
//       PointLatLng(to.latitude, to.longitude),
//       travelMode: TravelMode.driving,
//     );
//     PolylineResult results = await polylinePoints.getRouteBetweenCoordinates(
//       googleApikey,
//       PointLatLng(from.latitude, from.longitude),
//       PointLatLng(to.latitude, to.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     } else {
//       print(result.errorMessage);
//     }
//     double totalDistance = 0;
//
//     for (var i = 0; i < polylineCoordinates.length - 1; i++) {
//       // totalDistance += calculateDistance(
//       //     polylineCoordinates[i].latitude,
//       //     polylineCoordinates[i].longitude,
//       //     polylineCoordinates[i + 1].latitude,
//       //     polylineCoordinates[i + 1].longitude);
//     }
//     print(from);
//     print(to);
//     print("Distance");
//
// // https://api.distancematrix.ai/distancematrix?origins=51.4822656,-0.1933769&destinations=51.4994794,-0.1269979&key=<your_access_token>
//
//     print(totalDistance);
//     double distanceInMeters = Geolocator.distanceBetween(
//         from.latitude, from.longitude, to.latitude, to.longitude);
//
//     print(distanceInMeters);
//
//     setState(() {
//       distance = totalDistance;
//       // price = totalDistance * pricePerKilometer;
//       // priceConfort = totalDistance * pricePerKilometerConfort;
//     });
//     print("price");
//
//     print(price);
//     print("priceConfort");
//
//     print(priceConfort);
//     pline++;
//     newaddPolyLine(polylineCoordinates);
//   }
//   getDirections2(LatLng from, LatLng to) async {
//     print("location---------------${from.toString()}");
//     print("location---------------${to.toString()}");
//
//
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePointscc = PolylinePoints();
//
//     PolylineResult result = await polylinePointscc.getRouteBetweenCoordinates(
//       googleApikey,
//       PointLatLng(from.latitude, from.longitude),
//       PointLatLng(to.latitude, to.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     print("location---------------${result.errorMessage}");
//     print("location---------------${result.status}");
//     print("location---------------${result.points}");
//
//     if (result.points.isNotEmpty) {
//       for (var point in result.points) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//     } else {
//       print("ertyuiouytre${result.errorMessage}");
//     }
//     setState(() {
//     });
//     updatePolyLine(polylineCoordinates);
//   }
//   PolylineId id = PolylineId("poly");
//   PolylineId newid = PolylineId("polynew");
//   Polyline? polyline;
//   Polyline? polylinenew;
//   addPolyLine(List<LatLng> polylineCoordinates) {
//
//     polyline = Polyline(
//       polylineId: id,
//       color: Colors.deepPurpleAccent,
//       points: polylineCoordinates,
//       width: 3,
//     );
//     polylines[id] = polyline!;
//     setState(() {});
//   }
//   newaddPolyLine(List<LatLng> polylineCoordinates) {
//
//     polylinenew = Polyline(
//       polylineId: PolylineId("polylinepolylineCoordinates"+"$pline"),
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 3,
//     );
//     polylines[PolylineId("polylinepolylineCoordinates"+"$pline")] = polylinenew!;
//     setState(() {});
//   }
//   updatePolyLine(List<LatLng> polylineCoordinates) {
//     print("updatepolyline----${polylineCoordinates}");
//
//     polyline = Polyline(
//       polylineId: id,
//       color: Colors.amber,
//       points: polylineCoordinates,
//       width: 5,
//     );
//     polylines[id] = polyline!;
//     LatLng startLocation2 =  LatLng(currentLocation!.latitude!,currentLocation!.longitude!);
//
//     markers.add(Marker(
//       //add distination location marker
//       markerId: MarkerId(
//           "drver_marker"),
//       position: startLocation2, //position of marker
//       infoWindow: InfoWindow(
//         //popup info
//         title: 'Destination Point ',
//         snippet: 'Destination Marker',
//       ),
//       icon: BitmapDescriptor
//           .defaultMarker, //Icon for Marker
//     ));
//
//     setState(() {});
//   }

  // double calculateDistance(lat1, lon1, lat2, lon2) {
  //   var p = 0.017453292519943295;
  //   var a = 0.5 -
  //       cos((lat2 - lat1) * p) / 2 +
  //       cos(lat1  p)  cos(lat2  p)  (1 - cos((lon2 - lon1) * p)) / 2;
  //   return 12742 * asin(sqrt(a));
  // }
  getUserCurrentLocation(){
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
  }
  getDriverLocation()async{
    var res = await Webservices.getMap("$getDriverLatLong?driver_id=$DriverId");
    final resdata = GetDriverLatLonModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
    driverLatLonResult = resdata.result;
    print("driver latlon are....${driverLatLonResult!.lat}"
        "......${driverLatLonResult!.lon}");
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        devicePixelRatio: 2,
      ),
      'assets/images/Truck@2x.png', // Replace with your custom marker image path
    ).then((BitmapDescriptor customIcon) {
      // driverPosition = LatLng(22.7533,
      //     75.8937);
      driverPosition = LatLng(double.parse(driverLatLonResult!.lat),
          double.parse(driverLatLonResult!.lon));
      _fetchAndDrawRoute();
      setState(() {

        _markers.add(
          Marker(
            markerId: MarkerId('custom_marker car_${driverLatLonResult!
                .drId}}'),
            position: driverPosition!, // Custom marker position
            icon: customIcon,
            infoWindow: InfoWindow(title: '${driverLatLonResult!.drFullName}',
            snippet: "${driverPosition}"),
          ),
        );
        print("length of marker --------${_markers.length}");
        // setState(() {
      });
    });
    setState(() {});
    } else {
      showSnackbar(context, resdata.message);
    }
  }

      @override
  void initState() {
        getUserCurrentLocation();
        getDriverLocation();
        Timer.periodic(Duration(seconds: 1), (timer) async {
        getDriverLocation();
    });
    super.initState();
  }

  Future<void> _fetchAndDrawRoute() async {
    // Fetch route data from Google Directions API
    final response = await http.get(Uri.parse(
        'https://maps.googleapis'
            '.com/maps/api/directions/json?origin=${_initialPosition.latitude},'
            '${_initialPosition.longitude}&destination=${driverPosition!
            .latitude},'
            '${driverPosition!.longitude}&key=AIzaSyCjm3GS5HaNLYXnxqqF_IhsufMpQgcx8T0'));

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<LatLng> routeCoordinates =
      _decodePoly(encodedPolyline: decodedResponse['routes'][0]['overview_polyline']['points']);
      _updatePolyline(routeCoordinates);
      // Draw polyline between start and end markers
      setState(() {});
    } else {
      throw Exception('Failed to fetch route');
    }
  }

  void _updatePolyline(List<LatLng> newCoordinates) {
    // Remove existing polyline
    _polylines.clear();

    // Draw new polyline with updated coordinates
    _polylines.add(Polyline(
      polylineId: PolylineId('route'),
      color: Colors.blue,
      width: 3,
      points: newCoordinates,
    ));
  }

  // Decodes an encoded polyline into a list of LatLng coordinates
  // Decodes an encoded polyline into a list of LatLng coordinates
  List<LatLng> _decodePoly({String? encodedPolyline}) {
    List<PointLatLng> polylinePoints =
    PolylinePoints().decodePolyline(encodedPolyline!);
    List<LatLng> routeCoordinates = [];
    if (polylinePoints.isNotEmpty) {
      polylinePoints.forEach((PointLatLng point) {
        routeCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return routeCoordinates;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 15,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        polylines: _polylines,
      )
      // body: FutureBuilder(
      //     future: getUserPosition(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return SizedBox.expand(
      //           child:      GoogleMap(
      //             zoomGesturesEnabled: true,
      //             scrollGesturesEnabled: true,
      //             initialCameraPosition: CameraPosition(
      //               target: startLocation,
      //               zoom: 16.0,
      //             ),
      //             //polylines
      //             markers: markers, //markers to show on map
      //             polylines: Set<Polyline>.of(polylines.values,),
      //             mapType: MapType.normal, //map type
      //             onMapCreated: (controller) {
      //
      //               setState(() {
      //                 mapController = controller;
      //               });
      //             },
      //           ),
      //
      //         );
      //       }
      //       return const Center(child: CircularProgressIndicator());
      //     }),
    );
  }
}
