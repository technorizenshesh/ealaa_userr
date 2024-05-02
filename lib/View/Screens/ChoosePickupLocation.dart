import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../packages/lib/widget/search_widget.dart';

class ChoosePickupLocation extends StatefulWidget {
  const ChoosePickupLocation({Key? key}) : super(key: key);

  @override
  State<ChoosePickupLocation> createState() => _ChoosePickupLocationState();
}

class _ChoosePickupLocationState extends State<ChoosePickupLocation> {
  TextEditingController pickloc = TextEditingController();
  var lat;
  var long;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
  child: SingleChildScrollView(
    child: Column(
      children: [
        Container(
          height: height*0.8,
          child: SearchLocation(
            placeholder: "Choose pickup location",
            apiKey: "AIzaSyCjm3GS5HaNLYXnxqqF_IhsufMpQgcx8T0",
                  controller: pickloc,
                  onSelected: (value) async {
                    print(value.geolocation);

                    var loc = await value.geolocation;
                                                                        
                    lat = loc?.coordinates.latitude;

                    print("lat is.$lat");

                    // print(value.description);
                    //
                    // place = value.description;

                    // print(" selected place is $locationController");

                    long = loc?.coordinates.longitude;

                    print(long);
                  },
                  enabled: true,
                ),
        ),
        Positioned(
          bottom: 0,
          child:
          RoundButton(
            title: 'Save',
            onTap: () {
              Map<String,String>data={
                'pickadd':pickloc.text,
                'picklat': lat.toString(),
                'picklon':long.toString()
              };
     Navigator.pop(context,data);
            },
            fontsize: 16,
            fontweight: FontWeight.w700,
          ),
        ),
      ],
    ),
  ),
      ),
    );
  }
}
