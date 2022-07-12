enum LoginStatus { none, ok, pending, error, badLogin }

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class AccountState {
  SigninStatus signinStatus = SigninStatus.none;
  LoginStatus loginStatus = LoginStatus.none;
  bool userIsLogged;
  bool userIsVerified;
  String? refreshToken;
  String? accessToken;

  AccountState({
    required this.signinStatus,
    required this.loginStatus,
    this.userIsLogged = false,
    this.userIsVerified = true,
    this.refreshToken,
    this.accessToken,
  });

  AccountState copyWith({
    SigninStatus? signinStatus,
    LoginStatus? loginStatus,
    bool? userIsLogged,
    bool? userIsVerified,
    String? refreshToken,
    String? accessToken,
  }) {
    return AccountState(
      loginStatus: loginStatus ?? this.loginStatus,
      signinStatus: signinStatus ?? this.signinStatus,
      userIsLogged: userIsLogged ?? this.userIsLogged,
      userIsVerified: userIsVerified ?? this.userIsVerified,
      refreshToken: refreshToken ?? this.refreshToken,
      accessToken: accessToken ?? this.accessToken,
    );
  }
}
