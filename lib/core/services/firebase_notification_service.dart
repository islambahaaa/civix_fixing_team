import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Call this in main() after Firebase.initializeApp()
  static Future<void> initialize() async {
    await _setupFlutterNotifications();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _handleInitialMessage(initialMessage);
    }
  }

  static Future<void> _handleInitialMessage(RemoteMessage message) async {
    // Handle navigation or logic without Hive
    debugPrint('📦 Initial message: ${message.messageId}');
  }

  /// Request permissions (iOS & Android 13+)
  Future<void> requestPermission() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('🔔 Notification permission granted');
    } else {
      debugPrint('🚫 Notification permission denied');
    }
  }

  Future<String?> getToken() async {
    String? token = await _messaging.getToken();
    log('FCMToken: $token');
    return token;
  }

  /// Handle foreground messages
  void setupOnMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      debugPrint('📩 Received a foreground message: ${message.data}');
      if (message.notification != null) {
        await _showLocalNotification(message);
      }
    });
  }

  /// Display notification using flutter_local_notifications
  static Future<void> _showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _localNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  /// Background message handler (must be top-level or static)
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    debugPrint('📦 Handling background message: ${message.messageId}');
  }

  static Future<void> _setupFlutterNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }
}
