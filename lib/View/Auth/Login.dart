import 'package:ealaa_userr/Model/ProfileModel.dart';
import 'package:ealaa_userr/View/Auth/SignupOtp.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/bottom_bar.dart';
import '../Utils/webService.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool loader = false;
  bool showPassword = true;
  loginUser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {"email": email.text, "password": pass.text,"register_id": await FirebaseMessaging.instance.getToken()};
    setState(() {
      loader = true;
    });
    print("data.....$data");
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$login", body: data, context: context);
    setState(() {
      loader = false;
    });
    print("status from api ${res}");
    final resdata = ProfileModel.fromJson(res);
    print("status.....${resdata.status}");
    if (resdata.status == '1') {
      profileResult = resdata.result;
      prefs.setString('UserId', profileResult!.id!);
      prefs.setString('token', profileResult!.token??"");
      userId = profileResult!.id;
      userToken = profileResult!.token;

   if(profileResult!.userStep=="1"){
       push(context: context, screen: SignupOtp());
   }
   else if(profileResult!.userStep=="2"){
     push(context: context, screen: Bottom_bar(key: MyGlobalKeys.tabBarKey,));
   }
    } else {
      showSnackbar(context, resdata.message??"");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account yet?",
            style:
            GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) {
              //       return SelectProfile();
              //     }));
              push(context: context, screen: SignUp());
            },
            child: Text(
              " Sign up",
              style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryColor),
            ),
          ),
        ],
      ),
      body:AbsorbPointer(absorbing: loader,child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: height*0.1,),
              Center(
                child: Image.asset("assets/images/LoginImage3x.png",height: 200,),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: MainHeadingText(
                  text: "Login",
                  textAlign: TextAlign.center,
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff515151),
                ),
              ),
              SizedBox(height: height*0.03,),
              CustomTextFieldwithoutshadow(
                controller: email,
                hintText: 'Email/Phone',
                labelText: 'Email/Phone',
                prefixIcon: MyImages.email,
              ),
              sizeBox_mq(context, width: width, height: 0.02),
              CustomTextFieldwithoutshadow(
                controller: pass,
                obscureText: showPassword,
                hintText: 'Password',
                labelText: 'Password',
                prefixIcon: MyImages.lock,
                suffixIcon: showPassword == true
                    ? "assets/images/Hide-Password@2x.png"
                    : "assets/images/ShowPass.png",
                onTapsuffix: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              ),
              sizeBox_mq(context, width: width, height: 0.02),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return reset_pass();
                        }));
                  },
                  child: Text(
                    "Forgot your password?",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: MyColors.grey2color,
                      decoration: TextDecoration.underline,
                    ),
                  )),
              sizeBox_mq(context, width: width, height: 0.05),
              RoundButton(
                loading: loader,
                title: 'Login',
                onTap: () {
                  if (email.text == "") {
                    showSnackbar(context, "Enter email");
                  }
                  else if (pass.text == "") {
                    showSnackbar(context, "Enter password");
                  }
                  else {
                    loginUser();
                  }
                },
                fontsize: 20,
                fontweight: FontWeight.w700,
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Divider(), Text("Or")],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      MyImages.google,
                      height: 55,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Image.asset(
                      MyImages.iphone,
                      height: 55,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),)

    );
  }
}
