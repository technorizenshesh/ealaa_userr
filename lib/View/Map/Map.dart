
import '../../import_ealaa_user.dart';
class MapView extends StatefulWidget {
  final double? finalLat;
  final double? finalLong;
  final String? selectedAdd;
  const MapView({super.key, this.finalLat, this.finalLong, this.selectedAdd});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController? mapController; //contrller for Google map
  Set<Marker> markers = Set(); //markers for google map
  LatLng showLocation = LatLng(currentLat, currentLong);
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  //location to show in map
  Set<Circle> circles = Set.from([Circle(
    circleId: CircleId("id"),
    center: LatLng(currentLat, currentLong),
    radius: 4000,
  )]);
  int value = 0;
  List<LatLng> points = [];
  MapsRoutes route = new MapsRoutes();
  String selectedAddresss='';

  createPloyline()async{
    print("createPloyline") ;
    if (points.length >= 2) {
      print("createPloyline  1") ;

      await route.drawRoute(
          points,
          'Test routes',
          Colors.blue,
          googleApiKey,
          travelMode: TravelModes.driving);
      markers.add(Marker(
          markerId: const MarkerId('SomeId'),
          position: LatLng(
              points.first.latitude,
              points.first.longitude),
          infoWindow: const InfoWindow(
              title:
              'The title of the marker')));
      markers.add(Marker(
          markerId: const MarkerId('SomeId2'),
          position: LatLng(points.last.latitude,
              points.last.longitude),
          infoWindow: const InfoWindow(
              title:
              'The title of the marker')));


      setState(() {
        var totalDistance1 = distanceCalculator
            .calculateRouteDistance(points,
            decimals: 1);
        print("totalDistance---------${totalDistance}");
        totalDistance=double.parse(totalDistance1.split(' km')[0]);
        print("totalDistance---------${totalDistance}");

      });
    }
    else{
      print("createPloyline  else") ;

    }
  }
  @override
  void initState() {
    // if(widget.finalLat!=null){
    //   showLocation = LatLng(widget.finalLat!,widget.finalLong!);
    //   points=[];
    //   points.add(LatLng(currentLat,currentLong));
    //   points.add(LatLng(widget.finalLat!,widget.finalLong!));
    //   print("---------------------------${points}");
    // }
    // if(widget.selectedAdd!=null){
    //   selectedAddresss=widget.selectedAdd!;
    //
    //   createPloyline();
    //   setState(() {
    //
    //   });
    // }
    print("showLocation-------${showLocation}");
    markers.add(Marker(
      //add marker on google map
      markerId: MarkerId(showLocation.toString()),
      position: showLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'My Custom Title ',
        snippet: 'My Custom Subtitle',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    //you can add more markers here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GoogleMap(

        polylines: route.routes,
        zoomGesturesEnabled: true, //enable Zoom in, out on map
        initialCameraPosition: CameraPosition(
          //innital position in map
          target: showLocation, //initial position
          zoom: 10.0, //initial zoom level
        ),
        markers: markers, //markers to show on map
        mapType: MapType.normal,
        // circles: circles,//map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}

