import 'package:civix_teams/core/widgets/notification_item.dart';
import 'package:civix_teams/features/notifications/presentation/views/notification_view.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_images.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
    required this.fname,
    required this.lname,
    this.onTap,
  });
  final String fname;
  final String lname;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: Colors.green[300],
          radius: 30,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(Assets.imagesProfileImage),
          ),
        ),
        title: Text(S.of(context).hello),
        subtitle: Text("$fname $lname"),
        trailing: NotificationItem(
          notificationCount: 9,
          onTap: () {
            Navigator.pushNamed(context, NotificationsView.routeName);
          },
        ),
      ),
    );
  }
}
