import 'package:ealaa_userr/Model/advertisement_model/getPostByCategoryModel.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/ad_subcategory_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import '../common/common_widgets.dart';
import 'ad_product_detail.dart';

class PostByCategory extends StatefulWidget {
  final String advertisement_category_id;
  final SubcategoryResult selectedSubcategory;

  PostByCategory(
      {super.key,
      required this.advertisement_category_id,
      required this.selectedSubcategory});

  @override
  State<PostByCategory> createState() => _PostByCategoryState();
}

class _PostByCategoryState extends State<PostByCategory> {
  bool showProgressBar = true;
  List<getPostByCategoryResult> postList = [];

  getAdvertisementPostsApi() async {
    var res = await Webservices.getMap(
        "$baseUrl$get_advertisement_posts_category?category_id=${widget.advertisement_category_id}&user_id=$userId&sub_category_id=${widget.selectedSubcategory.id}");
    print("status from api ${res}");
    showProgressBar = false;
    setState(() {});
    final resdata = getPostByCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      postList = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    getAdvertisementPostsApi();
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
          widget.selectedSubcategory.subCategoryName!, // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: showPosts(),
      ),
    );
  }

  Widget showPosts() {
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
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 100,
                maxCrossAxisExtent: 140,
                mainAxisExtent: 170,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: postList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AdProductDetail(id: postList[index].id ?? '')),
                    );
                    getAdvertisementPostsApi();
                  },
                  child: Container(
                    height: 160,
                    // width: 110,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: postList[index].image ?? '',
                                height: 100,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: Shimmer.fromColors(
                                    baseColor:
                                        MyColors.onSecondary.withOpacity(0.4),
                                    highlightColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    child: Container(
                                      height: 85,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: MyColors.onSecondary
                                            .withOpacity(0.4),
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                showProgressBar = true;
                                await Webservices.getMap(
                                    "$baseUrl$advertisement_post_fav?advertisement_post_id=${(postList[index].id != null && postList[index].id!.isNotEmpty) ? postList[index].id! : ''}&user_id=${userId}");
                                var res = await Webservices.getMap(
                                    "$baseUrl$get_advertisement_posts_category?category_id=${widget.advertisement_category_id}&user_id=$userId&sub_category_id=${widget.selectedSubcategory.id}");
                                print("status from api ${res}");
                                final resdata =
                                getPostByCategoryModel.fromJson(res);
                                print(resdata);
                                if (resdata.result != null &&
                                    resdata.status == '1') {
                                  postList =
                                      resdata.result!;
                                  setState(() {});
                                } else {
                                  showSnackbar(context, resdata.message ?? '');
                                }
                                showProgressBar = false;
                              },
                              borderRadius: BorderRadius.circular(4),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                margin: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Icon(
                                    postList[index].advertisementPostFav !=
                                                null &&
                                            postList[index]
                                                    .advertisementPostFav ==
                                                'true'
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                postList[index].bedroom ?? 'Product',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                postList[index].description ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.black54),
                                maxLines: 2,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
