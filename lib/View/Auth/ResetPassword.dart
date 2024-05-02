import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Model/GeneralModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/webService.dart';

class reset_pass extends StatefulWidget {
  const reset_pass({super.key});

  @override
  State<reset_pass> createState() => _reset_passState();
}

class _reset_passState extends State<reset_pass> {
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  bool loader = false;
  var userId;
  String? selectedType;

  sentOtp() async {
    Map<String, dynamic> data = {
      "email": selectedType=="email"?email.text:mob.text,
      "type": selectedType
    };
    print("data....$data");
    setState(() {
      loader = true;
    });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$forgot_password", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      userId = resdata.result;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    userId: userId,
                  )));
    } else {
      showSnackbar(context, "Otp couldn't be sent");
      setState(() {
        loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: Padding(
      //         padding: EdgeInsets.all(10),
      //         child: SvgPicture.asset("assets/images/backButton.svg")),
      //   ),
      //   // title: Image.asset(
      //   //   MyImages.Logo,
      //   //   height: height * 0.05,
      //   //   width: width / 3,
      //   // ),
      //   // centerTitle: true,
      // ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
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
                  Image.asset("assets/images/PasswordResetImage.png",height: 200,)
                ],
              ),
              SizedBox(height: height*0.01,),              Center(
                  child: MainHeadingText(
                text: "Password Reset",
                textAlign: TextAlign.center,
                fontSize: 20,
              )),
              sizeBox_mq(context, width: width, height: 0.04),
              Center(
                  child: Text(
                "Please put your email or mobile number to\nreset your password",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.aBeeZee(fontSize: 13, color: Color(0xff7B6F72)),
              )),
              sizeBox_mq(context, width: width, height: 0.04),
              GestureDetector(onTap: (){
                   selectedType = "email";
                   setState(() {});
                   print("bjdsnfjd");
              },child:
              CustomTextFieldwithoutshadow(
                controller: email,
                hintText: 'Please enter email',
                labelText: 'Please enter email',
                prefixIcon: MyImages.email,
              ),),
              sizeBox_mq(context, width: width, height: 0.02),
              Text("Or"),
              sizeBox_mq(context, width: width, height: 0.02),
             GestureDetector(onTap: (){
               selectedType = "mobile";
               setState(() {});
             },child:
             CustomTextFieldwithoutshadow(
               controller: mob,
               hintText: 'Please enter Mobile Number',
               labelText: 'Please enter Mobile Number',
               prefixIcon: MyImages.mobile,
             ),),
              sizeBox_mq(context, width: width, height: 0.05),
              RoundButton(
                loading: loader,
                title: 'Next',
                onTap: () {
                  if(email.text.isEmpty&&mob.text.isEmpty){
                    showSnackbar(context, "Select either email or mobile");
                  }
                  else{
                    sentOtp();
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
