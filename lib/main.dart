import 'dart:io';
import 'package:ealaa_userr/import_ealaa_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'View/Utils/notification_services.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/*Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}*/

//FOR HANDLE BACKGROUND NOTIFICATION
@pragma('vm:entry-point')
Future<void> _backgroundNotificationHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NS().showNotification(remoteMessage: message);
  if (!kDebugMode) {
    print("BACKGROUND NOTIFICATION TITLE::::::${message.notification?.title}");
    print("BACKGROUND NOTIFICATION BODY:::::::${message.notification?.body}");
    print("BACKGROUND NOTIFICATION DATA:::::${message.data}");
  }
}

//FOR HANDLE CLICK ON NOTIFICATION
void onSelectNotification(NotificationResponse? notificationResponse) async {
  if (!kDebugMode) {
    print(
        "CLICK ON NOTIFICATION ON SELECT NOTIFICATION:::::::::::::${notificationResponse?.payload}");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(Platform.isAndroid)
    {
      await Firebase.initializeApp();
      NS().initNotification();
      FirebaseMessaging.onBackgroundMessage(_backgroundNotificationHandler);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ealaa User',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.beVietnamPro(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}

