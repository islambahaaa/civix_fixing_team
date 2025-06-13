import 'package:civix_teams/core/helper_functions/get_status_color.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart'
    show ReportModel;
import 'package:civix_teams/features/report_details/presentation/views/widgets/description_section.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/image_slider.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/location_section.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/user_info_section.dart';
import 'package:flutter/material.dart';

class ReportDetailsViewBody extends StatelessWidget {
  const ReportDetailsViewBody({super.key, required this.report});

  final ReportModel report;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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

                const SizedBox(height: 16),

                /// Status
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: getStatusColor(report.fixingStatus, context),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      report.fixingStatus,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                /// Category
                Row(
                  children: [
                    const Icon(
                      Icons.category_rounded,
                      color: Colors.deepPurple,
                    ),
                    const SizedBox(width: 8),
                    Text(report.category, style: const TextStyle(fontSize: 16)),
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

                /// Description
                const Divider(thickness: 0.25, color: Colors.grey),
                DescriptionSection(description: report.description),
                const SizedBox(height: 12),

                /// Location
                const Divider(thickness: 0.25, color: Colors.grey),

                LocationSection(
                  lat: report.lat,
                  long: report.long,
                  address: report.city ?? '',
                ),
                const Divider(thickness: 0.25, color: Colors.grey),
                UserInfoSection(
                  userName: report.userName ?? 'No Name',
                  userPhone: report.userPhone ?? 'No Phone',
                ),

                /// Buttons
              ],
            ),
          ),
        ],
      ),
    );
  }
}
