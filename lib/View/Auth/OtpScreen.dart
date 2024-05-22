import 'dart:math';

import 'package:ealaa_userr/Model/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Model/GeneralModel.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/CustomSnackBar.dart';
import '../Utils/GlobalData.dart';
import '../Utils/webService.dart';

class OtpScreen extends StatefulWidget {
  final String userId;
  final String type;
  final String emailOrMob;

  const OtpScreen({super.key, required this.userId, required this.type, required this.emailOrMob});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = '';
  bool loading = false;
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

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  sendOtp() async {
    Map<String, dynamic> data = {
      "email": widget.emailOrMob,
      "type": widget.type
    };
    print("data....$data");
    var res = await Webservices.postData(
        apiUrl: "$baseUrl$forgot_password", body: data, context: context);
    print("status from api ${res}");
    final resdata = GeneralModel.fromJson(res);
    if (resdata.status == '1') {
      timerSeconds = 60;
      startTimer();
      userId = resdata.result;
    } else {}
  }

  expireOtp()async{
    var res = await Webservices.getMap(
        "$baseUrl$otp_expire?user_id=$userId&type=user");
    print("status from apii ${res}");
    final resdata = GeneralModel.fromJson(res);
    if (resdata.status == '1') {
    } else {}
   }
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
          context,
          MaterialPageRoute(
              builder: (context) => CreateNewPassword(
                    userId: resdata.result!.id!,
                    token: resdata.result!.token!,
                  )));
    } else {
      showSnackbar(context, "Otp couldn't be verified");
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child:
                            SvgPicture.asset("assets/images/backButton.svg")),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    "assets/images/CheckMailImage.png",
                    height: 200,
                  )
                ],
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                  child: MainHeadingText(
                text: 'Check your ${widget.type}',
                fontSize: 20,
              )),
              SizedBox(
                height: height * 0.01,
              ),
              Center(
                  child: ParagraphText(
                text: "Please put the 4 digits sent to you",
                fontSize: 15,
              )),
              SizedBox(
                height: height * 0.05,
              ),
              _otp_field(),
              SizedBox(
                height: height * 0.05,
              ),

              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if(timerSeconds==0){
                          sendOtp();
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
              // Center(
              //   child: timerSeconds == 0
              //       ? InkWell(
              //
              //           onTap: () async{
              //
              //             await Future.delayed(Duration(seconds: 1));
              //             timerSeconds = 10;
              //             startTimer();
              //           },
              //           child: Text(
              //             " Resend OTP",
              //             style: GoogleFonts.poppins(
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.bold,
              //                 color: MyColors.primaryColor),
              //           ),
              //         )
              //       :
              //   Container(
              //           width: 30,
              //           height: 30,
              //           child: CustomPaint(
              //             painter: CountdownTimerPainter(
              //               backgroundColor: Colors.grey,
              //               color: MyColors.primaryColor,
              //               strokeWidth: 3,
              //               value: timerSeconds/10, // Current progress
              //             ),
              //             child: Center(
              //               child: Text(
              //                 '$timerSeconds',
              //                 style: TextStyle(
              //                   color: MyColors.primaryColor,
              //                     fontSize: 15, fontWeight: FontWeight.bold),
              //               ),
              //             ),
              //           ),
              //         ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _otp_field() {
    return OtpTextField(
      margin: EdgeInsets.all(11),
      decoration: InputDecoration(),
      fillColor: Color(0xffF7F8F8),
      filled: true,
      cursorColor: Colors.grey,
      borderRadius: BorderRadius.circular(10),
      numberOfFields: 4,
      borderColor: MyColors.primaryColor,
      focusedBorderColor: MyColors.primaryColor,
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

class CountdownTimerPainter extends CustomPainter {
  final Color backgroundColor;
  final Color color;
  final double strokeWidth;
  final double value; // Value between 0 and 1 representing the progress

  CountdownTimerPainter({
    required this.backgroundColor,
    required this.color,
    required this.strokeWidth,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    final Paint bgPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final double sweepAngle = 2 * pi * value;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      -sweepAngle, // Decrease sweep angle for countdown
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CountdownTimerPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
