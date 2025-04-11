import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_images.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueLocationContainer extends StatelessWidget {
  const IssueLocationContainer({
    super.key,
    required this.lat,
    required this.long,
  });
  final double lat, long;
  Future<void> openGoogleMapsLocation(double latitude, double longitude) async {
    final Uri googleMapsUrl = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
    );

    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () async {
          await openGoogleMapsLocation(lat, long);
        },
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
                    color: Theme.of(context).cardTheme.color,
                    border:
                        Theme.of(context).brightness == Brightness.light
                            ? Border.all(width: 2)
                            : null,
                  ),

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on),
                      const SizedBox(width: 8),
                      Text(
                        S.of(context).see_location,
                        style: TextStyles.bold15inter,
                      ),
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
