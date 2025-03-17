import 'dart:math';

import 'package:civix_app/features/profile/presentation/views/profile_view.dart';
import 'package:civix_app/features/report/data/models/report_model.dart';
import 'package:civix_app/features/auth/domain/entities/user_entity.dart';
import 'package:civix_app/features/auth/presentation/views/forgot_password_view.dart';
import 'package:civix_app/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_app/features/auth/presentation/views/otp_view.dart';
import 'package:civix_app/features/auth/presentation/views/sign_up_view.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/home/presentation/views/home_view.dart';
import 'package:civix_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:civix_app/features/report/presentation/cubits/report_cubit/report_cubit.dart';
import 'package:civix_app/features/report/presentation/views/location_pick.dart';
import 'package:civix_app/features/report/presentation/views/report_view.dart';
import 'package:civix_app/features/report_details/presentation/views/report_details_view.dart';
import 'package:civix_app/features/solved_in_my_area/presentation/views/solved_in_my_area_view.dart';
import 'package:civix_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OtpView.routeName:
      final String email = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpView(
                email: email,
              ));
    case NewPasswordView.routeName:
      final UserEntity userEntity = settings.arguments as UserEntity;
      return MaterialPageRoute(
          builder: (context) => NewPasswordView(
                userEntity: userEntity,
              ));
    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ForgotPasswordView());
    case ReportView.routeName:
      return MaterialPageRoute(builder: (context) => const ReportView());
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case SolvedInMyAreaView.routeName:
      return MaterialPageRoute(
          builder: (context) => const SolvedInMyAreaView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case ReportDetailsView.routeName:
      final ReportModel report = settings.arguments as ReportModel;
      return MaterialPageRoute(
          builder: (context) => ReportDetailsView(
                report: report,
              ));
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case LocationPick.routeName:
      final ReportCubit reportCubit = settings.arguments as ReportCubit;
      return MaterialPageRoute(
          builder: (context) => LocationPick(
                reportCubit: reportCubit,
              ));
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
