import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../app_options.dart';
import '../models/provider_states/account_state.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier()
      : super(AccountState(
            loginStatus: LoginStatus.none,
            signinStatus: SigninStatus.none,
            userIsLogged: false));

  login({String email = "", String password = ""}) async {
    state = state.copyWith(loginStatus: LoginStatus.pending);

    try {
      var request = await Dio().post("$apiBaseUrl/api/user/token/", data: {
        "username": email,
        "password": password,
      });

      Map<String, dynamic> accessPayload = Jwt.parseJwt(request.data["access"]);

      state = state.copyWith(loginStatus: LoginStatus.ok, userIsLogged: true);
    } on DioError {
      state = state.copyWith(loginStatus: LoginStatus.badLogin);
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
