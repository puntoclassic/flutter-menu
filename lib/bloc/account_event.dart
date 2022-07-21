part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountLoginRequestEvent extends AccountEvent {
  final String email;
  final String password;

  AccountLoginRequestEvent({required this.email, required this.password});
}

class AccountSigninRequestEvent extends AccountEvent {
  final String email;
  final String password;
  final String firstname;
  final String lastname;

  AccountSigninRequestEvent(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname});
}

class AccountLogoutRequestEvent extends AccountEvent {}

class AccountSigninRequestResetEvent extends AccountEvent {}

class AccountResendActivationEmailCodeRequestEvent extends AccountEvent {}

class AccountActivateByCodeEvent extends AccountEvent {
  final String code;

  AccountActivateByCodeEvent({required this.code});
}

class AccountUpdateStatusEvent extends AccountEvent {}
