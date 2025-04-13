import 'dart:developer';

import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    super.key,
    required this.userName,
    required this.userPhone,
  });
  final String userName;
  final String userPhone;

  void _launchDialer(String number) async {
    if (number == 'No Phone') return;
    final Uri url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch dialer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        SizedBox(height: 8),
        Text(
          S.of(context).user_info,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            const Icon(Icons.person, color: AppColors.primaryColor),
            const SizedBox(width: 16),
            Text(userName, style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.phone, color: AppColors.primaryColor),
            const SizedBox(width: 16),
            Text(userPhone, style: const TextStyle(fontSize: 16)),
            Spacer(),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  AppColors.primaryColor,
                ),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              onPressed: () => _launchDialer(userPhone),
              child: Text(S.of(context).call),
            ),
          ],
        ),
      ],
    );
  }
}
