import 'package:ealaa_userr/View/Store/StoreUserProfile.dart';
import 'package:ealaa_userr/View/Store/storeHomeTab.dart';
import 'package:ealaa_userr/View/Utils/bottom_bar.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';

import '../Utils/GlobalData.dart';
import 'Bag.dart';
import 'Stores.dart';

enum CurrentTabIndex { first, second, third, fouth }

final ValueNotifier<CurrentTabIndex> selectedValue =
    ValueNotifier<CurrentTabIndex>(CurrentTabIndex.first);

class StoreBottomBar extends StatefulWidget {
  const StoreBottomBar({Key? key}) : super(key: key);

  @override
  State<StoreBottomBar> createState() => _StoreBottomBarState();
}

class _StoreBottomBarState extends State<StoreBottomBar> {
  void onTap(int index) {
    setState(() {
      currentindex = index;
    });
    switch (index) {
      case 0:
        {
          selectedValue.value = CurrentTabIndex.first;
        }
        break;
      case 1:
        {
          selectedValue.value = CurrentTabIndex.second;
        }
        break;
      case 2:
        {
          selectedValue.value = CurrentTabIndex.third;
        }
        break;
      case 3:
        {
          selectedValue.value = CurrentTabIndex.fouth;
        }
        break;
      //   case 4: {
      //     selectedValue.value = CurrentTabIndex.fifth;
      // } break;
    }
    print("index is.....$index");
  }
  Future<bool> onWillPop() async {

    pushReplacement(context: context, screen: Bottom_bar(key: null,));
    return Future.value(true); //back all class & exit
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: ValueListenableBuilder<CurrentTabIndex>(
              valueListenable: selectedValue,
              builder: (context, CurrentTabIndex value, child) {
                switch (value) {
                  case CurrentTabIndex.first:
                    return StoreHomeTab();
                  case CurrentTabIndex.second:
                    return Stores();
                  case CurrentTabIndex.third:
                    return Bag();
                  case CurrentTabIndex.fouth:
                    return StoreUserProfile();
                  //case CurrentTabIndex.fifth: return  StoreUserProfile();
                  // case CurrentTabIndex.second: return  SearchProduct();
                }
              }),
          // pages[currentindex],
          bottomNavigationBar: ValueListenableBuilder<CurrentTabIndex>(
              valueListenable: selectedValue,
              builder: (context, CurrentTabIndex value, child) {
                return BottomNavigationBar(
                  selectedLabelStyle: TextStyle(
                      height: 1.5,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Color(0xffFFFFFF),
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage(MyImages.home),
                          size: 22,
                        ),
                        label: 'Home',
                        backgroundColor: Color(0xff000000)),
                    // BottomNavigationBarItem(
                    //     icon: ImageIcon(
                    //       AssetImage(
                    //         MyImages.searchOrder,
                    //       ),
                    //       size: 22,
                    //     ),
                    //     label: 'Search',
                    //     backgroundColor: Color(0xff000000)),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage(
                            "assets/images/StoresIcon.png",
                          ),
                          size: 22,
                        ),
                        label: 'Stores',
                        backgroundColor: Color(0xff000000)),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage(
                            MyImages.bag,
                          ),
                          size: 22,
                        ),
                        label: 'Bag',
                        backgroundColor: Color(0xff000000)),
                    BottomNavigationBarItem(
                        icon: ImageIcon(
                          AssetImage(
                            MyImages.profile,
                          ),
                          size: 22,
                        ),
                        label: 'Profile',
                        backgroundColor: Color(0xff000000)),
                  ],
                  currentIndex: updateCurrentIndex(value),
                  unselectedItemColor: MyColors.secondarycolor,
                  selectedItemColor: Color(0xffFFAF00),
                  selectedIconTheme: IconThemeData(
                    color: MyColors.primaryColor,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: MyColors.secondarycolor,
                  ),
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: onTap,
                );
              }),
        ));
  }

  int updateCurrentIndex(CurrentTabIndex value) {
    switch (value) {
      case CurrentTabIndex.first:
        return 0;
      case CurrentTabIndex.second:
        return 1;
      case CurrentTabIndex.third:
        return 2;
      case CurrentTabIndex.fouth:
        return 3;
      // case CurrentTabIndex.fifth: return  4;
    }
  }
}
