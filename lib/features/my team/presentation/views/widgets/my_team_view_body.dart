import 'package:civix_teams/features/my%20team/presentation/manager/cubit/my_team_cubit.dart';
import 'package:civix_teams/features/my%20team/presentation/views/widgets/contact_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTeamViewBody extends StatelessWidget {
  const MyTeamViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<MyTeamCubit, MyTeamState>(
        builder: (context, state) {
          if (state is MyTeamLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MyTeamSuccess) {
            return ListView.builder(
              itemCount: state.members.length,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                var member = state.members[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ContactTile(
                    name: member.name,
                    age: member.age,
                    jobTitle: member.jobTitle,
                    phoneNumber: member.phoneNumber,
                  ),
                );
              },
            );
          } else if (state is MyTeamFailure) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
