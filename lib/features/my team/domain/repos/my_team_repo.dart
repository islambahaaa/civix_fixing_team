import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/features/my%20team/data/models/fixing_member_model.dart';
import 'package:dartz/dartz.dart';

abstract class MyTeamRepo {
  Future<Either<Failure, List<FixingMemberModel>>> fetchMyTeam();
}
