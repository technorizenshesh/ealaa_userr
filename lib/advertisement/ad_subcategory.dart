import 'package:ealaa_userr/advertisement/AddPost/Classifields/AddPostCycling.dart';
import 'package:ealaa_userr/advertisement/AddPost/Motors/AddPostAutoparts.dart';
import 'package:ealaa_userr/advertisement/AddPost/Motors/AddPostBoatsYacht.dart';
import 'package:ealaa_userr/advertisement/AddPost/Motors/AddPostCars.dart';
import 'package:ealaa_userr/advertisement/AddPost/Motors/AddPostMotorbike.dart';
import 'package:ealaa_userr/advertisement/AddPost/Motors/AddPostTrucksHeavyVehicles.dart';
import 'package:ealaa_userr/advertisement/Add_ad_Commercial%20Office.dart';
import 'package:ealaa_userr/advertisement/Add_ad_Villa_Post.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Model/CityModel.dart';
import '../Model/advertisement_model/ad_subcategory_model.dart';
import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'AddPost/Motors/AddPostNumberplates.dart';

class AdSubcategory extends StatefulWidget {
  final GetAdsWithCategoryHomeResult selectedCategory;
  final CityResult selectedCity;
  final String description;

  const AdSubcategory(
      {super.key,
      required this.description,
      required this.selectedCategory,
      required this.selectedCity});

  @override
  State<AdSubcategory> createState() => _AdSubcategoryState();
}

class _AdSubcategoryState extends State<AdSubcategory> {
  bool showProgressBar = true;
  List<SubcategoryResult> subcategoryList = [];
  SubcategoryResult? selectedSubcategory;

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_sub_category?category_id=${widget.selectedCategory.id}");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = GetSubcategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      subcategoryList = resdata.result!;
      selectedSubcategory = subcategoryList[0];
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    getAdSubcategory();
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
          'Post an Ad', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      bottomNavigationBar: subcategoryList.isEmpty
          ? SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: RoundButton(
                borderRadius: 8,
                title: "Next",
                onTap: () {
                  print(
                      "category:::${widget.selectedCategory.id}::subcategory::::${selectedSubcategory!.id}");
                  if (widget.selectedCategory.id == "1"||widget.selectedCategory.id == "2") {
                    if (selectedSubcategory!.id == "1" ||
                        selectedSubcategory!.id == "2" ||
                        selectedSubcategory!.id == "3" ||
                        selectedSubcategory!.id == "4" ||
                        selectedSubcategory!.id == "7" ||
                        selectedSubcategory!.id == "11") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAdsCommercialoffice(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddAdsVilla(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                  }
                  else if(widget.selectedCategory.id == "3"){
                    if(selectedSubcategory!.id=="27"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostNumberPlates(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                    else if(selectedSubcategory!.id=="28"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostAutoparts(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                    else if(selectedSubcategory!.id=="29"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostBoatsYacht(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                    else if(selectedSubcategory!.id=="30"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostMotorbike(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                    else if(selectedSubcategory!.id=="31"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostTruckHeavyVehicles(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }
                    else if(selectedSubcategory!.id=="32"){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddPostCars(
                              selectedCategory: widget.selectedCategory,
                              selectedCity: widget.selectedCity,
                              description: widget.description,
                              selectedSubcategory: selectedSubcategory!,
                            ),
                          ));
                    }


                  }
                  else if(widget.selectedCategory.id == "4"){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddPostCycling(
                            selectedCategory: widget.selectedCategory,
                            selectedCity: widget.selectedCity,
                            description: widget.description,
                            selectedSubcategory: selectedSubcategory!,
                          ),
                        ));
                  }
                  else{
                    showSnackbar(context, "coming soon");

                  }
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
              Center(
                child: Text('Next, pick a category for your Ad.',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                    'Placing in the right category gets you more connections.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center),
              ),
              SizedBox(
                height: 10,
              ),
              Text("\"${widget.description}\"",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey,
                  ),
                  textAlign: TextAlign.center),
              SizedBox(
                height: 10,
              ),
              showProgressBar
                  ? CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    )
                  : subcategoryList.isEmpty
                      ? Image.asset("assets/images/NoDataFound.png")
                      : Column(
                          children: [
                            for (int i = 0; i < subcategoryList.length; i++)
                              RadioListTile(
                                  activeColor: Colors.orange,
                                  title: Text(
                                    subcategoryList[i].subCategoryName!,
                                    style: TextStyle(
                                        color: selectedSubcategory!
                                                    .subCategoryName ==
                                                subcategoryList[i]
                                                    .subCategoryName
                                            ? Colors.orange
                                            : Colors.black),
                                  ),
                                  value: subcategoryList[i],
                                  groupValue: selectedSubcategory,
                                  onChanged: (SubcategoryResult? value) {
                                    setState(() {
                                      selectedSubcategory = value;
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
