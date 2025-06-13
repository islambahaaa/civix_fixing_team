import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/features/notifications/domain/repos/notification_repo.dart';
import 'package:civix_teams/features/notifications/presentation/cubits/cubit/notification_cubit.dart';
import 'package:civix_teams/features/notifications/presentation/views/widgets/noficiation_list.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatelessWidget {
  static const routeName = '/notifications';
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NotificationCubit(getIt.get<NotificationRepo>())
                ..getNotifications(),
      child: Scaffold(body: SafeArea(child: NotificationList())),
    );
  }
}
