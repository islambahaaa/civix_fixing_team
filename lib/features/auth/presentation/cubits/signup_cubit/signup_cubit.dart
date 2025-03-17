import 'package:bloc/bloc.dart';
import 'package:civix_teams/features/auth/domain/entities/user_entity.dart';
import 'package:civix_teams/features/auth/domain/repos/auth_repo.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
    String fname,
    String lname,
    String email,
    String password,
    String confirmedPassword,
  ) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      fname,
      lname,
      email,
      password,
      confirmedPassword,
    );
    result.fold(
      (failure) => emit(SignupFailure(failure.message)),
      (user) => emit(SignupSuccess(user)),
    );
  }
}
