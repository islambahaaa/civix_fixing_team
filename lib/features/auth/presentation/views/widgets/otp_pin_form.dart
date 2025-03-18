import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

class OtpForm extends StatelessWidget {
  const OtpForm({super.key, this.onCompleted, this.onChanged});
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 68,
      textStyle: TextStyles.medium16inter.copyWith(
        color: AppColors.secondaryColor,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
    );
    return Pinput(
      onChanged: onChanged,
      autofocus: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyDecorationWith(
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
      onCompleted: onCompleted,
    );
  }
}
