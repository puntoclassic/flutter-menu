import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../app_options.dart';
import '../models/provider_states/account_state.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier() : super(AccountState());

  login({String email = "", String password = ""}) async {
    state = state.copyWith(loginStatus: LoginStatus.pending);

    try {
      var request = await Dio().post("$apiBaseUrl/api/login/getToken/", data: {
        "username": email.toLowerCase(),
        "password": password,
      });

      Map<String, dynamic> accessPayload = Jwt.parseJwt(request.data["access"]);

      state = state.copyWith(
          loginStatus: LoginStatus.ok,
          userIsLogged: true,
          accessToken: request.data["access"],
          refreshToken: request.data["refresh"],
          userIsVerified: accessPayload["verified"]);
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
      var request = await Dio().post("$apiBaseUrl/webapi/signin/", data: {
        "email": email.toLowerCase(),
        "username": email.toLowerCase(),
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

  resendActivationEmailCode() async {
    await Dio().post("$apiBaseUrl/api/login/resendActivationCode/",
        options:
            Options(headers: {"Authorization": "Bearer ${state.accessToken}"}));

    state = state.copyWith(
        resendActivationCodeStatus: ResendActivationCodeStatus.ok);
  }

  activateAccountByCode(String code) async {
    try {
      await Dio().post(
        "$apiBaseUrl/api/login/verifyAccount/",
        data: {"code": code},
        options: Options(
          headers: {"Authorization": "Bearer ${state.accessToken}"},
        ),
      );

      state = state.copyWith(
          accountVerifyStatus: AccountVerifyStatus.ok,
          resendActivationCodeStatus: ResendActivationCodeStatus.none,
          userIsLogged: true,
          userIsVerified: true);
    } on DioError {
      state = state.copyWith(
          accountVerifyStatus: AccountVerifyStatus.failed,
          resendActivationCodeStatus: ResendActivationCodeStatus.none);
    }
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier();
});
