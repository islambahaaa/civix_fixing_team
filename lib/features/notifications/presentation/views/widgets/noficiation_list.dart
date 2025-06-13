import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/features/notifications/data/models/notification_model.dart';
import 'package:civix_teams/features/notifications/presentation/views/widgets/notification_tile.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<NotificationModel> notifications = [];
  late Box<NotificationModel> notificationBox;

  @override
  void initState() {
    super.initState();
    notificationBox = Hive.box<NotificationModel>(kNotificationsBox);
    _loadNotifications();

    notificationBox.listenable().addListener(() {
      _loadNotifications();
    });
  }

  void _loadNotifications() {
    setState(() {
      notifications = notificationBox.values.toList().reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_outlined),
              ),

              Text(
                S.of(context).notifications,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              TextButton(
                onPressed: _markAllAsRead,
                child: Text(S.of(context).mark_all_as_read),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(top: 8),
            itemCount: notifications.length,
            separatorBuilder:
                (context, index) => const Divider(height: 0.2, thickness: 0.15),
            itemBuilder: (context, index) {
              return NotificationTile(
                notification: notifications[index],
                onDismiss: (id) => _dismissNotification(id),
                onTap: (id) => _handleNotificationTap(id),
              );
            },
          ),
        ),
      ],
    );
  }

  void _markAllAsRead() async {
    for (var i = 0; i < notificationBox.length; i++) {
      final n = notificationBox.getAt(i);
      if (n != null && !n.isRead) {
        n.isRead = true;
        await n.save();
      }
    }
    _loadNotifications();
  }

  void _dismissNotification(String id) async {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      await notificationBox.deleteAt(notificationBox.length - 1 - index);
    }
    buildSnackBar(context, S.of(context).notification_dismissed);
    _loadNotifications();
  }

  void _handleNotificationTap(String id) async {
    final index = notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      final actualIndex = notificationBox.length - 1 - index;
      final notification = notificationBox.getAt(actualIndex);
      if (notification != null && !notification.isRead) {
        notification.isRead = true;
        await notification.save();
      }
    }
    _loadNotifications();
  }
}
