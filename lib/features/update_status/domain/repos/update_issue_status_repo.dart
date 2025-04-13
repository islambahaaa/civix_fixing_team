import 'dart:io';

import 'package:civix_teams/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateIssueStatusRepo {
  Future<Either<Failure, String>> updateIssueStatus(
    String issueId,
    String status,
    String description,
    List<File> imageFiles,
  );
}
