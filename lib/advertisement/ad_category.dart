import 'package:ealaa_userr/advertisement/ad_discription.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import '../Model/CityModel.dart';
import '../Model/advertisement_model/get_advertisement_category_model.dart';
import '../View/Utils/ApiConstants.dart';
import '../View/Utils/CustomSnackBar.dart';
import '../View/Utils/webService.dart';

class AdCategory extends StatefulWidget {
  final CityResult selectedCity;

  const AdCategory({super.key, required this.selectedCity});

  @override
  State<AdCategory> createState() => _AdCategoryState();
}

class _AdCategoryState extends State<AdCategory> {
  bool showProgressBar = true;
  List<GetAdvertisementCategoryResult> advertisementCategory = [];

  getAdvertisementCategoryApi() async {
    var res = await Webservices.getMap("$baseUrl$get_advertisement_category");
    print("status from api ${res}");
    showProgressBar = false;
    final resdata = GetAdvertisementCategoryModel.fromJson(res);
    print(resdata);
    if (resdata.result != null && resdata.status == '1') {
      advertisementCategory = resdata.result!;
      setState(() {});
    } else {
      showSnackbar(context, resdata.message ?? '');
    }
  }

  @override
  void initState() {
    getAdvertisementCategoryApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          'What are you listing?', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: showProgressBar
          ? Center(
              child: CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            )
          : advertisementCategory.isEmpty
              ? Image.asset("assets/images/NoDataFound.png")
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Container(
                      width: width,
                      height: height,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 20, // Spacing between columns
                          mainAxisSpacing: 50, // Spacing between rows
                        ),
                        itemCount: advertisementCategory.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdDescription(
                                      selectedCategory:
                                          advertisementCategory[index],
                                      selectedCity: widget.selectedCity,
                                    ),
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.orange)),
                              child: Card(
                                elevation: 0,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            advertisementCategory[index].image!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        advertisementCategory[index].name!,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
    );
  }
}
