part of 'signup_cubit.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupSuccess extends SignupState {}

final class SignupFailure extends SignupState {
  String errorMessage;
  SignupFailure({required this.errorMessage});
}

final class SignupLoading extends SignupState {}
