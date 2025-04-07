import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/dio_client.dart';

class ApiTeamService {
  DioClient dio;
  ApiTeamService(this.dio);

  Future<Map<String, dynamic>> getMyTeam() async {
    var response = await dio.getMyTeam(ApiConstants.getMyTeamEndpoint);
    return response.data;
  }
}
