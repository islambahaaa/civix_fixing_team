part of 'update_issue_status_cubit.dart';

@immutable
sealed class UpdateIssueStatusState {}

final class UpdateIssueStatusInitial extends UpdateIssueStatusState {}

final class UpdateIssueStatusLoading extends UpdateIssueStatusState {}

final class UpdateIssueStatusSuccess extends UpdateIssueStatusState {
  final String message;
  UpdateIssueStatusSuccess(this.message);
}

final class UpdateIssueStatusFailure extends UpdateIssueStatusState {
  final String errMessage;
  UpdateIssueStatusFailure(this.errMessage);
}
