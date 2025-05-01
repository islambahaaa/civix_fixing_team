import 'dart:convert';
import 'dart:developer';

import 'package:civix_teams/constants.dart';
import 'package:civix_teams/core/errors/exceptions.dart';
import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/core/services/api_auth_service.dart';

import 'package:civix_teams/core/services/shared_prefrences_singleton.dart';
import 'package:civix_teams/core/utils/backend_endpoints.dart';
import 'package:civix_teams/features/auth/data/models/user_model.dart';
import 'package:civix_teams/features/auth/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  //final FirebaseAuthService firebaseAuthService;
  final ApiAuthService apiAuthService;

  AuthRepoImpl({required this.apiAuthService});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword(
    String fname,
    String lname,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    try {
      var response = await apiAuthService.createUserWithEmailAndPassword(
        fname,
        lname,
        email,
        password,
        confirmedPassword,
      );
      var userEntity = UserEntity(
        fname: fname,
        lname: lname,
        email: email,
        token: response['token'],
      );
      return right(userEntity);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  // Future<void> deleteUser(User? user) async {
  //   if (user != null) {
  //     await firebaseAuthService.deleteUser();
  //   }
  // }

  @override
  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      var response = await apiAuthService.signInWithEmailAndPassword(
        email,
        password,
      );
      final token =
          response['token']; // Change this if your token is in another key

      if (token == null || !hasUserRole(token)) {
        return left(
          ServerFailure(
            'Your account does not have permission to access this app. Please contact support if you believe this is an error.',
          ),
        );
      }
      var userEntity = UserModel.fromJson(response);
      saveUserData(user: userEntity);
      return right(userEntity);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> checkOtp(String email, String otp) async {
    try {
      var response = await apiAuthService.checkOtp(email, otp);
      return right(response['token']);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> newPassword(
    String token,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    try {
      var response = await apiAuthService.newPassword(
        token,
        email,
        password,
        confirmedPassword,
      );
      return right(response['message']);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendOtp(String email) async {
    try {
      var response = await apiAuthService.sendOtp(email);
      return right(response.toString());
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future saveUserData({required UserEntity user}) async {
    final userModel = UserModel.fromUserEntity(user);
    var jsonData = jsonEncode(userModel.toJson());
    await Prefs.setString(kUserData, jsonData);
  }

  bool hasUserRole(String token) {
    try {
      final decodedToken = JwtDecoder.decode(token);
      final roles = decodedToken['roles'];
      return roles is List && roles.contains('TeamLeader');
    } catch (e) {
      return false;
    }
  }
}
