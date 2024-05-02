import 'package:ealaa_userr/Model/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class OtpScreen extends StatefulWidget {
  final String userId;
  const OtpScreen({super.key, required this.userId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp ='';
  bool loading = false;

  verifyOtp(String otp) async {
    Map<String, dynamic> data = {
      "user_id": widget.userId,
      "otp": otp,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$check_otp", body: data, context: context);
    print("status from api ${res}");
    final resdata = ProfileModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CreateNewPassword
        (userId: resdata.result!.id!, token: resdata.result!.token!,)));
    } else {
      showSnackbar(context, "Otp couldn't be verified");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height*0.05,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: SvgPicture.asset("assets/images/backButton.svg")),
                  ),
                  SizedBox(width: 20,),
                  Image.asset("assets/images/CheckMailImage.png",height: 200,)
                ],
              ),
              SizedBox(height: height*0.01,),
              Center(child: MainHeadingText(text: 'Check your mail',fontSize: 20,)),
              SizedBox(height: height*0.01,),
              Center(child: ParagraphText(text: "Please put the 4 digits sent to you",fontSize: 15,)),
              SizedBox(height: height*0.05,),
              _otp_field(),
              //
              // sizeBox_mq(context, width: width, height: 0.13) ,
              // RoundButton(title: 'Next',
              //   loading: loading
              //   ,onTap: () async {
              //   push(context: context, screen:CreateNewPassword() );
              //   },),
            ],),
        ),
      ),

    );
  }
  Widget _otp_field() {
    return  OtpTextField(
      margin: EdgeInsets.all(11),
      decoration: InputDecoration(

      ),
      fillColor: Color(0xffF7F8F8),
      filled: true,
      cursorColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      numberOfFields: 4,
      borderColor:MyColors.primaryColor,
      focusedBorderColor:MyColors.primaryColor,
      showFieldAsBox: true,
      borderWidth: 1.0,
      fieldWidth: 55,
      //runs when a code is typed in
      onCodeChanged: (String code) {
        //handle validation or checks here if necessary
      },
      //runs when every textfield is filled
      onSubmit: (String verificationCode) {
        verifyOtp(verificationCode);
      },
    );
  }
}
