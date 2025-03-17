import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/core/widgets/custom_app_bar.dart';
import 'package:civix_teams/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_teams/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:civix_teams/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const String routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: paddingAppbar(text: S.of(context).signup, context: context),
        body: const SignUpBodyBlocConsumer(),
      ),
    );
  }
}
