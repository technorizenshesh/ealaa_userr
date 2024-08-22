import 'package:ealaa_userr/advertisement/ad_my_ads_post.dart';
import 'package:ealaa_userr/advertisement/ad_my_profile.dart';
import 'package:ealaa_userr/advertisement/ad_my_save_search.dart';
import 'package:ealaa_userr/advertisement/ad_notification.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../View/SideBar/Profile.dart';
import '../View/Utils/GlobalData.dart';

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
      MaterialPageRoute(
          builder: (context) => AdMyAdsPosts(
                userIdValue: userId,
              )),
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
      MaterialPageRoute(
          builder: (context) => AdMyAdsPosts(
                FavValue: true,
                userIdValue: userId,
              )),
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
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  width: width,
                  height: height * 0.1,
                  decoration: BoxDecoration(
                      color: MyColors.primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      // Adjust the border radius as needed
                      child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Border color
                              width: 3.0, // Border width
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CachedNetworkImage(
                              imageUrl: profileResult!.image!,
                              width: 53,
                              height: 53,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          )
                          // Image.asset(
                          //   MyImages.user,
                          //   width: 53,
                          // ),
                          ),
                    ),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: profileResult!.userName == ""
                        ? Container(
                            width: 0,
                            height: 0,
                          )
                        : Text(
                            profileResult!.userName!,
                            style: GoogleFonts.beVietnamPro(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: MyColors.whitecolor),
                            overflow: TextOverflow.ellipsis,
                          ),
                    subtitle: Text(
                      profileResult!.email!,
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: MyColors.whitecolor),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: InkWell(
                        onTap: () async {
                          await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return EditProfile();
                          }));
                          setState(() {
                            profileResult;
                          });
                        },
                        child: Image.asset(
                          MyImages.edit,
                          width: 20,
                        )),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Material(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: MyColors.whitecolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          // clickOnMyProfile();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditProfile();
                              },
                            ),
                          );
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
                      /*ListTile(
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
                      ),*/
                    ],
                  ),
                ),
              ) /*
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
