part of 'my_team_cubit.dart';

@immutable
sealed class MyTeamState {}

final class MyTeamInitial extends MyTeamState {}

final class MyTeamLoading extends MyTeamState {}

final class MyTeamSuccess extends MyTeamState {
  final List<FixingMemberModel> members;

  MyTeamSuccess(this.members);
}

final class MyTeamFailure extends MyTeamState {
  final String message;

  MyTeamFailure(this.message);
}
