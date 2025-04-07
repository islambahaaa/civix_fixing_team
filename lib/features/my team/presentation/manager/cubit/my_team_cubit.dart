import 'package:bloc/bloc.dart';
import 'package:civix_teams/features/my%20team/data/models/fixing_member_model.dart';
import 'package:civix_teams/features/my%20team/domain/repos/my_team_repo.dart';
import 'package:meta/meta.dart';

part 'my_team_state.dart';

class MyTeamCubit extends Cubit<MyTeamState> {
  MyTeamCubit(this.myTeamRepo) : super(MyTeamInitial());
  final MyTeamRepo myTeamRepo;
  Future<void> fetchMyTeam() async {
    emit(MyTeamLoading());
    var result = await myTeamRepo.fetchMyTeam();
    result.fold(
      (failure) => emit(MyTeamFailure(failure.message)),
      (members) => emit(MyTeamSuccess(members)),
    );
  }
}
