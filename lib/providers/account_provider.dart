import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../app_options.dart';
import '../models/provider_states/account_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  final storage = const FlutterSecureStorage();

  AccountNotifier() : super(AccountState()) {
    refreshToken();
  }

  login({String email = "", String password = ""}) async {
    state = state.copyWith(loginStatus: LoginStatus.pending);

    try {
      var request = await Dio().post("$apiBaseUrl/api/login/getToken/", data: {
        "username": email.toLowerCase(),
        "password": password,
      });

      Map<String, dynamic> accessPayload = Jwt.parseJwt(request.data["access"]);

      await storage.write(key: "accessToken", value: request.data["access"]);
      await storage.write(key: "refreshToken", value: request.data["refresh"]);

      state = state.copyWith(
        loginStatus: accessPayload["verified"] == true
            ? LoginStatus.ok
            : LoginStatus.notVerified,
      );

      refreshToken();
    } on DioError {
      state = state.copyWith(loginStatus: LoginStatus.badLogin);
    }
  }

  refreshToken() async {
    String? refreshTokenValue = await storage.read(key: "refreshToken");
    String? accessTokenValue = await storage.read(key: "accessToken");

    if (refreshTokenValue != null && accessTokenValue != null) {
      var request = await Dio().post("$apiBaseUrl/api/login/refreshToken/",
          data: {"refresh": refreshTokenValue});
      if (request.data["access"] != null) {
        await storage.write(key: "accessToken", value: request.data["access"]);

        state = state.copyWith(
          loginStatus: LoginStatus.ok,
        );
        return "";
      }
    }

    print("Emetto lo stato di non loggato");

    state = state.copyWith(
      loginStatus: LoginStatus.none,
    );
  }

  logout() async {
    await storage.delete(key: "refreshToken");
    await storage.delete(key: "accessToken");

    state = state.copyWith(loginStatus: LoginStatus.none);
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
    String? accessTokenValue = await storage.read(key: "accessToken");

    await Dio().post("$apiBaseUrl/api/login/resendActivationCode/",
        options:
            Options(headers: {"Authorization": "Bearer $accessTokenValue"}));

    state = state.copyWith(
        resendActivationCodeStatus: ResendActivationCodeStatus.ok);
  }

  activateAccountByCode(String code) async {
    String? accessTokenValue = await storage.read(key: "accessToken");

    try {
      await Dio().post(
        "$apiBaseUrl/api/login/verifyAccount/",
        data: {"code": code},
        options: Options(
          headers: {"Authorization": "Bearer $accessTokenValue"},
        ),
      );

      state = state.copyWith(
        loginStatus: LoginStatus.ok,
        resendActivationCodeStatus: ResendActivationCodeStatus.none,
      );
    } on DioError {
      state = state.copyWith(
          loginStatus: LoginStatus.verificationFailed,
          resendActivationCodeStatus: ResendActivationCodeStatus.none);
    }
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier();
});
