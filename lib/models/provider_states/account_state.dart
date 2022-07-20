enum LoginStatus { none, ok, pending, error, badLogin }

enum AccountStatus { notLogged, loggedVerified, loggedNotVerified }

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

enum ResendActivationCodeStatus { none, ok }

enum VerificationStatus { none, succeed, failed }

class AccountState {
  AccountStatus accountStatus;
  SigninStatus signinStatus;
  LoginStatus loginStatus;
  ResendActivationCodeStatus resendActivationCodeStatus;
  VerificationStatus verificationStatus;

  AccountState(
      {this.signinStatus = SigninStatus.none,
      this.loginStatus = LoginStatus.none,
      this.accountStatus = AccountStatus.notLogged,
      this.resendActivationCodeStatus = ResendActivationCodeStatus.none,
      this.verificationStatus = VerificationStatus.none});

  AccountState copyWith(
      {SigninStatus? signinStatus,
      LoginStatus? loginStatus,
      ResendActivationCodeStatus? resendActivationCodeStatus,
      AccountStatus? accountStatus,
      VerificationStatus? verificationStatus}) {
    return AccountState(
        loginStatus: loginStatus ?? this.loginStatus,
        signinStatus: signinStatus ?? this.signinStatus,
        resendActivationCodeStatus:
            resendActivationCodeStatus ?? this.resendActivationCodeStatus,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        accountStatus: accountStatus ?? this.accountStatus);
  }
}
