import 'package:ealaa_userr/advertisement/AddPost/List_anything_free.dart';
import 'package:ealaa_userr/advertisement/ad_chats.dart';
import 'package:ealaa_userr/advertisement/ad_home.dart';
import 'package:ealaa_userr/advertisement/ad_profile.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import 'ad_my_ads_post.dart';

class AdBottomBar extends StatefulWidget {
  const AdBottomBar({super.key});

  @override
  AdBottomBarState createState() => AdBottomBarState();
}

class AdBottomBarState extends State<AdBottomBar> {
  int _currentindex = 0;
  void onTap(int index) {
    setState(() {
      _currentindex = index;
    });
    print(_currentindex);
  }

  final pages = [
    const AdHome(),
    const AdChats(),
    const ListAnythingFree(),
    //const AdPostAds(),
    //const AdAds(),
    AdMyAdsPosts(),
    const AdProfile(),
  ];

  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentindex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
            height: 1.5,
            fontSize: 12,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins'),
        unselectedLabelStyle: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xffFFFFFF),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(MyImages.home),
                size: 22,
              ),
              label: 'Home',
              backgroundColor: Color(0xff000000)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  MyImages.icChat,
                ),
                size: 22,
              ),
              label: 'Chats',
              backgroundColor: Color(0xff000000)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  MyImages.add,
                ),
                size: 22,
              ),
              label: 'Add Post',
              backgroundColor: Color(0xff000000)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  MyImages.icAds,
                ),
                size: 22,
              ),
              label: 'My Ads',
              backgroundColor: Color(0xff000000)),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(
                  MyImages.icProfile,
                ),
                size: 22,
              ),
              label: 'Account',
              backgroundColor: Color(0xff000000)),
        ],
        currentIndex: _currentindex,
        unselectedItemColor: MyColors.secondarycolor,
        selectedItemColor: const Color(0xffFFAF00),
        selectedIconTheme: const IconThemeData(
          color: MyColors.primaryColor,
        ),
        unselectedIconTheme: const IconThemeData(
          color: MyColors.secondarycolor,
        ),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: onTap,
      ),
    );
  }
}
