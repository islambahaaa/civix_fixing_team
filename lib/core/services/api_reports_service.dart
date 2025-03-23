import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/dio_client.dart';

class ApiReportService {
  DioClient dio;
  ApiReportService(this.dio);

  Future<Map<String, dynamic>> getMyIssues() async {
    var response = await dio.getMyIssues(ApiConstants.myIssuesEndpoint);
    return response.data;
  }
}
