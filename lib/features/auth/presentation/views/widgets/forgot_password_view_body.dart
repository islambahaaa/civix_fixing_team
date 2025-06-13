import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/features/auth/presentation/cubits/otp_cubit/otp_cubit.dart';
import 'package:civix_teams/features/auth/presentation/views/otp_view.dart';
import 'package:civix_teams/features/auth/presentation/views/widgets/category_drop_down_menu.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:civix_teams/core/utils/app_images.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../core/widgets/custom_text_form_field.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

void launchForgotPasswordEmail({
  required String fullName,
  required String usernameEmail,
  required String department,
  String? phoneNumber,
}) async {
  final String email = 'support@civix.space';

  final String subject = 'Password Reset Request';
  final String body = '''
Dear Civix Support Team,

I hope you are doing well.

I am unable to access my account because I have forgotten my password.
Could you please assist me with resetting it?

Here are my details:
- Full Name: $fullName
- Email: $usernameEmail
- Department / Role: $department${phoneNumber != null ? '\n- Phone Number: $phoneNumber' : ''}

Please let me know if you need any more information.
Thank you for your support!

Best regards,
$fullName
''';

  final Uri emailUri = Uri.parse(
    'mailto:$email?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  } else {
    print('Could not launch email client');
  }
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, fullname, phoneNumber;
  String? category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
        reverse: true,
        child: Form(
          key: formKey,
          autovalidateMode: autovalidateMode,
          child: Column(
            children: [
              Center(
                child: SvgPicture.asset(
                  Assets.imagesForgotPassword,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 30),
              //   child: Text(
              //     S.of(context).verification_code,
              //     style: TextStyles.bold15inter,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 16),
              DropdownMenuExample(
                onSelected: (value) {
                  setState(() {
                    category = value;
                  });
                },
              ),

              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: S.current.full_name,
                textInputType: TextInputType.name,
                prefixIcon: Icons.person,
                onSaved: (value) => fullname = value!,
              ),
              const SizedBox(height: 16),

              CustomTextFormField(
                isEmailform: true,
                onSaved: (value) {
                  email = value!;
                },
                hintText: S.of(context).email,
                prefixIcon: Icons.email,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              CustomChangeBorderPhoneField(
                onSaved: (value) {
                  phoneNumber = value!;
                },

                prefixIcon: Icons.phone,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              CustomButton(
                onPressed: () {
                  if (formKey.currentState!.validate() && category != null) {
                    formKey.currentState!.save();
                    launchForgotPasswordEmail(
                      fullName: fullname,
                      usernameEmail: email,
                      department: category!,
                      phoneNumber: phoneNumber,
                    );
                  } else if (category == null) {
                    buildSnackBar(context, S.of(context).select_your_team);
                  } else {
                    setState(() {
                      autovalidateMode = AutovalidateMode.always;
                    });
                  }
                },
                text: S.of(context).submit,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
