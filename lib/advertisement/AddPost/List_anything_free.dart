import 'package:ealaa_userr/advertisement/AddPost/SparePart.dart';
import 'package:ealaa_userr/advertisement/AddPost/transfer_type.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/advertisement_model/get_ads_with_category_home_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import 'PhoneNumbers/Add_PhonenumbersAd.dart';
import 'ad_post_subcategories.dart';

class ListAnythingFree extends StatefulWidget {
  const ListAnythingFree({super.key});

  @override
  State<ListAnythingFree> createState() => _ListAnythingFreeState();
}

class _ListAnythingFreeState extends State<ListAnythingFree> {
  bool showProgressBar = false;

  getAdvertisementCategoryApi() async {
     setState(() {});
     showProgressBar = true;
     var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = GetAdsWithCategoryHomeModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdsWithCategoryHomeResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    if (getAdsWithCategoryHomeResult == [] || getAdsWithCategoryHomeResult.isEmpty) {
      getAdvertisementCategoryApi();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
          centerTitle: true,
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
          title: const Text(
            'List anything for FREE!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: (getAdsWithCategoryHomeResult.isNotEmpty ||
                  getAdsWithCategoryHomeResult != [])
              ? showCategory()
              : SizedBox(),
        ));
  }

  Widget showCategory() {
    return showProgressBar
        ? CommonWidget.commonShimmer(
            itemCount: 4,
            shimmerWidget: Container(
              height: 100,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              margin:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
              clipBehavior: Clip.hardEdge,
            ))
        : GridView.builder(
            //physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 100, mainAxisSpacing: 5),
            itemCount: getAdsWithCategoryHomeResult.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  if (getAdsWithCategoryHomeResult[index].id == "1" ||
                      getAdsWithCategoryHomeResult[index].id == "2" ||
                      getAdsWithCategoryHomeResult[index].id == "5" ||
                      getAdsWithCategoryHomeResult[index].id == "6" ||
                      getAdsWithCategoryHomeResult[index].id == "7" ||
                      getAdsWithCategoryHomeResult[index].id == "8" ||
                      getAdsWithCategoryHomeResult[index].id == "10") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ad_Post_Subcategories(
                          title: getAdsWithCategoryHomeResult[index].id == "1" ||
                                  getAdsWithCategoryHomeResult[index].id == "2"
                              ? 'Body'
                              : getAdsWithCategoryHomeResult[index].id == "5" ||
                                      getAdsWithCategoryHomeResult[index].id == "6"
                                  ? 'Property Type'
                                  : getAdsWithCategoryHomeResult[index].id ==
                                              "7" ||
                                          getAdsWithCategoryHomeResult[index].id ==
                                              "8"
                                      ? 'Select Type'
                                      : getAdsWithCategoryHomeResult[index].id ==
                                              "10"
                                          ? 'Animal Type'
                                          : "",
                          advertisement_category_id:
                              getAdsWithCategoryHomeResult[index].id ?? '',
                        ),
                      ),
                    );
                  }
                  else if (getAdsWithCategoryHomeResult[index].id == "3") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SparePart(
                          advertisement_category_id:
                              getAdsWithCategoryHomeResult[index].id ?? '',
                          adType:
                              getAdsWithCategoryHomeResult[index].type ?? ''
                        ),
                      ),
                    );
                  }
                  else if (getAdsWithCategoryHomeResult[index].id == "4") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferType(
                          advertisement_category_id:
                              getAdsWithCategoryHomeResult[index].id ?? '',
                        ),
                      ),
                    );
                  }
                  else if
                  (getAdsWithCategoryHomeResult[index].id=="9")   {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Add_PhoneNumbersAd(
                          advertisement_category_id:
                          getAdsWithCategoryHomeResult[index].id!,
                        ),
                      ));
                  }
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  // padding: const EdgeInsets.only(
                  //     left: 3, right: 3, top: 5, bottom: 5),
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200, // Set the width of the image here
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                                getAdsWithCategoryHomeResult[index].image ?? '',
                            height: 60,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                child: Shimmer.fromColors(
                              baseColor: MyColors.onSecondary.withOpacity(0.4),
                              highlightColor:
                                  Theme.of(context).colorScheme.onSecondary,
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: MyColors.onSecondary.withOpacity(0.4),
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
                        getAdsWithCategoryHomeResult[index].name ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black54),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            },
          );
    // ListView.builder(
    //         physics: const BouncingScrollPhysics(),
    //         shrinkWrap: true,
    //         //padding: EdgeInsets.zero,
    //         scrollDirection: Axis.horizontal,
    //         itemCount: getAdvertisementCategoryResult.length,
    //         itemBuilder: (context, int index) {
    //           //  GetClubsResult item = controller.getClubsModel!.result![index];
    //           return GestureDetector(
    //             onTap: () async {
    //               await Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                   builder: (context) => AdSubCategories(
    //                     title: getAdvertisementCategoryResult[index].name ?? '',
    //                     advertisement_category_id:
    //                         getAdvertisementCategoryResult[index].id ?? '',
    //                   ),
    //                 ),
    //               );
    //               getAdvertisementPostsApi();
    //             },
    //             child: Container(
    //               height: 110,
    //               width: 110,
    //               decoration: BoxDecoration(
    //                   color: Colors.white,
    //                   borderRadius: const BorderRadius.all(Radius.circular(15)),
    //                   border: Border.all(
    //                       color: Colors.orangeAccent.withOpacity(0.7),
    //                       width: 2)),
    //               margin: const EdgeInsets.symmetric(horizontal: 4),
    //               clipBehavior: Clip.hardEdge,
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   ClipRRect(
    //                     borderRadius: BorderRadius.circular(10),
    //                     child: CachedNetworkImage(
    //                       imageUrl:
    //                           getAdvertisementCategoryResult[index].image ?? '',
    //                       height: 60,
    //                       fit: BoxFit.fill,
    //                       placeholder: (context, url) => Center(
    //                           child: Shimmer.fromColors(
    //                         baseColor: MyColors.onSecondary.withOpacity(0.4),
    //                         highlightColor:
    //                             Theme.of(context).colorScheme.onSecondary,
    //                         child: Container(
    //                           height: 60,
    //                           decoration: BoxDecoration(
    //                             borderRadius: BorderRadius.circular(16),
    //                             color: MyColors.onSecondary.withOpacity(0.4),
    //                           ),
    //                         ),
    //                       )),
    //                       errorWidget: (context, url, error) =>
    //                           const Icon(Icons.error),
    //                     ),
    //                   ),
    //                   Text(
    //                     getAdvertisementCategoryResult[index].name ?? '',
    //                     style: const TextStyle(
    //                         fontWeight: FontWeight.normal,
    //                         fontSize: 13,
    //                         color: Colors.black54),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           );
    //         },
    //       );
  }
}
