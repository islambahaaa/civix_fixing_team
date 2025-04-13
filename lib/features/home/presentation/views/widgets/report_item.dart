import 'package:civix_teams/core/helper_functions/get_status_color.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/features/home/presentation/views/widgets/custom_report_image.dart';
import 'package:civix_teams/features/report_details/presentation/views/report_details_view.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({super.key, required this.report});
  final ReportModel report;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ReportDetailsView.routeName,
          arguments: report,
        );
      },
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              CustomReportImage(
                borderRadius: BorderRadius.circular(12),
                imageUrl: report.images[0],
              ),

              // Image.asset(
              //   Assets.imagesLogo,
              //   fit: BoxFit.cover,
              //   width: 100,
              //   height: 50,
              // ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: getStatusColor(report.status, context),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            report.status,
                            style: TextStyles.bold15inter.copyWith(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          report.date,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            color: AppColors.lightGrayColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      report.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.semibold16inter,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      report.city!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
