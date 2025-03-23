import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ReportModel>>> fetchMyReports();
}
