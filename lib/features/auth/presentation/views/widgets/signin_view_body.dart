import 'package:civix_teams/features/auth/presentation/views/forgot_password_view.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/core/widgets/custom_button.dart';
import 'package:civix_teams/core/widgets/custom_text_form_field.dart';
import 'package:civix_teams/core/widgets/password_field.dart';
import 'package:civix_teams/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'dont_have_account_widget.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
        child: AutofillGroup(
          child: Form(
            key: formKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              children: [
                const SizedBox(height: 16),
                CustomChangeBorderTextField(
                  isEmailform: true,
                  onSaved: (value) {
                    email = value!;
                  },
                  hintText: S.of(context).email,
                  prefixIcon: Icons.email,
                  textInputType: TextInputType.emailAddress,
                  autofillhints: [AutofillHints.email],
                ),
                const SizedBox(height: 16),
                PasswordField(
                  onSaved: (value) {
                    password = value!;
                  },
                  hintText: S.of(context).password,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(ForgotPasswordView.routeName);
                      },
                      child: Text(
                        S.of(context).forgot_pass,
                        style: TextStyles.semibold16inter.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      context.read<SigninCubit>().signInWithEmailAndPassword(
                        email,
                        password,
                      );
                    } else {
                      setState(() {
                        autovalidateMode = AutovalidateMode.always;
                      });
                    }
                  },
                  text: S.of(context).login,
                ),
                const SizedBox(height: 16),
                //const DontHaveAccount(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
