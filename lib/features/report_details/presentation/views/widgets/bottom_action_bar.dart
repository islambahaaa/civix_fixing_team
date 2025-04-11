import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/bottom_action_bar_custom_button.dart';
import 'package:civix_teams/features/update_status/presentation/views/update_status_view.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetailsBottomBar extends StatelessWidget {
  const ReportDetailsBottomBar({
    super.key,
    required this.latitude,
    required this.longitude,
  });
  final double latitude;
  final double longitude;
  @override
  Widget build(BuildContext context) {
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

      padding: const EdgeInsets.all(16.0),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomDetailsViewButton(
              text: S.of(context).directions,
              icon: Icons.directions,
              backgroundColor: Colors.blue.shade200,
              textColor: Colors.black,
              onPressed: () async {
                await openGoogleMapsDirections(latitude, longitude);
              },
            ),
            const SizedBox(width: 8),
            BottomDetailsViewButton(
              text: S.of(context).decline,
              icon: Icons.cancel,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                showDeclineDialog(context, (value) {});
              },
            ),
            const SizedBox(width: 8),
            BottomDetailsViewButton(
              text: S.of(context).update_status,
              icon: Icons.done,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, UpdateStatusView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void showDeclineDialog(BuildContext context, Function(String) onSubmit) {
  TextEditingController reasonController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
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
                onSubmit(reason);
                Navigator.pop(context);
              }
            },
            text: S.of(context).submit,
          ),
        ],
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
