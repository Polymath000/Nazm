import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  Future<void> createNewUser(
      {required String email,
      required String password,
      required String confirmPassword,
      required String userName}) async {
    try {
      emit(SignupLoading());
      if (password == confirmPassword) {
        if (!email.contains('@')) {
          emit(SignupFailure(errorMessage: "the email is not valid"));
        } else {
          UserCredential user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          emit(SignupSuccess());
        }
      } else {
        emit(
            SignupFailure(errorMessage: "Confirm Password not equal Password"));
      }
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException SingUp => ${e.toString()} ");
      if (e.code == 'email-already-in-use') {
        emit(
          SignupFailure(errorMessage: 'email already in use'),
        );
      } else if (e.code == 'weak-password') {
        emit(
          SignupFailure(errorMessage: 'weak password'),
        );
      } else if (e.code == "invalid-email") {
        emit(
          SignupFailure(
            errorMessage: 'Invalid Email',
          ),
        );
      } else if (e.code == "network-request-failed") {
        emit(
          SignupFailure(
            errorMessage: 'No Internet connection',
          ),
        );
      } else {
        print('Ex from login => ${e.code}');
        emit(
          SignupFailure(
            errorMessage: e.toString().substring(30),
          ),
        );
      }
    } catch (e) {
      emit(SignupFailure(
          errorMessage: "There was an error , please try again later"));
      print('EX from SignUpCubit => ${e.toString()}');
    }
  }

  Future<void> signInWithGoogle() async {
    emit(SignupLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(SignupInitial());
        return;
      }
      // print(googleUser.email);
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(SignupSuccess());
    } on FirebaseAuthException catch (error) {
      emit(SignupFailure(errorMessage: error.message ?? "An error occurred"));
      print('Firebase exception: $error');
    } catch (error) {
      emit(SignupFailure(errorMessage: error.toString()));
      print('Exception: $error');
    } finally {
      emit(SignupInitial());
    }

  }

  Future<void> signOut() async {
    try {
      emit(SignupLoading());
      FirebaseAuth.instance.signOut();
      emit(SignupSuccess());
    } catch (e) {
      SignupFailure(errorMessage: e.toString());
    }
  }
}
