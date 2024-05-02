import 'package:country_code_picker/country_code_picker.dart';
import 'package:ealaa_userr/Model/ProfileModel.dart';
import 'package:ealaa_userr/Model/SignupModel.dart';
import 'package:ealaa_userr/View/Auth/SignupOtp.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/bottom_bar.dart';
import '../Utils/webService.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conpass = TextEditingController();
  bool showPassword = true;
  bool showConPassword = true;

  bool loader=false;

  String selectedCountry = "+968";


  signupUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      "email": email.text,
      "mobile": mob.text,
      "password":pass.text,
      "country_code": selectedCountry,
    };
    setState(() {
      loader = true;
    });
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$signup", body: data, context: context);
    setState(() {
      loader = false;
    });
    print("status from api ${res}");
    final resdata = ProfileModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      showSnackbar(context, "User registered successfully");
      profileResult = resdata.result;
      prefs.setString('UserId', profileResult!.id!);
      prefs.setString('token', profileResult!.token!);
      userId = profileResult!.id;
      userToken = profileResult!.token;
      pushReplacement(context: context, screen: SignupOtp());

    } else {
      showSnackbar(context, resdata.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 100,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: EdgeInsets.all(10),
              child: SvgPicture.asset("assets/images/backButton.svg")),
        ),
        title: Image.asset(
          MyImages.Logo,
          height: height * 0.04,
          width: width / 3,
        ),
        centerTitle: true,
      ),
      bottomNavigationBar:   Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account?",
            style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return Login();
                  }));
            },
            child: Text(
              "Login",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryColor),
            ),
          ),
        ],
      ),
      body:
 AbsorbPointer(absorbing: loader,child:
 Padding(
   padding: EdgeInsets.symmetric(horizontal: 16),
   child: SingleChildScrollView(
     child: Container(
       height: height * 0.8,
       child: Column(
           children: [
             sizeBox_mq(context, width: width, height: 0.02) ,
             Center(child: MainHeadingText(
               text: "Sign Up",
               textAlign: TextAlign.center,
               fontSize: 22,
               fontWeight: FontWeight.w500,
               color: Color(0xff515151),
             ),),
             sizeBox_mq(context, width: width, height: 0.1) ,
             CustomTextFieldwithoutshadow(controller: email, hintText: 'Email',
               labelText: 'Email',prefixIcon: MyImages.email,),
             sizeBox_mq(context, width: width, height: 0.02) ,
               Row(
                 mainAxisAlignment:MainAxisAlignment.spaceBetween,children: [
              Container(decoration:BoxDecoration(color: Color(0xffF7F8F8),
                  borderRadius: BorderRadius.circular(10)),
                child:
                CountryCodePicker(
                  onChanged: (CountryCode? countryCode) {
                    setState(() {
                      selectedCountry = countryCode?.dialCode??"";
                      print("selected country code is...${selectedCountry}");
                    });
                  },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'OM',
                padding: EdgeInsets.all(0),
                // optional. Shows only country name and flag
                showCountryOnly: false,
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: false,
              ),
              ),
                 SizedBox(width: 20,) ,
             Expanded(child:     CustomTextFieldwithoutshadow(controller: mob,
               hintText: ''
                   'Mobile Number',
               labelText: 'Mobile Number',prefixIcon: MyImages.mobile,
               keyBoardType: TextInputType.number,),)
               ],),
             sizeBox_mq(context, width: width, height: 0.02) ,

             CustomTextFieldwithoutshadow(controller:
             pass, obscureText:showPassword,hintText: 'Password',
               labelText: 'Password',prefixIcon: MyImages.lock,
               suffixIcon: showPassword == true
                   ? "assets/images/Hide-Password@2x.png"
                   : "assets/images/ShowPass.png",
               onTapsuffix: () {
                 setState(() {
                   showPassword = !showPassword;
                 });
               },),

             sizeBox_mq(context, width: width, height: 0.02) ,

             CustomTextFieldwithoutshadow(controller:
             conpass, obscureText:showConPassword,hintText: 'Confirm '
                 'Password',
               labelText: 'Confirm Password',prefixIcon: MyImages.lock,
               suffixIcon: showConPassword == true
                   ? "assets/images/Hide-Password@2x.png"
                   : "assets/images/ShowPass.png",      onTapsuffix: () {
                 setState(() {
                   showConPassword = !showConPassword;
                 });
               },),
             sizeBox_mq(context, width: width, height: 0.15) ,
             RoundButton(loading:loader,title: 'Sign up', onTap: () {
               if (email.text == "") {
                 showSnackbar(context, "Enter email");
               } else if (mob.text == "") {
                 showSnackbar(context, "Enter mobile number");
               }
               else if (pass.text == "") {
                 showSnackbar(context, "Enter password");
               }
               else if (conpass.text == "") {
                 showSnackbar(context, "Confirm password");
               }
               else if (pass.text != conpass.text) {
                 showSnackbar(
                     context, "Password and confirm password should be same.");
               } else {
                 signupUser();
               }
             },  fontsize: 20,
               fontweight: FontWeight.w700,),
           ]
       ),
     ),
   ),
 ),
 )
    );
  }
}
