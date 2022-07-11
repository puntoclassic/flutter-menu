part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountInitEvent extends AccountEvent {}

class AccountSigninRequestEvent extends AccountEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;

  AccountSigninRequestEvent(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});
}

class AccountSigninResetEvent extends AccountEvent {}

class AccountLoginRequestEvent extends AccountEvent {
  final String? email;
  final String? password;

  AccountLoginRequestEvent({final this.email, final this.password});
}
