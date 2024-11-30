import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  final _auth = FirebaseAuth.instance;
  Future<void> resetPasswordWithEmail({required String email}) async {
    try {
      emit(ForgetPasswordLoading());
      await _auth.sendPasswordResetEmail(email: email);
      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(ForgetPasswordFailure(errorMessage: 'Invalid email'));
      } else if (e.code == 'missing-email') {
        emit(ForgetPasswordFailure(errorMessage: 'Missing email'));
      } else if (e.code == 'user-not-found') {
        emit(ForgetPasswordFailure(errorMessage: 'User not found'));
      } else if (e.code == "network-request-failed") {
        emit(
          ForgetPasswordFailure(
            errorMessage: 'No Internet connection',
          ),
        );
      } else {
        print('Ex from Forget Password => ${e.code}');
        emit(ForgetPasswordFailure(
            errorMessage:
                "There was an error, please try again later, may be this email not found"));
      }
    } catch (e) {
      emit(ForgetPasswordFailure(errorMessage: e.toString()));
    }
  }
}
