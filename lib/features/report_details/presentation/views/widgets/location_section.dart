import 'package:civix_teams/core/utils/app_images.dart';
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
        IssueLocationContainer(),
      ],
    );
  }
}

class IssueLocationContainer extends StatelessWidget {
  const IssueLocationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.asset(Assets.imagesMap, fit: BoxFit.cover),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              child: Text("See Location"),
            ),
          ],
        ),
      ),
    );
  }
}
