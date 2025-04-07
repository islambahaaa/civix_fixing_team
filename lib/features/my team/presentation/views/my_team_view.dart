import 'package:civix_teams/core/services/get_it_service.dart';
import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/core/utils/app_text_styles.dart';
import 'package:civix_teams/features/my%20team/domain/repos/my_team_repo.dart';
import 'package:civix_teams/features/my%20team/presentation/manager/cubit/my_team_cubit.dart';
import 'package:civix_teams/features/my%20team/presentation/views/widgets/my_team_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTeamView extends StatelessWidget {
  const MyTeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Team", style: TextStyles.semibold24inter),
        centerTitle: true,
      ),
      body: MyTeamViewBody(),
    );
  }
}
