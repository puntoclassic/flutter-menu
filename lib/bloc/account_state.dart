part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
  final bool isLogged;

  AccountInitial({required this.isLogged});
}

class AccountLoginState extends AccountState {
  final bool isLogged;

  AccountLoginState({required this.isLogged});
}

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class AccountSigninRequestState extends AccountState {
  final SigninStatus? status;

  AccountSigninRequestState({required this.status});
}

enum LoginStatus { none, ok, pending, error, badLogin }

class AccountLoginRequestState extends AccountState {
  final LoginStatus? status;
  bool? verified;

  AccountLoginRequestState({required this.status, this.verified = false});
}
