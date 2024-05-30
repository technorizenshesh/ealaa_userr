import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shimmer/shimmer.dart';

import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';
import 'ad_sub_categories.dart';

class AdViewAllCategories extends StatefulWidget {
  const AdViewAllCategories({super.key});

  @override
  State<AdViewAllCategories> createState() => _AdViewAllCategoriesState();
}

class _AdViewAllCategoriesState extends State<AdViewAllCategories> {
  TextEditingController search = TextEditingController();
  bool showProgressBar = false;
  List<GetAdvertisementCategoryResult> getAdvertisementCategoryResult = [];

  getAdvertisementCategoryApi() async {
    showProgressBar = true;
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      getAdvertisementCategoryResult = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
    showProgressBar = false;
  }

  @override
  void initState() {
    getAdvertisementCategoryApi();
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
        title: const Text(
          'All Categories', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: showProgressBar
            ? CommonWidget.commonShimmer(
                itemCount: 4,
                shimmerWidget: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 2),
                  clipBehavior: Clip.hardEdge,
                ))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: getAdvertisementCategoryResult.length,
                itemBuilder: (context, int index) {
                  //  GetClubsResult item = controller.getClubsModel!.result![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdSubCategories(
                            title: getAdvertisementCategoryResult[index].name ??
                                '',
                            advertisement_category_id:
                                getAdvertisementCategoryResult[index].id ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(
                              color: Colors.orangeAccent.withOpacity(0.7),
                              width: 2)),
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5),
                      padding: const EdgeInsets.only(
                          left: 3, right: 3, top: 5, bottom: 5),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl:
                                  getAdvertisementCategoryResult[index].image ??
                                      '',
                              height: 60,
                              fit: BoxFit.fill,
                              placeholder: (context, url) => Center(
                                  child: Shimmer.fromColors(
                                baseColor:
                                    MyColors.onSecondary.withOpacity(0.4),
                                highlightColor:
                                    Theme.of(context).colorScheme.onSecondary,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color:
                                        MyColors.onSecondary.withOpacity(0.4),
                                  ),
                                ),
                              )),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                          Text(
                            getAdvertisementCategoryResult[index].name ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
