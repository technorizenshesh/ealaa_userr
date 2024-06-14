import 'package:ealaa_userr/advertisement/AddPost/SparePart.dart';
import 'package:ealaa_userr/advertisement/AddPost/transfer_type.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../../Model/advertisement_model/get_advertisement_category_model.dart';
import '../../View/Utils/ApiConstants.dart';
import '../../View/Utils/CustomSnackBar.dart';
import '../../View/Utils/GlobalData.dart';
import '../../View/Utils/webService.dart';
import '../../common/common_widgets.dart';
import '../ad_sub_categories.dart';
import 'ad_post_subcategories.dart';

class ListAnythingFree extends StatefulWidget {
  const ListAnythingFree({super.key});

  @override
  State<ListAnythingFree> createState() => _ListAnythingFreeState();
}

class _ListAnythingFreeState extends State<ListAnythingFree> {
  bool showProgressBar = false;

  getAdvertisementCategoryApi() async {
    showProgressBar = true;
    setState(() {});
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    showProgressBar = true;
    setState(() {});
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      advertisementCategoryList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    if (advertisementCategoryList == [] || advertisementCategoryList.isEmpty) {
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
          title: const Text(
            'List anything for FREE!', // Your badge count here
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: (advertisementCategoryList.isNotEmpty ||
                  advertisementCategoryList != [])
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.76,
                  //  height: 110,
                  child: showCategory(),
                )
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
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 100, mainAxisSpacing: 5),
            itemCount: advertisementCategoryList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return GestureDetector(
                onTap: () {
                  if (advertisementCategoryList[index].id == "1" ||
                      advertisementCategoryList[index].id == "2" ||
                      advertisementCategoryList[index].id == "5" ||
                      advertisementCategoryList[index].id == "6" ||
                      advertisementCategoryList[index].id == "7" ||
                      advertisementCategoryList[index].id == "8" ||
                      advertisementCategoryList[index].id == "10") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Ad_Post_Subcategories(
                          title: index == 0 || index == 1
                              ? 'Body'
                              : index == 4 || index == 5
                                  ? 'Property Type'
                                  : index == 6 || index == 7
                                      ? 'Select Type'
                                      : index == 9
                                          ? 'Animal Type'
                                          : "",
                          advertisement_category_id:
                              advertisementCategoryList[index].id ?? '',
                        ),
                      ),
                    );
                  }
                  else if(advertisementCategoryList[index].id == "3"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SparePart(
                          advertisement_category_id:
                          advertisementCategoryList[index].id ?? '',
                        ),
                      ),
                    );
                  }
                  else if(advertisementCategoryList[index].id == "4"){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TransferType(
                          advertisement_category_id:
                          advertisementCategoryList[index].id ?? '',
                        ),
                      ),
                    );
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
                                advertisementCategoryList[index].image ?? '',
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
                        advertisementCategoryList[index].name ?? '',
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
