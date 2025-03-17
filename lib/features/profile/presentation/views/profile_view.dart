import 'package:civix_teams/features/profile/presentation/views/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold(body: ProfileViewBody()));
  }
}
