enum LoginStatus { none, ok, pending, error, badLogin }

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class AccountState {
  SigninStatus signinStatus = SigninStatus.none;
  LoginStatus loginStatus = LoginStatus.none;
  bool userIsLogged = false;

  AccountState({required this.signinStatus, required this.loginStatus});

  AccountState copyWith(
      {SigninStatus? signinStatus, LoginStatus? loginStatus}) {
    return AccountState(
        loginStatus: loginStatus ?? this.loginStatus,
        signinStatus: signinStatus ?? this.signinStatus);
  }
}
