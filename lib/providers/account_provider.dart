import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../app_options.dart';
import '../models/account_state.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier()
      : super(AccountState(
            loginStatus: LoginStatus.none, signinStatus: SigninStatus.none));

  login({String email = "", String password = ""}) async {
    state = state.copyWith(loginStatus: LoginStatus.pending);

    var request = await Dio().post("$apiBaseUrl/webapi/user/login/", data: {
      "email": email,
      "password": password,
    });

    var requestResponse = request.data;

    if (requestResponse["status"] == "Login failed") {
      state = state.copyWith(loginStatus: LoginStatus.badLogin);
    } else if (requestResponse["status"] == "Ok") {
      state = state.copyWith(loginStatus: LoginStatus.ok);
    } else {
      state = state.copyWith(loginStatus: LoginStatus.error);
    }
  }

  signin(
      {String email = "",
      String password = "",
      String firstname = "",
      String lastname = ""}) async {
    state = state.copyWith(signinStatus: SigninStatus.pending);

    try {
      var request = await Dio().post("$apiBaseUrl/webapi/user/signin/", data: {
        "email": email,
        "username": email,
        "password": password,
        "password2": password,
        "first_name": firstname,
        "last_name": lastname
      });

      var requestResponse = request.data;

      if (requestResponse["status"] == "Email is busy") {
        state = state.copyWith(signinStatus: SigninStatus.emailBusy);
      } else if (requestResponse["status"] == "User created") {
        state = state.copyWith(signinStatus: SigninStatus.ok);
      } else {}
    } on DioError {
      state = state.copyWith(signinStatus: SigninStatus.error);
    }
  }

  signinReset() {
    state = state.copyWith(signinStatus: SigninStatus.none);
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier();
});
