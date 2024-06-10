import 'package:ealaa_userr/advertisement/PostByCategory.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/ad_subcategory_model.dart';
import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/GlobalData.dart';
import '../View/Utils/webService.dart';
import 'ad_product_detail.dart';

class AdSubCategories extends StatefulWidget {
  String advertisement_category_id = '';
  String title = '';

  AdSubCategories(
      {super.key,
      required this.advertisement_category_id,
      required this.title});

  @override
  State<AdSubCategories> createState() => _AdSubCategoriesState();
}

class _AdSubCategoriesState extends State<AdSubCategories> {
  TextEditingController search = TextEditingController();
  bool showProgressBar = true;
  List<SubcategoryResult> subcategoryList = [];
  SubcategoryResult? selectedSubcategory;
  List<GetAdvertisementCategoryResult> getAdvertisementPostsCategoryResult = [];

  getAdSubcategory() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_sub_category?category_id=${widget.advertisement_category_id}");
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

  // getAdvertisementPostsCategoryApi() async {
  //   showProgressBar = true;
  //   var res = await Webservices.getMap(
  //       "$baseUrl$get_advertisement_posts_category?advertisement_category_id=${widget.advertisement_category_id}&user_id=${userId}");
  //   print("status from api ${res}");
  //   final resdata = GetAdvertisementCategoryModel.fromJson(res);
  //   print(resdata);
  //   if (resdata.result != null && resdata.status == '1') {
  //     getAdvertisementPostsCategoryResult = resdata.result!;
  //     setState(() {});
  //   } else {
  //     showSnackbar(context, resdata.message ?? '');
  //   }
  //   showProgressBar = false;
  // }

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
      bottomNavigationBar: subcategoryList.isEmpty
          ? SizedBox()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: RoundButton(
                borderRadius: 8,
                title: "Next",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostByCategory(
                            advertisement_category_id:
                                widget.advertisement_category_id,
                            selectedSubcategory: selectedSubcategory!),
                      ));
                },
              ),
            ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: showProgressBar
                ? Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                    ),
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
                                              subcategoryList[i].subCategoryName
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
            // showProgressBar
            //     ? CommonWidget.commonShimmer(
            //         itemCount: 4,
            //         shimmerWidget: Container(
            //           height: 100,
            //           width: double.infinity,
            //           decoration: const BoxDecoration(
            //             color: Colors.black,
            //             borderRadius: BorderRadius.all(Radius.circular(10)),
            //           ),
            //           margin: const EdgeInsets.only(
            //               left: 20, right: 20, top: 5, bottom: 2),
            //           clipBehavior: Clip.hardEdge,
            //         ))
            //     :
            // GridView.builder(
            //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //             childAspectRatio: 100,
            //             maxCrossAxisExtent: 140,
            //             mainAxisExtent: 170,
            //             mainAxisSpacing: 4),
            //         physics: const BouncingScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: getAdvertisementPostsCategoryResult.length,
            //         itemBuilder: (context, int index) {
            //           //  GetClubsResult item = controller.getClubsModel!.result![index];
            //           return Card(
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(4)),
            //             ),
            //             elevation: 2,
            //             clipBehavior: Clip.hardEdge,
            //             child: GestureDetector(
            //               onTap: () async {
            //                 await Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => AdProductDetail(
            //                           id: getAdvertisementPostsCategoryResult[index]
            //                                   .id ??
            //                               '')),
            //                 );
            //                 getAdvertisementPostsCategoryApi();
            //               },
            //               child: Container(
            //                 height: 160,
            //                 // width: 110,
            //                 decoration: const BoxDecoration(
            //                   color: Colors.white,
            //                   borderRadius: BorderRadius.all(Radius.circular(5)),
            //                 ),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: [
            //                     Stack(
            //                       alignment: Alignment.topRight,
            //                       children: [
            //                         ClipRRect(
            //                           borderRadius: BorderRadius.circular(10),
            //                           child: CachedNetworkImage(
            //                             imageUrl:
            //                                 getAdvertisementPostsCategoryResult[
            //                                             index]
            //                                         .image ??
            //                                     '',
            //                             height: 100,
            //                             width: double.infinity,
            //                             fit: BoxFit.cover,
            //                             placeholder: (context, url) => Center(
            //                               child: Shimmer.fromColors(
            //                                 baseColor: MyColors.onSecondary
            //                                     .withOpacity(0.4),
            //                                 highlightColor: Theme.of(context)
            //                                     .colorScheme
            //                                     .onSecondary,
            //                                 child: Container(
            //                                   height: 85,
            //                                   decoration: BoxDecoration(
            //                                     borderRadius:
            //                                         BorderRadius.circular(16),
            //                                     color: MyColors.onSecondary
            //                                         .withOpacity(0.4),
            //                                   ),
            //                                 ),
            //                               ),
            //                             ),
            //                             errorWidget: (context, url, error) =>
            //                                 const Icon(Icons.error),
            //                           ),
            //                         ),
            //                         InkWell(
            //                           onTap: () async {
            //                             showProgressBar = true;
            //                             await Webservices.getMap(
            //                                 "$baseUrl$advertisement_post_fav?advertisement_post_id=${(getAdvertisementPostsCategoryResult[index].id != null && getAdvertisementPostsCategoryResult[index].id!.isNotEmpty) ? getAdvertisementPostsCategoryResult[index].id! : ''}&user_id=${userId}");
            //                             var res = await Webservices.getMap(
            //                                 "$baseUrl$get_all_advertisement_posts?user_id=${userId}");
            //                             print("status from api ${res}");
            //                             final resdata =
            //                                 GetAdvertisementCategoryModel.fromJson(
            //                                     res);
            //                             print(resdata);
            //                             if (resdata.result != null &&
            //                                 resdata.status == '1') {
            //                               getAdvertisementPostsCategoryResult =
            //                                   resdata.result!;
            //                               setState(() {});
            //                             } else {
            //                               showSnackbar(
            //                                   context, resdata.message ?? '');
            //                             }
            //                             showProgressBar = false;
            //                           },
            //                           borderRadius: BorderRadius.circular(4),
            //                           child: Container(
            //                             padding: const EdgeInsets.all(4),
            //                             margin: const EdgeInsets.all(4),
            //                             decoration: BoxDecoration(
            //                                 color: Colors.white,
            //                                 borderRadius: BorderRadius.circular(4)),
            //                             child: Icon(
            //                                 getAdvertisementPostsCategoryResult[
            //                                                     index]
            //                                                 .advertisementPostFav !=
            //                                             null &&
            //                                         getAdvertisementPostsCategoryResult[
            //                                                     index]
            //                                                 .advertisementPostFav ==
            //                                             'true'
            //                                     ? Icons.favorite
            //                                     : Icons.favorite_border,
            //                                 color: Colors.red),
            //                           ),
            //                         )
            //                       ],
            //                     ),
            //                     Padding(
            //                       padding:
            //                           const EdgeInsets.symmetric(horizontal: 10),
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         children: [
            //                           Text(
            //                             getAdvertisementPostsCategoryResult[index]
            //                                     .bedroom ??
            //                                 'Product',
            //                             maxLines: 1,
            //                             style: const TextStyle(
            //                                 fontWeight: FontWeight.bold,
            //                                 fontSize: 14,
            //                                 color: Colors.orange),
            //                           ),
            //                           Text(
            //                             getAdvertisementPostsCategoryResult[index]
            //                                     .describeProperty ??
            //                                 '',
            //                             style: const TextStyle(
            //                                 fontWeight: FontWeight.normal,
            //                                 fontSize: 12,
            //                                 color: Colors.black54),
            //                             maxLines: 2,
            //                           )
            //                         ],
            //                       ),
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            ),
      ),
    );
  }
}
