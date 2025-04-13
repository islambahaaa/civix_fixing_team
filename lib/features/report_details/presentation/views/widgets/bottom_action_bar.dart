import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/bottom_action_bar_custom_button.dart';
import 'package:civix_teams/features/update_status/presentation/cubit/update_issue_status_cubit/update_issue_status_cubit.dart';
import 'package:civix_teams/features/update_status/presentation/views/update_status_view.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailsBottomBar extends StatelessWidget {
  const ReportDetailsBottomBar({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.issueId,
    required this.fixingStatus,
  });
  final String issueId;
  final String fixingStatus;
  final double latitude;
  final double longitude;
  @override
  Widget build(BuildContext context) {
    return ReportDetailsBottomBarWidget(
      fixingStatus: fixingStatus,
      issueId: issueId,
      latitude: latitude,
      longitude: longitude,
    );
  }
}

class ReportDetailsBottomBarWidget extends StatelessWidget {
  const ReportDetailsBottomBarWidget({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.issueId,
    required this.fixingStatus,
  });
  final String issueId;
  final String fixingStatus;
  final double latitude;
  final double longitude;

  @override
  Widget build(BuildContext context) {
    final showDeclineAndUpdate =
        fixingStatus != 'Declined' && fixingStatus != 'Fixed';
    final showOnlyDirections = !showDeclineAndUpdate;
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width:
                  (showOnlyDirections)
                      ? MediaQuery.of(context).size.width -
                          32 // give some margin
                      : null,
              child: BottomDetailsViewButton(
                text: S.of(context).directions,
                icon: Icons.directions,
                backgroundColor: Colors.blue.shade200,
                textColor: Colors.black,
                onPressed: () async {
                  await openGoogleMapsDirections(latitude, longitude);
                },
              ),
            ),

            if (!showOnlyDirections) ...[
              const SizedBox(width: 8),
              if (showDeclineAndUpdate)
                BottomDetailsViewButton(
                  text: S.of(context).decline,
                  icon: Icons.cancel,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  onPressed: () {
                    showDeclineDialog(context, issueId);
                  },
                ),
              if (showDeclineAndUpdate) ...[
                const SizedBox(width: 8),
                BottomDetailsViewButton(
                  text: S.of(context).update_status,
                  icon: Icons.done,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UpdateStatusView.routeName,
                      arguments: issueId,
                    );
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

void showDeclineDialog(BuildContext parentContext, String issueId) {
  TextEditingController reasonController = TextEditingController();

  showDialog(
    context: parentContext,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: BlocProvider.of<UpdateIssueStatusCubit>(parentContext),
        child: AlertDialog(
          title: Center(
            child: Text(
              S.of(context).decline_assignment,
              style: TextStyles.bold28insturment,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text("Why do you want to decline this assignment?"),
              SizedBox(height: 10),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: S.of(context).enter_reason,
                ),
              ),
            ],
          ),
          actions: [
            CustomButton(
              onPressed: () {
                String reason = reasonController.text.trim();
                if (reason.isNotEmpty) {
                  BlocProvider.of<UpdateIssueStatusCubit>(
                    parentContext,
                  ).updateIssueStatus(issueId, 'Declined', reason);
                  Navigator.pop(context);
                }
              },
              text: S.of(context).submit,
            ),
          ],
        ),
      );
    },
  );
}

Future<void> openGoogleMapsDirections(double latitude, double longitude) async {
  final Uri googleMapsUrl = Uri.parse(
    "https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude",
  );

  if (await canLaunchUrl(googleMapsUrl)) {
    await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $googleMapsUrl';
  }
}
