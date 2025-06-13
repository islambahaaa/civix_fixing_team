import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class ApiAuthService {
  DioClient dio;
  ApiAuthService(this.dio);
  Future<Map<String, dynamic>> createUserWithEmailAndPassword(
    String fname,
    String lname,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    var response = await dio.authPost(ApiConstants.register, {
      "firstName": fname,
      "lastName": lname,
      "email": email,
      "password": password,
      "confirmedPassword": confirmedPassword,
      "phoneNumber": "011111111",
    });
    return response.data;
  }

  Future<Map<String, dynamic>> signInWithEmailAndPassword(
    String email,
    String password, {
    String? fcmToken,
  }) async {
    var response = await dio.authPost(ApiConstants.login, {
      "email": email,
      "password": password,
    }, fcmToken: fcmToken);
    return response.data;
  }

  Future<String> sendOtp(String email) async {
    var response = await dio.authPost(ApiConstants.sendOtp, {"email": email});
    return response.data;
  }

  Future<Map<String, dynamic>> checkOtp(String email, String otp) async {
    var response = await dio.authPost(ApiConstants.checkOtp, {
      "email": email,
      "inputOtp": otp,
    });
    return response.data;
  }

  Future<Map<String, dynamic>> newPassword(
    String token,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    var response = await dio.authPost(ApiConstants.newPassword, {
      "email": email,
      "token": token,
      "newPassword": password,
      "confirmedPassword": confirmedPassword,
    });
    return response.data;
  }
}
