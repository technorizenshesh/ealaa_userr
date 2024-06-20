import 'package:ealaa_userr/advertisement/AddPost/Animals/Add_AnimalsAd.dart';
import 'package:ealaa_userr/advertisement/AddPost/Electronics/Add_ElectronicsAd.dart';
import 'package:ealaa_userr/advertisement/AddPost/PhoneNumbers/Add_PhonenumbersAd.dart';
import 'package:ealaa_userr/advertisement/AddPost/RealState/Add_RealStateAd.dart';
import 'package:ealaa_userr/advertisement/AddPost/Vehicles/VehiclesMake.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/advertisement_model/ad_subcategory_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/webService.dart';

class Ad_Post_Subcategories extends StatefulWidget {
  String advertisement_category_id = '';
  String title = '';

  Ad_Post_Subcategories(
      {super.key,
      required this.advertisement_category_id,
      required this.title});

  @override
  State<Ad_Post_Subcategories> createState() => _Ad_Post_SubcategoriesState();
}

class _Ad_Post_SubcategoriesState extends State<Ad_Post_Subcategories> {
  bool showProgressBar = true;
  List<SubcategoryResult> subcategoryList = [];

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_sub_category?category_id=${widget.advertisement_category_id}");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = GetSubcategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      subcategoryList = resdata.result!;
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
        title: Text(
          widget.title, // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: showProgressBar
              ? Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : subcategoryList.isEmpty
                  ? Image.asset("assets/images/NoDataFound.png")
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      child: GridView.builder(
                        //    physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, mainAxisExtent: 130),
                        itemCount: subcategoryList.length,
                        itemBuilder: (context, int index) {
                          //  GetClubsResult item = controller.getClubsModel!.result![index];
                          return GestureDetector(
                            onTap: () {
                              widget.advertisement_category_id=="1"||widget.advertisement_category_id=="2"?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VehiclesMake(
                                    advertisement_category_id:
                                        widget.advertisement_category_id,
                                    advertisement_sub_category_id:
                                        subcategoryList[index].id!,
                                  ),
                                ),
                              ):
                              widget.advertisement_category_id=="5"||widget.advertisement_category_id=="6"?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddRealStateAd(
                                    advertisement_category_id:
                                    widget.advertisement_category_id,
                                    advertisement_sub_category_id:
                                    subcategoryList[index].id!,
                                  ),
                                ),
                              ):
                              widget.advertisement_category_id=="7"||widget.advertisement_category_id=="8"?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddElectronicsAd(
                                    advertisement_category_id:
                                    widget.advertisement_category_id,
                                    advertisement_sub_category_id:
                                    subcategoryList[index].id!,
                                  ),
                                ),
                              ):
                              widget.advertisement_category_id=="9"?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Add_PhoneNumbersAd(
                                    advertisement_category_id:
                                    widget.advertisement_category_id,
                                    advertisement_sub_category_id:
                                    subcategoryList[index].id!,
                                  ),
                                ),
                              ):
                              widget.advertisement_category_id=="10"?
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Add_AnimalsAd(
                                    advertisement_category_id:
                                    widget.advertisement_category_id,
                                    advertisement_sub_category_id:
                                    subcategoryList[index].id!,
                                  ),
                                ),
                              ):
                                  Container()
                              ;
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                      color: Colors.grey, width: .25),
                                  right: BorderSide(
                                      color: Colors.grey, width: .25),
                                  bottom:
                                      BorderSide(color: Colors.grey, width: .5),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        200, // Set the width of the image here
                                    height: 80,
                                    child: ClipRRect(
                                      //  borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            subcategoryList[index].image ?? '',
                                        height: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child: Shimmer.fromColors(
                                          baseColor: MyColors.onSecondary
                                              .withOpacity(0.4),
                                          highlightColor: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(16),
                                              color: MyColors.onSecondary
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                        )),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    subcategoryList[index].subCategoryName ??
                                        '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black),
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )),
    );
  }
}
