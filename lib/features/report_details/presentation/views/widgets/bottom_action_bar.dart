import 'package:civix_teams/features/report_details/presentation/views/widgets/bottom_action_bar_custom_button.dart';
import 'package:civix_teams/features/update_status/presentation/views/update_status_view.dart';
import 'package:flutter/material.dart';

class ReportDetailsBottomBar extends StatelessWidget {
  const ReportDetailsBottomBar({super.key});

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
              text: 'Directions',
              icon: Icons.directions,
              backgroundColor: Colors.blue.shade200,
              textColor: Colors.black,
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            BottomDetailsViewButton(
              text: 'Decline',
              icon: Icons.cancel,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {},
            ),
            const SizedBox(width: 8),
            BottomDetailsViewButton(
              text: 'Update Status',
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
