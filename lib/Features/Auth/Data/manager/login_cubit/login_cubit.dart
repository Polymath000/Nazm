import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // TODO: Verfied Email here
      // FirebaseAuth.instance.currentUser!.sendEmailVerification();

      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        emit(
          LoginFailure(
            errorMessage: 'Wrong Password',
          ),
        );
      } else if (e.code == "invalid-email") {
        emit(
          LoginFailure(
            errorMessage: 'Invalid Email',
          ),
        );
      } else if (e.code == "network-request-failed") {
        emit(
          LoginFailure(
            errorMessage: 'No Internet connection',
          ),
        );
      } else if (e.code == 'invalid-credential') {
        emit(
          LoginFailure(
            errorMessage:
                'May be you change the password Or this account not found',
          ),
        );
      } else {
        print('Ex from login => ${e.code}');
      }
    } catch (e) {
      emit(LoginFailure(
          errorMessage: "There was an error , please try again later"));
    }
  }
}
