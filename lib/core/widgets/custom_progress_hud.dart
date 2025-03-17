import 'package:civix_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomProgressHud extends StatelessWidget {
  const CustomProgressHud(
      {super.key, required this.child, required this.isLoading});
  final Widget child;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
        blur: 1,
        color: Colors.transparent,
        inAsyncCall: isLoading,
        child: child);
  }
}
