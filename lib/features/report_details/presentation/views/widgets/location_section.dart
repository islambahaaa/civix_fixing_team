import 'package:civix_teams/features/report_details/presentation/views/widgets/location_item.dart';
import 'package:flutter/material.dart';

class LocationSection extends StatelessWidget {
  const LocationSection({
    super.key,
    //required this.location,
    required this.address,
  });
  // final LatLng location;
  final String address;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
          "Location",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        LocationWidget(text: address),
        const SizedBox(height: 16),
        //IssueMapLocation(location: location)
      ],
    );
  }
}
