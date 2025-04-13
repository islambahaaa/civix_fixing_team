import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:civix_teams/features/update_status/domain/repos/update_issue_status_repo.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:gal/gal.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'update_issue_status_state.dart';

class UpdateIssueStatusCubit extends Cubit<UpdateIssueStatusState> {
  UpdateIssueStatusCubit(this.updateStausRepo)
    : super(UpdateIssueStatusInitial());
  final List<File> images = [];
  UpdateIssueStatusRepo updateStausRepo;
  Future<void> addImages(List<XFile> pickedImages) async {
    images.clear();
    for (var image in pickedImages) {
      images.add(File(image.path));
    }
  }

  Future<void> updateIssueStatus(
    String issueId,
    String status,
    String description,
  ) async {
    emit(UpdateIssueStatusLoading());
    var result = await updateStausRepo.updateIssueStatus(
      issueId,
      status,
      description,
      images,
    );
    result.fold(
      (failure) => emit(UpdateIssueStatusFailure(failure.message)),
      (s) => emit(UpdateIssueStatusSuccess(s)),
    );
  }
}
