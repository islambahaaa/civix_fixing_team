import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({super.key});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      activeTrackColor: AppColors.primaryColor,
      activeColor: Colors.white,
      splashRadius: 15,
      value: switchValue,
      onChanged: (value) {
        setState(() {
          switchValue = value;
        });
      },
    );
  }
}
