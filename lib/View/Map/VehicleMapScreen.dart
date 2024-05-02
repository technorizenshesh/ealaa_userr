import 'package:ealaa_userr/import_ealaa_user.dart';

class VehicleMapScreen extends StatefulWidget {
  const VehicleMapScreen({Key? key}) : super(key: key);

  @override
  State<VehicleMapScreen> createState() => _VehicleMapScreenState();
}

class _VehicleMapScreenState extends State<VehicleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set();
  static  LatLng _initialPosition =  LatLng(currentLat, currentLong);
  LatLng _currentPosition = _initialPosition;
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
    // TODO: implement initState

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:
      Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
          Positioned(
            bottom: 50.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: _getCurrentLocation,
              child: Icon(Icons.location_searching),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _getCurrentLocation() async {
    // Simulate getting the current location, you should use location package in real app.
    LatLng newPosition = LatLng(37.7749, -122.4194); // San Francisco, CA

    setState(() {
      _currentPosition = newPosition;
      _markers.add(
        Marker(
          markerId: MarkerId("current_position"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    });

    // Simulate getting other car locations, you should replace this with your actual logic.
    _getOtherCarLocations();
  }

  void _getOtherCarLocations() {
    // Simulated list of other car locations.
    List<LatLng> otherCarLocations = [
      LatLng(22.9676, 76.0534),
      LatLng(37.7802, -122.4313),
      LatLng(37.7739, -122.4312),
    ];

    for (int i = 0; i < otherCarLocations.length; i++) {
      LatLng carPosition = otherCarLocations[i];
      print("cars...............");
      _markers.add(
        Marker(
          markerId: MarkerId("car_$i"),
          position: carPosition,
          infoWindow: const InfoWindow(
            //popup info
            title: 'end Point ',
            snippet: 'Start Marker',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }
  }
}


