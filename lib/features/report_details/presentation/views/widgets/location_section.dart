import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_images.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/issue_location_container.dart';
import 'package:civix_teams/features/report_details/presentation/views/widgets/location_item.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    required this.address,
    required this.lat,
    required this.long,
  });

  final String address;
  final double lat, long;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          S.of(context).location,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        LocationWidget(text: address),
        const SizedBox(height: 16),
        //IssueMapLocation(location: location)
        IssueLocationContainer(lat: lat, long: long),
      ],
    );
  }
}
