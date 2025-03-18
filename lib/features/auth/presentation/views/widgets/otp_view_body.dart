import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_teams/features/auth/presentation/views/widgets/otp_pin_form.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpViewBody extends StatefulWidget {
  const OtpViewBody({
    super.key,
    required this.email,
    required this.countdown,
    required this.resendCode,
  });
  final String email;
  final int countdown;
  final VoidCallback resendCode;

  @override
  State<OtpViewBody> createState() => _OtpViewBodyState();
}

String? otp;

class _OtpViewBodyState extends State<OtpViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 64),
              Text(
                S.of(context).verify,
                style: TextStyles.semibold28inter.copyWith(
                  color: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                S.of(context).enter_code,
                style: TextStyles.medium16inter.copyWith(
                  color: AppColors.lightGrayColor,
                ),
              ),
              const SizedBox(height: 36),
              OtpForm(
                onChanged: (value) {
                  if (value.length < 6) {
                    otp = value;
                  }
                },
                onCompleted: (value) {
                  otp = value;
                },
              ),
              const SizedBox(height: 64),
              Text(
                S.of(context).no_code,
                style: TextStyles.medium16inter.copyWith(
                  color: AppColors.lightGrayColor,
                ),
              ),
              GestureDetector(
                onTap: widget.countdown == 0 ? widget.resendCode : null,
                child: Text(
                  widget.countdown > 0
                      ? '${S.of(context).resend_code}${widget.countdown} ${S.of(context).seconds_left}'
                      : S.of(context).resend,
                  style: TextStyles.bold15inter,
                ),
              ),
              const SizedBox(height: 46),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9),
                child: CustomButton(
                  onPressed: () {
                    if (otp == null || otp!.length < 6) {
                      buildSnackBar(context, S.of(context).otp_digits);
                      return;
                    }

                    BlocProvider.of<OtpCubit>(
                      context,
                    ).checkOtp(widget.email, otp!);
                  },
                  text: S.of(context).verify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
