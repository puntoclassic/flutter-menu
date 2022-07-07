part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class SigninRequestEvent extends SigninEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  SigninRequestEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}

class SigninResetEvent extends SigninEvent {}
