import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/advertisement/ad_product_detail.dart';
import 'package:ealaa_userr/common/common_widgets.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

class AdAds extends StatefulWidget {
  const AdAds({super.key});

  @override
  State<AdAds> createState() => _AdAdsState();
}

class _AdAdsState extends State<AdAds> {
  TextEditingController search = TextEditingController();
  bool isMap = false;
  bool showProgressBar = false;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key

  List<Map<String, String>> furnitureList = [
    {
      'name': "Studio- 4 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "Studio- 3 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
    {
      'name': "Studio- 4 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture1.png"
    },
    {
      'name': "Studio- 3 Rooms",
      "description": "Studio- 4 Rooms \n AI Barsha South 2",
      'image': "assets/icons/ic_furniture2.png"
    },
  ];
  int drawerIndex = 0;
  String notificationCount = "";

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
      key: _key, // Assign the key to Scaffold.
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
          'Ads', // Your badge count here
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      clickOnNotification();
                    },
                    child: Stack(
                      children: <Widget>[
                        const Icon(
                          Icons.notifications,
                          size: 32,
                          color: Colors.white,
                        ), // Your icon here
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: notificationCount == "0" ||
                                      notificationCount == ""
                                  ? Colors.transparent
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              notificationCount, // Your badge count here
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SvgPicture.asset("assets/images/Notification.svg",height: 30,color: MyColors.primaryColor,)
                ],
              ))
        ],
      ),
      drawer: filterDrawer(),
      endDrawer: shortDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      print('hiiiii......');
                      setState(() {
                        drawerIndex = 0;
                      });
                      _key.currentState!.openDrawer();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.icFilter2,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.withOpacity(0.4)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, right: 5),
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black45,
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Search best deal',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Colors.black54),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      print('hiiiii......');
                      setState(() {
                        drawerIndex = 1;
                      });
                      _key.currentState!.openEndDrawer();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        MyImages.icFilter1,
                        height: 20,
                        width: 20,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: showCurrentAds(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Show Popular Furniture  ...
  Widget showCurrentAds() {
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
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: furnitureList.length,
            itemBuilder: (context, int index) {
              //  GetClubsResult item = controller.getClubsModel!.result![index];
              return Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                elevation: 2,
                clipBehavior: Clip.hardEdge,
                margin:
                    const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                child: Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.hardEdge,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            furnitureList[index]['image'] ?? '',
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Image.asset(
                              MyImages.icUnlike,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    furnitureList[index]['name'] ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.orange),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    clickOnItem(
                                        furnitureList[index]['image'] ?? '');
                                  },
                                  child: const SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 20,
                                      color: Colors.black54,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Text(
                              furnitureList[index]['description'] ?? '',
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
              );
            },
          );
  }

  /// OpenFilterDrawer ....
  Widget filterDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 40, bottom: 20),
            child: const Text('Filter',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Category',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Type',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'City',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Show english Ads only',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Real Estate Agent',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Amenties',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text(
                      'Listed By',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CommonWidget.commonElevatedButton(
                      onPressed: () {},
                      context: context,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      buttonMargin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// OpenShortDrawer ....
  Widget shortDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(top: 40, bottom: 20),
            child: const Text('Sort',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange)),
          ),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      'Listed By',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.orangeAccent,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CommonWidget.commonElevatedButton(
                      onPressed: () {},
                      context: context,
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      buttonMargin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
