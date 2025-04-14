import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/features/home/domain/repos/home_repo.dart';

import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  Future<void> fetchMyReports() async {
    emit(HomeLoading());
    var result = await homeRepo.fetchMyReports();
    result.fold((failure) => emit(HomeFailure(failure.message)), (reports) {
      List<ReportModel> resolvedReports =
          reports
              .where(
                (r) =>
                    r.fixingStatus == 'Fixed' || r.fixingStatus == 'Declined',
              )
              .toList();
      List<ReportModel> activeReports =
          reports
              .where(
                (r) =>
                    r.fixingStatus != 'Fixed' && r.fixingStatus != 'Declined',
              )
              .toList();
      emit(HomeSuccess(activeReports, resolvedReports));
    });
  }
}
