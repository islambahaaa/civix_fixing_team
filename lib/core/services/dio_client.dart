import 'dart:convert';
import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/shared_prefrences_singleton.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;
  DioClient(this.dio) {
    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _getToken();
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<String> _getToken() async {
    try {
      String? user = await Prefs.getString(kUserData);
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        return userMap['token'] ?? '';
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<Response> authPost(String endpoint, var data) async {
    return await dio.post(
      '${ApiConstants.baseUrl}${ApiConstants.authEndpoint}$endpoint',
      data: data,
    );
  }

  Future<Response> getMyIssues(String endpoint) async {
    return await dio.get('${ApiConstants.baseUrl}$endpoint');
  }

  Future<Response> getMyTeam(String endpoint) async {
    return await dio.get('${ApiConstants.baseUrl}$endpoint');
  }
}
