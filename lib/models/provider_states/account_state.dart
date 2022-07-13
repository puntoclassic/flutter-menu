enum LoginStatus {
  none,
  ok,
  pending,
  error,
  badLogin,
  notVerified,
  verificationFailed
}

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

enum ResendActivationCodeStatus { none, ok }

class AccountState {
  SigninStatus signinStatus;
  LoginStatus loginStatus;
  ResendActivationCodeStatus resendActivationCodeStatus;
  bool userIsLogged = false;
  bool userIsVerified = false;

  int? tokenExpire;

  AccountState(
      {this.signinStatus = SigninStatus.none,
      this.loginStatus = LoginStatus.pending,
      this.userIsLogged = false,
      this.userIsVerified = false,
      this.resendActivationCodeStatus = ResendActivationCodeStatus.none,
      this.tokenExpire});

  AccountState copyWith(
      {SigninStatus? signinStatus,
      LoginStatus? loginStatus,
      ResendActivationCodeStatus? resendActivationCodeStatus,
      int? tokenExpire}) {
    return AccountState(
        loginStatus: loginStatus ?? this.loginStatus,
        signinStatus: signinStatus ?? this.signinStatus,
        resendActivationCodeStatus:
            resendActivationCodeStatus ?? this.resendActivationCodeStatus,
        tokenExpire: tokenExpire ?? this.tokenExpire);
  }
}
