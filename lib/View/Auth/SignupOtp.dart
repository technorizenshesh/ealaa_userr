import 'package:ealaa_userr/Model/GeneralModel.dart';

import '../../Model/ProfileModel.dart';
import '../../import_ealaa_user.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/bottom_bar.dart';
import '../Utils/webService.dart';

class SignupOtp extends StatefulWidget {
  const SignupOtp({super.key});

  @override
  State<SignupOtp> createState() => _SignupOtpState();
}

class _SignupOtpState extends State<SignupOtp> {
  int timerSeconds = 60; // Initial timer duration
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerSeconds > 0) {
          timerSeconds--;
        } else {
          timer.cancel();
          expireOtp(); // Call expireOtp function when timer reaches 0

          // Handle OTP expiry here
        }
      });
    });
  }

  expireOtp()async{
    var res = await Webservices.getMap(
        "$baseUrl$otp_expire?user_id=$userId&type=user");
    print("status from apii ${res}");
    final resdata = GeneralModel.fromJson(res);
    if (resdata.status == '1') {
    } else {}
  }
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  verifyOtp(String otp) async {
    Map<String, dynamic> data = {
      "user_id": userId,
      "otp": otp,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$check_whatsapp_otp", body: data, context: context);
    print("status from api ${res}");
    final resdata = ProfileModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      pushReplacement(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,));
    } else {
      showSnackbar(context, "Otp couldn't be verified");
    }
  }

  resendOtp() async {
    Map<String, dynamic> data = {
      "user_id": userId,
    };
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$signup_whatsapp_resend", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    if (resdata.status == '1') {
      timerSeconds = 60;
      startTimer();
      showSnackbar(context, resdata.message!);
    } else {
    }
  }
  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.of(context).size.height;
    final width= MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: height*0.05,),
              Center(
                     child:
                  Image.asset("assets/images/CheckMailImage.png",height: 200,)
        
              ),
              SizedBox(height: height*0.01,),
              Center(child: MainHeadingText(text: 'Check your Mail/Mobile',
                fontSize:22 ,)),
              SizedBox(height: height*0.01,),
              Center(child: ParagraphText(text: "Please put the 4 digits sent to you")),
              SizedBox(height: height*0.05,),
              _otp_field(),
              SizedBox(height: height*0.05,),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(timerSeconds==0){
                          resendOtp();
                        }
                      },
                      child: Text(
                        " Resend OTP",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: timerSeconds==0?MyColors
                                .primaryColor:Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.001,
                    ),
                    timerSeconds==0?Container():Text(
                      '00:${timerSeconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],),
        ),
      ),
               bottomNavigationBar:
         Container(height:150,child:       Column(
           children: [TextButton(onPressed: (){
             push(context: context, screen: SignUp());
           }, child: Text("Signup "
               "new User",style: TextStyle(color: MyColors.primaryColor,
               fontWeight: FontWeight.bold,fontSize: 16),)),
             Text("OR",style: TextStyle(fontSize: 16)),
             TextButton(onPressed: (){
               push(context: context, screen: Login());
             }, child: Text("Login already Registered "
                 "User",style: TextStyle(color: MyColors.primaryColor,
                 fontWeight: FontWeight.bold,fontSize: 16),)),
           ],
         ),)
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
        verifyOtp(verificationCode)  ;
      },
    );
  }
}
