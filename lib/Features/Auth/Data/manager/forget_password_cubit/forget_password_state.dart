part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}
final class ForgetPasswordSuccess extends ForgetPasswordState {}

final class ForgetPasswordFailure extends ForgetPasswordState {
  String errorMessage;
  ForgetPasswordFailure({ required this.errorMessage});
}

final class ForgetPasswordLoading extends ForgetPasswordState {}