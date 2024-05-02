import 'package:ealaa_userr/View/Screens/EditUserProfile.dart';
import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:flutter/material.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Model/GeneralModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool? notification;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var Data;

 @override
  void initState() {
    // TODO: implement initState
   if (profileResult!.notifiStatus == "ON") {
     notification = true;
     setState(() {});
   } else {
     notification = false;
     setState(() {});
   }
    super.initState();
  }

  notificationEnableDisable() async {
    Map<String, dynamic> data = {
      "id": userId,
      "status": notification==true?"ON":"OFF",
      "type":"user"
    };
    var res = await Webservices.postData(
        apiUrl: "$update_notification_onoff", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      profileResult!.notifiStatus = resdata.result;
      showSnackbar(context, "Notifications are currently ${resdata.result}");
    } else {
      showSnackbar(context, resdata.message!);
    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      // drawer: My_Drawer(),
      appBar: AppBar(
          toolbarHeight: 80,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
                padding: EdgeInsets.all(10),
                child: SvgPicture.asset("assets/images/backButton.svg")),
          ),
          centerTitle: true,
          title: Text("Edit Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ))),
      body:
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: height * 0.8,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.primaryColor, // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl:profileResult!.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child:
                          CircularProgressIndicator(color: MyColors.primaryColor,)),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                    sizeBox_mq(context, width: 0, height: 0.02),
                    profileResult!.userName==""?Container():
                    MainHeadingText(
                      text: profileResult!.userName!,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff3E4958),
                    ),
                    // sizeBox_mq(context, width: 0, height: 0.01)  ,
                    ParagraphText(text:profileResult!.email!),
                    sizeBox_mq(context, width: 0, height: 0.06),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_phone.png",
                            height: 30,
                            width: 30,
                          ),
                          sizeBox_mq(context, width: 0.04, height: 0.0),
                          ParagraphText(
                            text: "${profileResult!.mobile}",
                            fontSize: 15,
                            color: Color(0xff3E4958),
                          )
                        ],
                      ),
                    ),
                    sizeBox_mq(context, width: 0, height: 0.01),

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider()),
                    sizeBox_mq(context, width: 0, height: 0.01),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/ic_mail.png",
                            height: 30,
                            width: 30,
                          ),
                          sizeBox_mq(context, width: 0.04, height: 0.0),
                          ParagraphText(
                            text: "${profileResult!.email}",
                            fontSize: 15,
                            color: Color(0xff3E4958),
                          )
                        ],
                      ),
                    ),

                    sizeBox_mq(context, width: 0, height: 0.01),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider()),
                    sizeBox_mq(context, width: 0, height: 0.01),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/images/facebook.svg",
                            height: 30,
                            width: 30,
                          ),
                          sizeBox_mq(context, width: 0.04, height: 0.0),
                          ParagraphText(
                            text: "@carsonmobility",
                            fontSize: 15,
                            color: Color(0xff3E4958),
                          )
                        ],
                      ),
                    ),
                    sizeBox_mq(context, width: 0, height: 0.08),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notifications",
                                style: GoogleFonts.beVietnamPro(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              ParagraphText(
                                text: "For receiving driver messages",
                                color: MyColors.grey1color,
                                fontSize: 16,
                              )
                            ],
                          ),
                          FlutterSwitch(
                            activeText: " ",
                            inactiveText: " ",
                            // height: 40,
                            activeColor: MyColors.primaryColor,
                            toggleColor: Colors.white,
                            inactiveColor: Color(0xffD5DDE0),
                            value: notification!,
                            valueFontSize: 15.0,
                            toggleSize: 20,
                            width: 45,
                            height: 25,
                            borderRadius: 20.0,
                            showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                notification = val;
                              });
                              notificationEnableDisable();
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,
                  child: Container(width:width-32,child: Center(child: RoundButton(title: "Update Profile", onTap: () async {
                    await push(context: context, screen: EditUserProfile());
                    setState(() {
                      profileResult ;
                    });
                  }))))
            ],
          ),
        ),
      ),
    );
  }
}
