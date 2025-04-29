import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/core/helper_functions/show_dialog.dart';
import 'package:civix_teams/core/widgets/custom_progress_hud.dart';
import 'package:civix_teams/features/update_status/presentation/cubit/update_issue_status_cubit/update_issue_status_cubit.dart';
import 'package:civix_teams/features/update_status/presentation/views/widgets/update_status_view_body.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateStatusBlocConsumer extends StatelessWidget {
  const UpdateStatusBlocConsumer({super.key, required this.issueId});
  final String issueId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateIssueStatusCubit, UpdateIssueStatusState>(
      listener: (context, state) {
        if (state is UpdateIssueStatusSuccess) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          BuildContext rootContext =
              Navigator.of(context, rootNavigator: true).context;

          Future.microtask(() {
            showCustomDialog(
              rootContext.mounted ? rootContext : context,
              S.of(context.mounted ? rootContext : context).status_updated,
              '',
              Icons.done_all,
            );

            Future.delayed(Duration(seconds: 2), () {
              if (rootContext.mounted) {
                Navigator.of(rootContext).pop();
              }
            });
          });
        }
        if (state is UpdateIssueStatusFailure) {
          buildSnackBar(context, state.errMessage);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is UpdateIssueStatusLoading,
          child: UpdateStatusViewBody(issueId: issueId),
        );
      },
    );
  }
}
