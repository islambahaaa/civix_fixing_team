import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/core/helper_functions/show_dialog.dart';
import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/core/widgets/custom_progress_hud.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/bottom_action_bar.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/report_details_view_body.dart';
import 'package:civix_teams/features/update_status/domain/repos/update_issue_status_repo.dart';
import 'package:civix_teams/features/update_status/presentation/cubit/update_issue_status_cubit/update_issue_status_cubit.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key, required this.report});

  static const routeName = '/report_details';
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              UpdateIssueStatusCubit(getIt.get<UpdateIssueStatusRepo>()),
      child: Scaffold(
        bottomNavigationBar: ReportDetailsBottomBar(
          fixingStatus: report.fixingStatus,
          issueId: report.id,
          latitude: report.lat,
          longitude: report.long,
        ),
        appBar: AppBar(title: Text(S.of(context).report_details)),
        body: BlocConsumer<UpdateIssueStatusCubit, UpdateIssueStatusState>(
          listener: (context, state) {
            if (state is UpdateIssueStatusSuccess) {
              BuildContext rootContext =
                  Navigator.of(context, rootNavigator: true).context;

              Navigator.of(context).popUntil((route) => route.isFirst);

              Future.microtask(() {
                showCustomDialog(
                  rootContext,
                  S.of(context).status_updated,
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
              child: ReportDetailsViewBody(report: report),
            );
          },
        ),
      ),
    );
  }
}
