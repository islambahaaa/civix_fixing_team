import 'package:bloc/bloc.dart';
import 'package:civix_teams/features/auth/domain/entities/user_entity.dart';
import 'package:civix_teams/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.authRepo) : super(SigninInitial());
  final AuthRepo authRepo;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(SigninLoading());
    var result = await authRepo.signInWithEmailAndPassword(email, password);
    result.fold(
      (failure) => emit(SigninFailure(failure.message)),
      (user) => emit(SigninSuccess(user)),
    );
  }
}
