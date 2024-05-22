import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_product_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

class AdMyFavorites extends StatefulWidget {
  const AdMyFavorites({super.key});

  @override
  State<AdMyFavorites> createState() => _AdMyFavoritesState();
}

class _AdMyFavoritesState extends State<AdMyFavorites> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;
  String notificationCount = "";

  List<Map<String, String>> rentalList = [
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_home2.png"
    },
    {
      'name': "AED- 33,000",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_house1.png"
    },
  ];

  clickOnItem(String image) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdProductDetail(image: image)),
    );
  }

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
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
          'My Favorites', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: showPopularRental(width, height),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show Popular Rental  ...
  Widget showPopularRental(double sizeWidth, double sizeHeight) {
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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: ((sizeWidth - 60) / 2) / (sizeHeight / 4),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: rentalList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                margin:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: GestureDetector(
                  onTap: () {
                    clickOnItem(rentalList[index]['image'] ?? '');
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              rentalList[index]['image'] ?? '',
                              height: sizeHeight / 7,
                              width: ((sizeWidth - 60) / 2),
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 5,
                              right: 2,
                              child: Image.asset(
                                MyImages.icRedHeart,
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 3, bottom: 10, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                rentalList[index]['name'] ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.orange),
                              ),
                              Text(
                                rentalList[index]['description'] ?? '',
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
