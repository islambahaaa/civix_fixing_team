import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:civix_teams/core/helper_functions/build_snack_bar.dart';
import 'package:civix_teams/core/widgets/custom_progress_hud.dart';
import 'package:civix_teams/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:civix_teams/features/auth/presentation/views/widgets/signin_view_body.dart';
import 'package:civix_teams/features/home/presentation/views/home_view.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          Navigator.pushReplacementNamed(
            context,
            HomeView.routeName,
            arguments: state.user,
          );
        }
        if (state is SigninFailure) {
          buildSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
          isLoading: state is SigninLoading,
          child: const SigninViewBody(),
        );
      },
    );
  }
}
