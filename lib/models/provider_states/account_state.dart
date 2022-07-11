enum LoginStatus { none, ok, pending, error, badLogin }

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class AccountState {
  SigninStatus signinStatus = SigninStatus.none;
  LoginStatus loginStatus = LoginStatus.none;
  bool userIsLogged = false;

  AccountState(
      {required this.signinStatus,
      required this.loginStatus,
      required this.userIsLogged});

  AccountState copyWith(
      {SigninStatus? signinStatus,
      LoginStatus? loginStatus,
      bool? userIsLogged}) {
    return AccountState(
        loginStatus: loginStatus ?? this.loginStatus,
        signinStatus: signinStatus ?? this.signinStatus,
        userIsLogged: userIsLogged ?? this.userIsLogged);
  }
}
