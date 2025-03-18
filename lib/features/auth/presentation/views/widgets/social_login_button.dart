import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.image,
  });
  final String title;
  final VoidCallback onPressed;
  final String image;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFFDCDEDE)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: ListTile(
          visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
          ),
          leading: SvgPicture.asset(image),
          title: Text(title, textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
