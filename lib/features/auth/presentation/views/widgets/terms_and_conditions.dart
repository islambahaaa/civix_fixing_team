import 'package:civix_app/features/auth/presentation/views/widgets/custom_check_box.dart';
import 'package:civix_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:civix_app/core/utils/app_colors.dart';
import 'package:civix_app/core/utils/app_text_styles.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChange});
  final ValueChanged<bool> onChange;
  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomCheckBox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChange(value);
            setState(() {});
          },
          isChecked: isTermsAccepted,
        ),
        // const TestCheckBox(),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              isTermsAccepted = !isTermsAccepted;
              widget.onChange(isTermsAccepted);
              setState(() {});
            },
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: S.of(context).agree_terms,
                    style: TextStyles.regular14inter
                        .copyWith(color: AppColors.lightGrayColor),
                  ),
                  TextSpan(
                    text: S.of(context).terms,
                    style: TextStyles.regular14inter
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: S.of(context).and,
                    style: TextStyles.regular14inter
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                  const TextSpan(
                    text: ' ',
                  ),
                  TextSpan(
                    text: S.of(context).conditions,
                    style: TextStyles.regular14inter
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
