import 'package:civix_teams/core/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactTile extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  const ContactTile({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  void _launchDialer(String number) async {
    final Uri url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch dialer");
    }
  }

  void _launchWhatsApp(String number) async {
    final Uri url = Uri.parse("https://wa.me/$number?text=Hello");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.withOpacity(0.5) // Light mode shadow
                    : Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: ListTile(
          tileColor: Colors.transparent,
          leading: Image.asset(Assets.imagesProfileImage),
          title: SelectableText("$firstName $lastName"),
          subtitle: SelectableText(phoneNumber),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                child: SvgPicture.asset(
                  Assets.imagesWhatsappSvgrepoCom,
                  width: 24,
                ),
                onTap: () => _launchWhatsApp(phoneNumber),
              ),
              SizedBox(width: 15),
              IconButton(
                icon: Icon(Icons.call, color: Colors.green),
                onPressed: () => _launchDialer(phoneNumber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
