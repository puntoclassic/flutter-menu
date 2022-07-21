part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountStatusUpdatedState extends AccountState {
  final AccountStatus accountStatus;

  AccountStatusUpdatedState({required this.accountStatus});
}

class AccountLoginRequestPendingState extends AccountState {}

class AccountLoginRequestResponseState extends AccountState {
  final LoginStatus loginStatus;

  AccountLoginRequestResponseState({required this.loginStatus});
}

class AccountSigninRequestPendingState extends AccountState {}

class AccountSigninRequestResponseState extends AccountState {
  final SigninStatus signinStatus;

  AccountSigninRequestResponseState({required this.signinStatus});
}

class AccountResendActivationEmailCodeResponseState extends AccountState {
  final ResendActivationCodeStatus resendActivationCodeStatus;

  AccountResendActivationEmailCodeResponseState(
      {required this.resendActivationCodeStatus});
}

class AccountActivateByCodeResponseState extends AccountState {
  final AccountActivateByCodeStatus accountActivateByCodeStatus;

  AccountActivateByCodeResponseState(
      {required this.accountActivateByCodeStatus});
}
