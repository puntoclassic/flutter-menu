enum LoginStatus { none, ok, pending, error, badLogin }

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

enum ResendActivationCodeStatus { none, ok }

enum AccountVerifyStatus { none, ok, failed }

class AccountState {
  SigninStatus signinStatus = SigninStatus.none;
  LoginStatus loginStatus = LoginStatus.none;
  ResendActivationCodeStatus resendActivationCodeStatus =
      ResendActivationCodeStatus.none;
  AccountVerifyStatus accountVerifyStatus = AccountVerifyStatus.none;
  bool userIsLogged = false;
  bool userIsVerified = false;
  String? accessToken;
  String? refreshToken;

  AccountState({
    this.signinStatus = SigninStatus.none,
    this.loginStatus = LoginStatus.none,
    this.userIsLogged = false,
    this.userIsVerified = false,
    this.accessToken = "",
    this.refreshToken = "",
    this.accountVerifyStatus = AccountVerifyStatus.none,
    this.resendActivationCodeStatus = ResendActivationCodeStatus.none,
  });

  AccountState copyWith({
    SigninStatus? signinStatus,
    LoginStatus? loginStatus,
    bool? userIsLogged,
    bool? userIsVerified,
    String? accessToken,
    String? refreshToken,
    AccountVerifyStatus? accountVerifyStatus,
    ResendActivationCodeStatus? resendActivationCodeStatus,
  }) {
    return AccountState(
        loginStatus: loginStatus ?? this.loginStatus,
        signinStatus: signinStatus ?? this.signinStatus,
        userIsLogged: userIsLogged ?? this.userIsLogged,
        userIsVerified: userIsVerified ?? this.userIsVerified,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        accountVerifyStatus: accountVerifyStatus ?? this.accountVerifyStatus,
        resendActivationCodeStatus:
            resendActivationCodeStatus ?? this.resendActivationCodeStatus);
  }
}
