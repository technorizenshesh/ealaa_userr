import 'package:ealaa_userr/View/Utils/CustomSnackBar.dart';
import 'package:ealaa_userr/advertisement/ad_subcategory.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Model/CityModel.dart';
import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../common/common_widgets.dart';

class AdDescription extends StatefulWidget {
  final GetAdvertisementCategoryResult selectedCategory;
  final CityResult selectedCity;

  const AdDescription({super.key, required this.selectedCategory, required this.selectedCity});

  @override
  State<AdDescription> createState() => _AdDescriptionState();
}

class _AdDescriptionState extends State<AdDescription> {
  TextEditingController description = TextEditingController();

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
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            'First, enter a short tittle to describe your listing',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.grey,
                ),
              textAlign: TextAlign.center
          ),
          SizedBox(
            height: 60,
          ),
          commonTextFormField(
              controller: description, hintText: 'Enter short description about your product',maxLines: 3),
          SizedBox(
            height: 60,
          ),
          RoundButton(
            borderRadius: 8,
            title: "Let's Go!", onTap: () {
              if(description.text==""){
                showSnackbar(context, "Please enter description first");
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdSubcategory(description: description.text, selectedCategory: widget.selectedCategory, selectedCity: widget.selectedCity,),));

              }
          },
          ),
        ],),
      ),
    );
  }
}
