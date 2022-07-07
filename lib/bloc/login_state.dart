part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

enum LoginStatus { none, ok, pending, error, badLogin }

class LoginRequestState extends LoginState {
  final LoginStatus? status;

  LoginRequestState({required this.status});
}
