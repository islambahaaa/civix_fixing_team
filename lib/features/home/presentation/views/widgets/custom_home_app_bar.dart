import 'package:civix_teams/core/widgets/notification_item.dart';
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
        leading: Image.asset(Assets.imagesProfileImage),
        title: Text(S.of(context).hello),
        subtitle: Text("$fname $lname"),
        trailing: NotificationItem(notificationCount: 5, onTap: () {}),
      ),
    );
  }
}
