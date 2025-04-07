import 'package:civix_teams/core/services/api_auth_service.dart';
import 'package:civix_teams/core/services/api_reports_service.dart';
import 'package:civix_teams/core/services/api_team_service.dart';
import 'package:civix_teams/core/services/dio_client.dart';
import 'package:civix_teams/features/auth/data/repos/auth_repo_impl.dart';
import 'package:civix_teams/features/auth/domain/repos/auth_repo.dart';
import 'package:civix_teams/features/home/data/repos/home_repo_impl.dart';
import 'package:civix_teams/features/home/domain/repos/home_repo.dart';
import 'package:civix_teams/features/my%20team/data/repos/my_team_repo_impl.dart';
import 'package:civix_teams/features/my%20team/domain/repos/my_team_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerSingleton(DioClient(getIt.get<Dio>()));
  //services
  getIt.registerSingleton<ApiReportService>(
    ApiReportService(getIt.get<DioClient>()),
  );
  getIt.registerSingleton<ApiTeamService>(
    ApiTeamService(getIt.get<DioClient>()),
  );
  getIt.registerSingleton<ApiAuthService>(
    ApiAuthService(getIt.get<DioClient>()),
  );
  //repos
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(apiAuthService: getIt.get<ApiAuthService>()),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImpl(apiReportService: getIt.get<ApiReportService>()),
  );
  getIt.registerSingleton<MyTeamRepo>(
    MyTeamRepoImpl(apiTeamService: getIt.get<ApiTeamService>()),
  );
}
