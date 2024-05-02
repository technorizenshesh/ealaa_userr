import 'package:ealaa_userr/import_ealaa_user.dart';

import '../../packages/lib/widget/search_widget.dart';

class ChooseDropLocation extends StatefulWidget {
  const ChooseDropLocation({Key? key}) : super(key: key);

  @override
  State<ChooseDropLocation> createState() => _ChooseDropLocationState();
}

class _ChooseDropLocationState extends State<ChooseDropLocation> {
  TextEditingController droploc = TextEditingController();
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
                  placeholder: "Choose drop location",
                  apiKey: "AIzaSyCjm3GS5HaNLYXnxqqF_IhsufMpQgcx8T0",
                  controller: droploc,
                  onSelected: (value) async {
                    print(value.geolocation);

                    var loc = await value.geolocation;

                     lat = loc?.coordinates.latitude;

                     print(lat);

                    // print(value.description);

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
                child: RoundButton(
                  title: 'Save',
                  onTap: () {
                    Map<String,String>data={
                      'dropadd':droploc.text,
                      'droplat': lat.toString(),
                      'droplon':long.toString()
                    };
                    print("data is......$data");
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
