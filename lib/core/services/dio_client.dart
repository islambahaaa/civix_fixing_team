import 'dart:developer';

import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio);
  Future<Response> authPost(String endpoint, var data) async {
    Response response = await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.AuthEndpoint}$endpoint',
      data: data,
    );
    return response;
  }

  Future<Response> reportPost(
    String endpoint,
    FormData formData,
    String token,
  ) async {
    Response response = await dio.post(
      '${ApiConstants.baseUrl}$endpoint',
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token",
        },
      ),
    );
    return response;
  }
}
