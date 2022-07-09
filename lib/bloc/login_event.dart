part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginRequestEvent extends LoginEvent {
  final String? email;
  final String? password;

  LoginRequestEvent({final this.email, final this.password});
}
