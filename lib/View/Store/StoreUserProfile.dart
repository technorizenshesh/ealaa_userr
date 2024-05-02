import 'package:ealaa_userr/View/Store/AddressHO.dart';
import 'package:ealaa_userr/View/Store/HelpCenter.dart';
import 'package:ealaa_userr/View/Store/MyAccount.dart';
import 'package:ealaa_userr/View/Store/MyStoreOrder.dart';
import 'package:ealaa_userr/View/Store/PaymentStore.dart';
import 'package:ealaa_userr/View/Store/WishList.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter/services.dart';

import '../SideBar/Profile.dart';
import '../Utils/GlobalData.dart';

class StoreUserProfile extends StatefulWidget {
  const StoreUserProfile({Key? key}) : super(key: key);

  @override
  State<StoreUserProfile> createState() => _StoreUserProfileState();
}

class _StoreUserProfileState extends State<StoreUserProfile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle(
      //   // Status bar color
      //   statusBarColor: Color(0xff3B4051),
      //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
      // ),
      //   backgroundColor:Color(0xff3B4051),
      //   elevation: 0,
      //   leading: GestureDetector(
      //     onTap:(){
      //       Navigator.pop(context);},
      //     child: Padding(
      //       padding: const EdgeInsets.all(10),
      //       child: SvgPicture.asset("assets/images/backButton.svg"),
      //     ),
      //   ),
      //   actions: [
      //     SvgPicture.asset("assets/images/BellIconOrange.svg"),
      //     SizedBox(width: 20,),
      //   ],
      //
      // ),
      body:
              Padding(padding:EdgeInsets.fromLTRB(20,
              100,20,0),child:
              Column(
                children: [
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
                        leading:
                        ClipRRect(
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
                              child:  ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl:profileResult!.image!,
                                  width: 53,
                                  height: 53,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              )
                            // Image.asset(
                            //   MyImages.user,
                            //   width: 53,
                            // ),
                          ),
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title:
                        profileResult!.userName==""?Container(width: 0,height: 0,):
                        Text(
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
                                profileResult ;
                              });
                            },
                            child: Image.asset(
                              MyImages.edit,
                              width: 20,
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
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
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            leading: SvgPicture.asset(
                              "assets/images/PaymentIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "Wallet",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return PaymentStore();
                                  }));
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            leading: SvgPicture.asset(
                              "assets/images/MyOrderIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "My Order",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return MyStoreOrder();
                                  }));
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical : 5),
                            leading: SvgPicture.asset(
                              "assets/images/HelpIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "My WishList",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return WishList();
                                  }));
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            leading: SvgPicture.asset(
                              "assets/images/OrderTrackingIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "Order Tracking",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //       return EditProfile();
                              //     }));
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 5),
                            leading: SvgPicture.asset(
                              "assets/images/AddressIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddressHO();
                                  }));
                            },
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical : 5),
                            leading: SvgPicture.asset(
                              "assets/images/HelpIcon.svg",
                              width: 40,
                            ),
                            titleAlignment: ListTileTitleAlignment.center,
                            title: Text(
                              "Help Center",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: MyColors.lightblackcolor),
                            ),
                            trailing: Image.asset(
                              MyImages.arrow,
                              width: 10,
                            ),
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return HelpCenter();
                                  }));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: Image.asset(
                  //     MyImages.MyAccount,
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "My Account ",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //           return MyAccount();
                  //         }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: SvgPicture.asset(
                  //     "assets/images/PaymentIcon.svg",
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "Payment",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //           return PaymentStore();
                  //         }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: SvgPicture.asset(
                  //     "assets/images/MyOrderIcon.svg",
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "My Order",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //           return MyStoreOrder();
                  //         }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: SvgPicture.asset(
                  //     "assets/images/OrderTrackingIcon.svg",
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "Order Tracking",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     // Navigator.push(context,
                  //     //     MaterialPageRoute(builder: (context) {
                  //     //       return EditProfile();
                  //     //     }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: SvgPicture.asset(
                  //     "assets/images/AddressIcon.svg",
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "Address",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //           return AddressHO();
                  //         }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: SvgPicture.asset(
                  //     "assets/images/HelpIcon.svg",
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "Help Center",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //           return HelpCenter();
                  //         }));
                  //   },
                  // ),
                  // ListTile(
                  //   contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  //   leading: Image.asset(
                  //     MyImages.logout,
                  //     width: 35,
                  //   ),
                  //   titleAlignment: ListTileTitleAlignment.center,
                  //   title: Text(
                  //     "Log out",
                  //     style: TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w500,
                  //         color: MyColors.lightblackcolor),
                  //   ),
                  //   trailing: Image.asset(
                  //     MyImages.arrow,
                  //     width: 7,
                  //   ),
                  //   onTap: (){
                  //     _showDialog(context);
                  //   },
                  // ),

                ],
              ),)

    );
  }
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to Log out?"),
          actions: <Widget>[
            TextButton(
              child: new Text("No",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes",
                  style: TextStyle(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.of(context).pop();

                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Login(),
                //     ),
                //         (route) => false);
                // // pushReplacement(context: context, screen: Login());
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
