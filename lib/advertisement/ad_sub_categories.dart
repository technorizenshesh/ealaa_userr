import 'package:ealaa_userr/advertisement/CategoryPostsScreen.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/AllCategoryPostModel.dart';
import '../Model/advertisement_model/ad_subcategory_model.dart';
import '../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';

class AdSubCategories extends StatefulWidget {
  String advertisement_category_id = '';
  String ads_post = '';
  GetAdsWithCategoryHomeResult getAdsWithCategoryHomeResult;

  AdSubCategories({
    super.key,
    required this.advertisement_category_id,
    required this.ads_post,
    required this.getAdsWithCategoryHomeResult,
  });

  @override
  State<AdSubCategories> createState() => _AdSubCategoriesState();
}

class _AdSubCategoriesState extends State<AdSubCategories> {
  bool showProgressBar = true;
  String values = '';
  List<SubcategoryResult> subcategoryList = [];
  List<String> selectedSubcategoryList = [];
  SubcategoryResult? selectedSubcategory;
  List<GetAdsWithCategoryHomeResult> getAdvertisementPostsCategoryResult = [];

  GetSubcategoryModel? resdata;

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_sub_category?category_id=${widget.advertisement_category_id}&ads_type=${widget.ads_post}");
    print("status from api ${res}");
    showProgressBar = false;
    resdata = GetSubcategoryModel.fromJson(res);
    print(resdata);
    if (resdata != null && resdata!.result != null && resdata!.status == '1') {
      subcategoryList = resdata!.result!;
      /*subcategoryList.forEach((element) {
        if(element.selected == '1')
        {
          selectedSubcategoryList.add(element.id.toString());
        }
      });
      values = selectedSubcategoryList.join(',').toString();*/
      setState(() {});
    } else {
      showSnackbar(context, resdata?.message ?? '');
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
          widget.getAdsWithCategoryHomeResult.name ?? "", // Your badge count here
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
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: RoundButton(
                borderRadius: 8,
                title:
                    "${resdata?.selectedCount != '0' ? resdata?.selectedCount : resdata?.count ?? '0'} ${widget.getAdsWithCategoryHomeResult.name}",
                onTap: () {
                  subcategoryList.forEach((element) {
                    if(element.selected == '1')
                      {
                        selectedSubcategoryList.add(element.id.toString());
                      }
                  });
                  values = selectedSubcategoryList.join(',').toString();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryPostsScreen(adsPost: widget.ads_post,adsCategoryId: widget.advertisement_category_id,adsSubCategoryId: values,),
                      ));
                  selectedSubcategoryList.clear();
                },
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
            child: showProgressBar
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
                  )
                : subcategoryList.isEmpty
                    ? Image.asset("assets/images/NoDataFound.png")
                    : Container(
                        height: MediaQuery.of(context).size.height - 170,
                        child: GridView.builder(
                          // physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 130),
                          itemCount: subcategoryList.length,
                          itemBuilder: (context, int index) {
                            //  GetClubsResult item = controller.getClubsModel!.result![index];
                            return GestureDetector(
                              onTap: () {
                                if ((subcategoryList[index].selected == null ||
                                    subcategoryList[index].selected != '1')) {
                                  subcategoryList[index].selected = '1';
                                  resdata?.selectedCount = (int.parse(
                                              resdata?.selectedCount ?? '0') +
                                          int.parse(
                                              subcategoryList[index].subcount ?? '0'))
                                      .toString();
                                  setState(() {});
                                } else {
                                  subcategoryList[index].selected = null;
                                  resdata?.selectedCount = (int.parse(
                                              resdata?.selectedCount ?? '0') -
                                          int.parse(
                                              subcategoryList[index].subcount!))
                                      .toString();
                                  setState(() {});
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => AdSubCategories(
                                //       title: subcategoryList[index].subCategoryName?? '',
                                //       advertisement_category_id:
                                //       advertisementCategoryList[index].id ?? '',
                                //     ),
                                //   ),
                                // );
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
                                    bottom: BorderSide(
                                        color: Colors.grey, width: .5),
                                  ),
                                  // color: Colors.red,
                                ),
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              200, // Set the width of the image here
                                          height: 80,
                                          child: ClipRRect(
                                            //  borderRadius: BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: subcategoryList[index]
                                                      .image ??
                                                  '',
                                              height: 60,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                      child: Shimmer.fromColors(
                                                baseColor: MyColors.onSecondary
                                                    .withOpacity(0.4),
                                                highlightColor:
                                                    Theme.of(context)
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          subcategoryList[index]
                                                  .subCategoryName ??
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
                                    if (subcategoryList[index].selected !=
                                            null ||
                                        subcategoryList[index].selected == '1')
                                      Positioned(
                                          child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 0, 0),
                                        child: SvgPicture.asset(
                                          "assets/images/CheckBox.svg",
                                          height: 20,
                                        ),
                                      ))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
            ),
      ),
    );
  }
}
