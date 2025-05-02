import 'package:civix_teams/core/helper_functions/get_status_color.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/features/home/presentation/views/widgets/custom_report_image.dart';
import 'package:civix_teams/features/report_details/presentation/views/report_details_view.dart';
import 'package:flutter/material.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({
    super.key,
    required this.events,
    required this.normalizedSelectedDay,
  });

  final Map<DateTime, List<ReportModel>> events;
  final DateTime normalizedSelectedDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children:
            (events[normalizedSelectedDay] ?? []).map((event) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  onTap:
                      () => Navigator.of(context).pushNamed(
                        ReportDetailsView.routeName,
                        arguments: event,
                      ),
                  leading: CustomReportImage(
                    borderRadius: BorderRadius.circular(5),
                    imageUrl: event.images[0],
                  ),

                  title: Text(
                    event.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  subtitle: Text(
                    event.description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  trailing: Text(
                    event.fixingStatus,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(
                        event.fixingStatus.toLowerCase(),
                        context,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }
}
