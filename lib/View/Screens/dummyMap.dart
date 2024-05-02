import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

// on below line we are initializing our controller for google maps.
  Completer<GoogleMapController> _controller = Completer();

// on below line we are specifying our camera position
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(22.525, 75.885749655962),
    zoom: 14.4746,
  );

// on below line we have created list of markers
  Set<Marker> _marker = {};
  List checkMaker=[
    {"lat":"22.7196","lon":"75.8577"},
    {"lat":" 23.2599","lon":"77.4126"},
    {"lat":" 22.0355","lon":"74.8967"},
    {"lat":" 19.0760","lon":"72.8777"},
  ];
  getCustomMarker(latlong,i){
    try{
      setState(() {
        
      });
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/images/Truck@2x.png', // Replace with your custom marker image path
      ).then((BitmapDescriptor customIcon) {
        setState(() {
          print(": 1 :");
          _marker.add(
            Marker(
              markerId: MarkerId('${i.toString()}'),
              position: latlong, // Custom marker position
              icon: customIcon,
              infoWindow: InfoWindow(title: '${latlong.toString()}'),
            ),
          );
          print("length of marker --------${_marker.length}");
          // setState(() {

        });});
    }catch(err){
      print("err --------_$err");
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for(int i=0;i<checkMaker.length;i++)
      getCustomMarker(LatLng(double.parse(checkMaker[i]['lat']), double.parse
        (checkMaker[i]['lon'])),i);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0F9D58),
          title: Text("GFG"),
        ),
        body: Container(
          // on below line creating google maps.
          child: GoogleMap(
            markers: _marker,
            // on below line setting camera position
            initialCameraPosition: _kGoogle,
            // on below line specifying map type.
            mapType: MapType.normal,
            // on below line setting user location enabled.
            myLocationEnabled: true,
            // on below line setting compass enabled.
            compassEnabled: true,
            // on below line specifying controller on map complete.
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
        )
    );
  }
}
