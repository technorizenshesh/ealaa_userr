import 'package:ealaa_userr/import_ealaa_user.dart';
class MapList extends StatefulWidget {

  final List markerList ;
  final bool isCompany;
  const MapList({super.key, required this.markerList, required this.isCompany});

  @override
  State<MapList> createState() => _MapListState();
}

class _MapListState extends State<MapList> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker>markers={};
  static LatLng _initialPosition = LatLng(currentLat, currentLong);
  
  getCustomMarker(latlong){
    try{
      BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2,),
        'assets/images/Truck@2x.png', // Replace with your custom marker image path
      ).then((BitmapDescriptor customIcon) {
        setState(() {
          print(": 1 :");
          markers.add(
            Marker(
              markerId: MarkerId('custom_marker${latlong.toString()}'),
              position: latlong, // Custom marker position
              icon: customIcon,
              infoWindow: InfoWindow(title: '${latlong.toString()}'),
            ),
          );
          print("length of marker --------${markers.length}");
          // setState(() {

        });});
    }catch(err){
      print("err --------_$err");
    }
  }
  
  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_initialPosition,
        100));
  }
  @override
  void initState() {
    markers.add(Marker(
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

    for(int i=0;i<widget.markerList.length;i++){
      print("lat lon --------${widget.markerList[i].lat}   ${widget
          .markerList[i].lon}");

      getCustomMarker(LatLng(double.parse(widget.markerList[i].lat), double.parse(widget
          .markerList[i].lon)));
      // print("widget.isCompany-------${widget.isCompany}");
      // if(widget.isCompany){
      //   // print("lat lon --com------${widget.markerList[i].companyLat}   ${widget
      //   //     .markerList[i].companyLon}");
      //   getCustomMarker(LatLng(double.parse(widget.markerList[i]
      //       .companyLat==''?'0':widget.markerList[i]
      //       .companyLat)
      //       , double.parse(widget.markerList[i].companyLon==''?'0':widget.markerList[i].companyLon)));
      // }
      // else
      // {
      //   }
    }
    setState(() {
         markers;
    });
    _goToCurrentLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(currentLat,currentLong)),
        markers: markers,
      ),
    );
  }
}
