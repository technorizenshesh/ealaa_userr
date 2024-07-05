import 'package:ealaa_userr/View/SideBar/Profile.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SideBar/About.dart';
import '../SideBar/Privacy.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List image = [
    "assets/images/Frame 27@3x.png",
    "assets/images/bike1.png",
  ];

  bool notification = false;

  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          title: Text(
            'Profile',
            style: TextStyle(fontSize: 18),
          )),
      body:
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
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
                        leading: Image.asset(
                          MyImages.MyAccount,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "My Account ",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.lightblackcolor),
                        ),
                        subtitle: Text(
                          "Make changes to your account",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: MyColors.lightgreycolor),
                        ),
                        trailing: Image.asset(
                          MyImages.arrow,
                          width: 10,
                        ),
                        onTap: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return EditProfile();
                              }));
                        },
                      ),
                      ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        leading: Image.asset(
                          MyImages.Touchid,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Face ID / Touch ID ",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.lightblackcolor),
                        ),
                        subtitle: Text(
                          "Manage your device security",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: MyColors.lightgreycolor),
                        ),
                        trailing:
                        Container(
                          width: 50,
                          child: FlutterSwitch(
                            activeText: " ",
                            inactiveText: " ",
                            // height: 40,
                            activeColor: MyColors.primaryColor,
                            toggleColor: Colors.white,
                            inactiveColor: Color(0xffD5DDE0),
                            value: notification,
                            valueFontSize: 15.0,
                            toggleSize: 10,
                            width: 40,
                            height: 20,
                            borderRadius: 20.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                notification = val;
                              });
                            },
                          ),
                        )
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        leading:      Image.asset(
                          MyImages.logout,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Log out ",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: MyColors.lightblackcolor),
                        ),
                        subtitle: Text(
                          "Want to logout from the app",
                          style: GoogleFonts.beVietnamPro(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: MyColors.lightgreycolor),
                        ),
                        trailing: Image.asset(
                          MyImages.arrow,
                          width: 10,
                        ),
                        onTap: (){
                          _showDialog(context);
                        },
                      ),
                    ],
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
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: MyColors.whitecolor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        leading:      Image.asset(
                          MyImages.Privaciy,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Privaciy Notice",
                          style: GoogleFonts.beVietnamPro(
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
                                return Privacy();
                              }));
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        leading:      Image.asset(
                          MyImages.About,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "About App",
                          style: GoogleFonts.beVietnamPro(
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
                                return About();
                              }));
                        },
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        leading:      Image.asset(
                          MyImages.Review,
                          width: 40,
                        ),
                        titleAlignment: ListTileTitleAlignment.center,
                        title: Text(
                          "Review",
                          style: GoogleFonts.beVietnamPro(
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
                          //       return About();
                          //     }));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold)),
          content: Text("Are you sure you want to Log out?",style: TextStyle(fontSize: 16),),
          actions: <Widget>[
            TextButton(
              child:  Text("No",
                  style: TextStyle(
                    fontSize: 18,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:Text("Yes",
                  style: TextStyle(
                      fontSize: 18,
                      color: MyColors.primaryColor,
                      fontWeight: FontWeight.bold)),
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false);
                // pushReplacement(context: context, screen: Login());
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
              },
            ),
          ],
        );
      },
    );
  }
}
