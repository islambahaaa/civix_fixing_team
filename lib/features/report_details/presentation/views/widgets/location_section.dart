import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_images.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
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
          overflow: TextOverflow.ellipsis,
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
    return Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Ink(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Ink.image(
                    image: AssetImage(Assets.imagesMap),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Text("See Location", style: TextStyles.bold15inter),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
