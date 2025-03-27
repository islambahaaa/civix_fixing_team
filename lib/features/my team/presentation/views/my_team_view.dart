import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/features/my%20team/presentation/views/widgets/my_team_view_body.dart';
import 'package:flutter/material.dart';

class MyTeamView extends StatelessWidget {
  const MyTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Team", style: TextStyles.semibold24inter),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: MyTeamViewBody(),
    );
  }
}
