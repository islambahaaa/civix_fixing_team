import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:civix_teams/core/models/report_model.dart';
import 'package:civix_teams/features/home/domain/repos/home_repo.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  Future<void> fetchMyReports() async {
    emit(HomeLoading());
    var result = await homeRepo.fetchMyReports();
    log(result.toString());
    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (reports) => emit(HomeSuccess(reports)),
    );
  }
}
