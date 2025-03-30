import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomDescriptionField extends StatelessWidget {
  const CustomDescriptionField({super.key, this.onSaved});
  final void Function(String?)? onSaved;
  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(width: 1.8, color: AppColors.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 300,
      maxLines: 4,
      textInputAction: TextInputAction.done,
      onSaved: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).required_field;
        }
        return null;
      },
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        // filled: true,
        // fillColor: const Color(0xFFF9FAFA),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
        hintText: S.of(context).description,
        hintStyle: TextStyles.medium16inter.copyWith(
          color: AppColors.lightGrayColor,
        ),
      ),
    );
  }
}
