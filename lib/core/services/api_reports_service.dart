import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/dio_client.dart';
import 'package:dio/dio.dart';

class ApiReportService {
  DioClient dio;
  ApiReportService(this.dio);

  Future<List<Map<String, dynamic>>> getMyIssues() async {
    var response = await dio.getMyIssues(ApiConstants.myIssuesEndpoint);
    return (response.data as List)
        .map((item) => item as Map<String, dynamic>)
        .toList();
  }

  Future<String> updateStatus(
    String issueId,
    String status,
    String description,
    List<MultipartFile> imageMultipartList,
  ) async {
    FormData formData = FormData.fromMap({
      'issueid': issueId,
      'description': description,
      'status': status,
      'images': imageMultipartList, // Attach image file
    });
    var response = await dio.postIssueUpdate(
      ApiConstants.updateIssueEndPoint,
      formData,
    );
    return response.data;
  }
}
