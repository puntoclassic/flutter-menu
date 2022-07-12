part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
  final bool isLogged;

  AccountInitial({required this.isLogged});
}

class AccountLoginState extends AccountState {
  final bool isLogged;
  final bool isVerified;

  AccountLoginState({required this.isLogged, required this.isVerified});
}

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class AccountSigninRequestState extends AccountState {
  final SigninStatus? status;

  AccountSigninRequestState({required this.status});
}

enum LoginStatus { none, ok, pending, error, badLogin }

class AccountLoginRequestState extends AccountState {
  final LoginStatus? status;
  bool? isVerified;

  AccountLoginRequestState({required this.status, this.isVerified = false});
}
