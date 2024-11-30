import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define states
abstract class EmailVerificationState {}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationLoading extends EmailVerificationState {}

class EmailVerificationSuccess extends EmailVerificationState {}

class EmailVerificationFailure extends EmailVerificationState {
  final String errorMessage;
  EmailVerificationFailure(this.errorMessage);
}

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit() : super(EmailVerificationInitial());
  Timer? _timer;

  Future<void> checkEmail() async {
    try {
      emit(EmailVerificationLoading());
      User? user = FirebaseAuth.instance.currentUser;
      if (user != Null) {
        await user?.sendEmailVerification();

        await user?.sendEmailVerification();
        _startPolling(user!);
      }

      // emit(EmailVerificationSuccess());
    } catch (e) {
      emit(EmailVerificationFailure(e.toString()));
    }
  }

  void _startPolling(User user) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      user.reload();
      if (user.emailVerified) {
        close();
        emit(EmailVerificationSuccess());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
