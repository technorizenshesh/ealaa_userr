import 'dart:convert';
import 'dart:math';

import 'package:ealaa_userr/View/Utils/GlobalData.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../main.dart';


/*
Base Url         :-https://fcm.googleapis.com/fcm/send
Method Type      :- POST
Row Data For Api :-
{
  "to": "userToken",
  "data": {
    "title": "Your Notification Title",
    "body": "Your Notification Body"
  }
}
Headers          :-
Authorization:key=Server Key,
Content-Type:application/json

 */
class NS {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings iosInitializationSettings =
      const DarwinInitializationSettings(
    defaultPresentAlert: true,
    defaultPresentBadge: true,
    defaultPresentSound: true,
  );

  final DarwinNotificationDetails iosNotificationDetails =
      const DarwinNotificationDetails(
    subtitle: "This channel is responsible for all the local notifications",
    sound: 'Notification',
  );

  Future<bool> requestNotificationPermission() async {
    return await getPermission(permission: Permission.notification);
  }

  ///For Give Permission Add:- flutter pub add permission_handler
  static Future<bool> getPermission(
      {Permission permission = Permission.storage}) async {
    PermissionStatus status = await permission.request();
    if (status == PermissionStatus.granted) {
      return true;
    } else if (status == PermissionStatus.denied) {
      return false;
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      status = await permission.status;
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<void> initNotification() async {
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification,
        onDidReceiveBackgroundNotificationResponse: onSelectNotification);
    await initFirebaseNotification();
  }

  Future<void> initFirebaseNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((message) {
      if (!kDebugMode) {
        print("NOTIFICATION TITLE:::::::${message.notification?.title}");
        print("NOTIFICATION BODY::::::::${message.notification?.body}");
        print("NOTIFICATION DATA::::::::${message.data}");
      }
      showNotification(remoteMessage: message);
    });

    /*   FirebaseMessaging.onMessageOpenedApp.listen((notificationResponse) {
      if (!kDebugMode) {
        print("CLICK ON NOTIFICATION ON MESSAGE OPEN:::::::::::::${notificationResponse.data}");
      }
    });
*/

    /* FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (!kDebugMode) {
        print("CLICK ON NOTIFICATION GET INITIAL MESSAGE:::::");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.notification?.title}");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.notification?.body}");
        print("CLICK ON NOTIFICATION TITLE :::::::${message?.data}");
      }
    });*/
  }

  ///For Get Six Digit Random Number
  static String getRandomNumber() {
    var random = Random();
    int min = 100000;
    int max = 999999;
    var number = min + random.nextInt(max - min);
    return number.toString();
  }

  Future<void> showNotification({
    required RemoteMessage remoteMessage,
    String? payload,
  }) async {
    await initNotification();
    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      getRandomNumber(),
      'Test Channel',
      channelDescription:
          "This channel is responsible for all the local notifications",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );
    print('remoteMessage:::::::::${remoteMessage}');
    print('remoteMessage:::::::::${remoteMessage.data}');
    Message aaa= Message.fromJson(jsonDecode(remoteMessage.data['message']));
    print('remoteMessage              ${aaa.notifi2}');
    print('remoteMessage              ${aaa.key}');

    if(aaa.status=="Accept"){
      pendingNotification=1;
    }
    else if(aaa.status=="Start"||aaa.status=="Complete"){
       ongoingNotification=1;
    }
    else if(aaa.status=="Cancel"){
          cancelNotification=1;
    }

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      // remoteMessage.data["title"],
      // remoteMessage.data['body'],
      aaa.key,
      aaa.notifi2,
      notificationDetails,
      payload: payload,
    );
  }
}


class Noti {
  Message? message;

  Noti({this.message});

  Noti.fromJson(Map<String, dynamic> json) {
    message =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? result;
  String? notifi2;
  String? notifi1;
  int? requestId;
  String? key;
  String? status;

  Message(
      {this.result,
        this.notifi2,
        this.notifi1,
        this.requestId,
        this.key,
        this.status});

  Message.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    notifi2 = json['notifi_2'];
    notifi1 = json['notifi_1'];
    requestId = json['request_id'];
    key = json['key'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['notifi_2'] = this.notifi2;
    data['notifi_1'] = this.notifi1;
    data['request_id'] = this.requestId;
    data['key'] = this.key;
    data['status'] = this.status;
    return data;
  }
}

