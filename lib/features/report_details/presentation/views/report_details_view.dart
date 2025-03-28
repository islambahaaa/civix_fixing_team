import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/description_section.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/image_slider.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/location_section.dart';
import 'package:flutter/material.dart';

class ReportDetailsView extends StatelessWidget {
  const ReportDetailsView({super.key, required this.report});

  static const routeName = '/report_details';
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ReportDetailsBottomBar(),
      appBar: AppBar(title: const Text('Issue Details')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            ImageSlider(images: report.images),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Title
                  Text(
                    report.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// Description
                  const SizedBox(height: 12),

                  /// Status
                  Row(
                    children: [
                      const Icon(Icons.info, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(report.status, style: const TextStyle(fontSize: 16)),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Date & Time
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(report.date, style: const TextStyle(fontSize: 16)),
                      const Spacer(),
                      Text(report.time!, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Divider(thickness: 0.25, color: Colors.grey),
                  DescriptionSection(description: report.description),
                  const SizedBox(height: 12),
                  const Divider(thickness: 0.25, color: Colors.grey),

                  LocationSection(
                    // location: location,
                    address: report.city!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportDetailsBottomBar extends StatelessWidget {
  const ReportDetailsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
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
              backgroundColor: Colors.blue,
              textColor: Colors.white,
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
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class BottomDetailsViewButton extends StatelessWidget {
  const BottomDetailsViewButton({
    super.key,
    required this.text,
    required this.icon,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
  });

  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
