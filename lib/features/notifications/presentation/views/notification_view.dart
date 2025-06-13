import 'package:civix_teams/features/notifications/presentation/views/widgets/noficiation_list.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationsView extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: NotificationList()));
  }
}
