import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../firebase_options.dart';


//typedef BackgroundMessageHandler = Future<void> Function(RemoteMessage message);
FutureOr<void> firebaseMessagingBackgroundHandler(RemoteMessage remoteMessage) async {
  //BACKGROUND Notifications - iOS & Android
  if(Platform.isAndroid){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }else{
    await Firebase.initializeApp();
  }
  print('Message: ${remoteMessage.messageId}');
}

//GLOBAL
late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin localNotificationsPlugin;

mixin FbNotifications {
  /// CALLED IN main function between ensureInitialized <-> runApp(widget);
  static FutureOr<void> initNotifications() async {
    //Connect the previous created function with onBackgroundMessage to enable
    //receiving notification when app in Background.
    // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    //Channel
    if (Platform.isAndroid) {
    // if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'Expense_channel',
        'flutter android Notifications Channel',
        description: 'This channel will receive notifications specific to flutter-app',
        importance: Importance.high,
        enableLights: true,
        enableVibration: true,
        ledColor: Colors.orange,
        showBadge: true,
        playSound: true,
      );
      //Flutter Local Notifications Plugin (FOREGROUND) - ANDROID CHANNEL
      localNotificationsPlugin = FlutterLocalNotificationsPlugin();
      await localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }



    //iOS Notification Setup (FOREGROUND)
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  //iOS Notification Permission
  FutureOr<void> requestNotificationPermissions() async {
    if(Platform.isIOS){
      NotificationSettings notificationSettings =
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        carPlay: false,
        announcement: false,
        provisional: false,
        criticalAlert: false,
      );
      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
        print('GRANT PERMISSION');
      } else if (notificationSettings.authorizationStatus == AuthorizationStatus.denied) {
        print('Permission Denied');
      }
    }

  }

  //ANDROID
  void initializeForegroundNotificationForAndroid() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message Received: ${message.messageId}');
      RemoteNotification? notification = message.notification;
      AndroidNotification? androidNotification = notification?.android;
      if (notification != null && androidNotification != null) {
        localNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  //GENERAL (Android & iOS)
  void manageNotificationAction() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _controlNotificationNavigation(message.data);
    });
  }

  void _controlNotificationNavigation(Map<String, dynamic> data) {
    print('Data: $data');
    if (data['page'] != null) {
      switch (data['page']) {
        case 'products':
          var productId = data['id'];
          print('Product Id: $productId');
          break;

        case 'settings':
          print('Navigate to settings');
          break;

        case 'profile':
          print('Navigate to Profile');
          break;
      }
    }
  }
}
