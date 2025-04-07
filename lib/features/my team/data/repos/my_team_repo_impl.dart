import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/core/services/api_team_service.dart';
import 'package:civix_teams/features/my%20team/data/models/fixing_member_model.dart';
import 'package:civix_teams/features/my%20team/domain/repos/my_team_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class MyTeamRepoImpl implements MyTeamRepo {
  final ApiTeamService apiTeamService;

  MyTeamRepoImpl({required this.apiTeamService});
  @override
  Future<Either<Failure, List<FixingMemberModel>>> fetchMyTeam() async {
    try {
      var data = await apiTeamService.getMyTeam();
      List<FixingMemberModel> members = [];
      for (var item in data['teamMembers']) {
        var member = FixingMemberModel.fromJson(item);
        members.add(member);
      }
      return right(members);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
