import 'dart:io';

import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/core/services/api_reports_service.dart';
import 'package:civix_teams/features/update_status/domain/repos/update_issue_status_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UpdateIssueStatusRepoImpl implements UpdateIssueStatusRepo {
  final ApiReportService apiReportService;

  UpdateIssueStatusRepoImpl({required this.apiReportService});
  @override
  Future<Either<Failure, String>> updateIssueStatus(
    String issueId,
    String status,
    String description,
    List<File> imageFiles,
  ) async {
    try {
      List<MultipartFile> imageMultipartList = await Future.wait(
        imageFiles.map((imageFile) async {
          String fileName = imageFile.path.split('/').last;
          return await MultipartFile.fromFile(
            imageFile.path,
            filename: fileName,
          );
        }),
      );
      await apiReportService.updateStatus(
        issueId,
        status,
        description,
        imageMultipartList,
      );
      return right('success');
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
