import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:civix_teams/constants.dart';
import 'package:civix_teams/features/notifications/data/models/notification_model.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(NotificationModelAdapter());
  }

  final box = await Hive.openBox<NotificationModel>(kNotificationsBox);
  log(message.data['IssueId']);

  final newNotification = NotificationModel(
    id: message.messageId ?? '',
    title:
        message.data['title'] ??
        message.notification?.title ??
        'No title' ??
        'No title',
    body: message.data['body'] ?? message.notification?.body ?? 'No body',
    image: message.data['image'] ?? message.notification?.android?.imageUrl,
    time: DateTime.now(),
    isRead: false,
  );

  await box.add(newNotification);
}
