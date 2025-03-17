import 'dart:math';
import 'package:civix_teams/core/models/report_model.dart';
import 'package:civix_teams/features/auth/domain/entities/user_entity.dart';
import 'package:civix_teams/features/auth/presentation/views/forgot_password_view.dart';
import 'package:civix_teams/features/auth/presentation/views/new_password_view.dart';
import 'package:civix_teams/features/auth/presentation/views/otp_view.dart';
import 'package:civix_teams/features/auth/presentation/views/sign_up_view.dart';
import 'package:civix_teams/features/auth/presentation/views/signin_view.dart';
import 'package:civix_teams/features/home/presentation/views/home_view.dart';
import 'package:civix_teams/features/profile/presentation/views/profile_view.dart';
import 'package:civix_teams/features/report_details/presentation/views/report_details_view.dart';
import 'package:civix_teams/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OtpView.routeName:
      final String email = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => OtpView(email: email));
    case NewPasswordView.routeName:
      final UserEntity userEntity = settings.arguments as UserEntity;
      return MaterialPageRoute(
        builder: (context) => NewPasswordView(userEntity: userEntity),
      );
    case ForgotPasswordView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ForgotPasswordView(),
      );
    case SignUpView.routeName:
      return MaterialPageRoute(builder: (context) => const SignUpView());
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case ReportDetailsView.routeName:
      final ReportModel report = settings.arguments as ReportModel;
      return MaterialPageRoute(
        builder: (context) => ReportDetailsView(report: report),
      );
    case ProfileView.routeName:
      return MaterialPageRoute(builder: (context) => const ProfileView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
