import 'package:ealaa_userr/advertisement/ad_category.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Model/CityModel.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';

class AdSelectCity extends StatefulWidget {
  const AdSelectCity({super.key});

  @override
  State<AdSelectCity> createState() => _AdSelectCityState();
}

class _AdSelectCityState extends State<AdSelectCity> {
  bool showProgressBar = true;
  List<CityResult> cityList = [];
  CityResult? selectedCity;

  getCitiesList() async {
    var res = await Webservices.getMap(get_city);
    showProgressBar = false;
    print("status from api ${res}");
    final resdata = CityModel.fromJson(res);
    print(resdata);
    if (resdata.status == '1') {
      cityList = resdata.result;
      selectedCity = cityList[0];
      setState(() {});
      //  createChecker();
    } else {
      showSnackbar(context, resdata.message);
    }
  }

  @override
  void initState() {
    getCitiesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Select a City', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar:
      cityList.isEmpty?SizedBox():
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: RoundButton(
          borderRadius: 8,
          title: "Next", onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AdCategory(selectedCity: selectedCity!,),));
        },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Where should we place your Ad?',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              showProgressBar
                  ? CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    )
                  : cityList.isEmpty
                      ? Image.asset("assets/images/NoDataFound.png")
                      : Column(
                          children: [
                            for (int i = 0; i < cityList.length; i++)
                              RadioListTile(
                                  activeColor: Colors.orange,
                                  title: Text(
                                    cityList[i].name,
                                    style: TextStyle(
                                        color: selectedCity!.name ==
                                                cityList[i].name
                                            ? Colors.orange
                                            : Colors.black),
                                  ),
                                  value: cityList[i],
                                  groupValue: selectedCity,
                                  onChanged: (CityResult? value) {
                                    setState(() {
                                      selectedCity = value;
                                    });
                                  })
                          ],
                        )
            ],
          ),
        ),
      ),
    );
  }
}
