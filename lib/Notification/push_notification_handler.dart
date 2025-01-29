import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

class PushNotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Future<void> initialize(BuildContext context) async {

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings androidInitializationSettings =

    AndroidInitializationSettings('@drawable/ic_notification');
    const InitializationSettings initializationSettings =

    InitializationSettings(android: androidInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        _handleMessageNavigation(context);
      },

    );


    // Request notification permissions for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted notification permissions.');
    } else {
      print('User declined or has not accepted notification permissions.');
    }

    // Get the device token
    String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      print('Device Token: $token');
      // You can send the token to your server here
    } else {
      print('Failed to get FCM Token.');
    }

    // Listen for incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message: ${message.notification?.body}');
      _showNotification(message);
    });

    // Listen for when the app is opened from a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked! ${message.notification?.title}');
      _handleMessageNavigation(context);
    });
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by tapping notification');
        _handleMessageNavigation(context);
      }
    });


  }

  Future<void> _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'Recipe Notification',
      'Recipe App Notification',
      channelDescription: 'New Followers',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }

  void _handleMessageNavigation(BuildContext context) {
    navigatorKey.currentState?.pushNamed('/notifications');
  }

}
