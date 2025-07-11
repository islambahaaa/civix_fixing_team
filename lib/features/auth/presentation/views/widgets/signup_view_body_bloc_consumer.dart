import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/core/widgets/custom_progress_hud.dart';
import 'package:civix_teams/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:civix_teams/features/auth/presentation/views/widgets/sign_up_view_body.dart';

class SignUpBodyBlocConsumer extends StatelessWidget {
  const SignUpBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          buildSnackBar(context, S.of(context).success);
          Navigator.of(context).pop();
        }
        if (state is SignupFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SignupLoading,
          child: const SignUpViewBody(),
        );
      },
    );
  }
}
