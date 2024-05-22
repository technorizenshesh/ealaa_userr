import 'package:ealaa_userr/advertisement/ad_myAds.dart';
import 'package:ealaa_userr/advertisement/ad_myFavorites.dart';
import 'package:ealaa_userr/advertisement/ad_my_profile.dart';
import 'package:ealaa_userr/advertisement/ad_my_save_search.dart';
import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

class AdProfile extends StatefulWidget {
  const AdProfile({super.key});

  @override
  State<AdProfile> createState() => _AdProfileState();
}

class _AdProfileState extends State<AdProfile> {
  bool isMap = false;
  bool showProgressBar = false;

  String notificationCount = "";

  clickOnMyAd() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdMyAds()),
    );
  }

  clickOnNotification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdNotification()),
    );
  }

  clickOnMyFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdMyFavorites()),
    );
  }

  clickOnMySaveSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdMySaveSearchedView()),
    );
  }

  clickOnMyProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdMyProfile()),
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
      // Assign the key to Scaffold.
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
          'Profile', // Your badge count here
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  'assets/images/Ellipse 1.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              ListTile(
                onTap: () {
                  clickOnMyAd();
                },
                leading: Image.asset(
                  MyImages.icAd,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                title: const Text(
                  'My Ads',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () {
                  clickOnMyFavorites();
                },
                leading: Image.asset(
                  MyImages.icLike,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                title: const Text(
                  'My Favorites',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () {
                  clickOnMySaveSearch();
                },
                leading: Image.asset(
                  MyImages.icSearch,
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                title: const Text(
                  'My Saved Searches',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SETTINGS',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  clickOnMyProfile();
                },
                leading: const Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.black54,
                ),
                title: const Text(
                  'My Profile',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.location_city_outlined,
                  size: 20,
                  color: Colors.black54,
                ),
                title: const Text(
                  'City',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.g_translate_outlined,
                  size: 20,
                  color: Colors.black54,
                ),
                title: const Text(
                  'Language',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.logout,
                  size: 20,
                  color: Colors.black54,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
                indent: 10,
                endIndent: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
