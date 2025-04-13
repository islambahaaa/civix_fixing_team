import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/features/update_status/domain/repos/update_issue_status_repo.dart';
import 'package:civix_teams/features/update_status/presentation/cubit/update_issue_status_cubit/update_issue_status_cubit.dart';
import 'package:civix_teams/features/update_status/presentation/views/widgets/update_status_bloc_consumer.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStatusView extends StatelessWidget {
  const UpdateStatusView({super.key, required this.issueId});
  static const routeName = 'update-status';
  final String issueId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              UpdateIssueStatusCubit(getIt.get<UpdateIssueStatusRepo>()),
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).update_status)),
        body: UpdateStatusBlocConsumer(issueId: issueId),
      ),
    );
  }
}
