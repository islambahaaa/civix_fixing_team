import 'package:civix_teams/core/services/api_auth_service.dart';
import 'package:civix_teams/core/services/dio_client.dart';
import 'package:civix_teams/features/auth/data/repos/auth_repo_impl.dart';
import 'package:civix_teams/features/auth/domain/repos/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient(getIt.get<Dio>()));
  getIt.registerSingleton<ApiAuthService>(
    ApiAuthService(getIt.get<DioClient>()),
  );
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()),
  );
}
