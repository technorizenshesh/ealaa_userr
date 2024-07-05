import 'package:ealaa_userr/View/Auth/SignupOtp.dart';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/ProfileModel.dart';
import '../../main.dart';
import '../Utils/ApiConstants.dart';
import '../Utils/GlobalData.dart';
import '../Utils/bottom_bar.dart';
import '../Utils/webService.dart';

bool isMap=false;
 class Splash extends StatefulWidget {
   const Splash({super.key});

   @override
   State<Splash> createState() => _SplashState();
 }

 class _SplashState extends State<Splash> {

   var savedUid, savedtoken;

   getUserProfileData() async {
     Map<String, dynamic> data = {
       "user_id": savedUid,
       "token": savedtoken
     };
     print("url-------${baseUrl}${get_profile}\n${savedUid}\n${savedtoken}");
     var res = await Webservices.postData(
         apiUrl: "$baseUrl$get_profile", body: data, context: context);
     
     if(res['result']==null){
       final SharedPreferences sharedPreferences =
       await SharedPreferences.getInstance();
       sharedPreferences.clear();
       print("Auth reply.......");
       pushReplacement(context: context, screen: Login());
     }
     else{
       final resdata = ProfileModel.fromJson(res);
       print("resdata is.....$resdata");
       if (resdata.status == '1') {
         profileResult = resdata.result;
         userId = profileResult!.id;
         userToken = profileResult!.token;
        if(resdata.result!.userStep=="1"){
          pushReplacement(context: context, screen: SignupOtp());
        }
        else  if(resdata.result!.userStep=="2"){
          print("Auth reply.......");
          pushReplacement(context: context, screen: Bottom_bar(key:
          MyGlobalKeys.tabBarKey,));
        }
       } else {

       }
     }

   }
   @override
   void initState() {
     super.initState();
     notificationSetup();
     getCurrentAddress();
     getValidationData().whenComplete(() async {
       Timer(
           Duration(seconds: 5), () {
         if(savedUid!=null){
           getUserProfileData();
         }
         else{
           pushReplacement(context: context, screen: Login());
         }
       });
     });
   }

   void notificationSetup(){
     var initializationSettingsAndroid =
     const AndroidInitializationSettings('@mipmap/ic_launcher');
     var initialzationSettingsAndroid =
     const AndroidInitializationSettings('@mipmap/ic_launcher');
     var initializationSettings =
     InitializationSettings(android: initialzationSettingsAndroid);
     flutterLocalNotificationsPlugin.initialize(initializationSettings);

     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
       RemoteNotification? notification = message.notification;
       print("notification::::::::::::::$notification");
       print("notification::::::::::::::${message.data}");
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null) {
         //bool a= notification!['kl'==null];
         flutterLocalNotificationsPlugin.show(
           /*notification.hashCode,
             notification.title,
             notification.body,*/
             message.data["message"]['key'],
             message.data["message"]['status'],
             message.data["message"]['status'],
             NotificationDetails(
               android: AndroidNotificationDetails(
                 channel.id,
                 channel.name,
                 //   channel.description,
                 color: Colors.white,
                 // TODO add a proper drawable resource to android, for now using
                 //      one that already exists in example app.
                 icon: "@mipmap/ic_launcher",
               ),
             ));
       }
     });

     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
       RemoteNotification? notification = message.notification;
       AndroidNotification? android = message.notification?.android;
       if (notification != null && android != null) {
         showDialog(
             context: context,
             builder: (_) {
               return AlertDialog(
                 title: Text(notification.title!),
                 content: SingleChildScrollView(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [Text(notification.body!)],
                   ),
                 ),
               );
             });
       }
     });

     getToken();
   }
   late String token;
   getToken() async {
     token = (await FirebaseMessaging.instance.getToken())!;
     print("My deviceId:-"+token);
   }
   Future getValidationData() async{
     // await getCurrentLocation();
     final SharedPreferences sharedPreferences =
     await SharedPreferences.getInstance();
     savedUid  = sharedPreferences.getString('UserId');
     savedtoken = sharedPreferences.getString('token');
     print("userId is $savedUid");
     print("token is...$savedtoken");
   }
  //  @override
  // void initState() {
  //    getCurrentAddress();
  //   // TODO: implement initState
  //    Timer(Duration(seconds: 3), () {
  //      pushReplacement(context: context, screen: Login());
  //    });
  //   super.initState();
  // }
   @override
   Widget build(BuildContext context) {
     return  Scaffold(
       body: Container(
         height: MediaQuery.of(context).size.height,
         child: Center(
           child: Padding(
             padding: const EdgeInsets.all(16.0),
             child: Image.asset(MyImages.Splash,height:MediaQuery.of(context)
                 .size.height/12),
           ),
         ),
       ),
     );
   }
 }
