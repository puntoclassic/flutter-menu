import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../app_options.dart';
import '../models/provider_states/account_state.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountNotifier extends StateNotifier<AccountState> {
  final storage = const FlutterSecureStorage();
  final authApi = Dio();
  final simpleApi = Dio();

  AccountNotifier() : super(AccountState());

  initApp() {
    initDio();
    fetchAccountStatus();
  }

  initDio() async {
    simpleApi.options.baseUrl = apiBaseUrl;
    authApi.options.baseUrl = apiBaseUrl;

    authApi.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        var accessTokenValue = await storage.read(key: "accessToken");

        options.headers['Authorization'] = 'Bearer $accessTokenValue';
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        if (error.response?.statusCode == 401) {
          if (await refreshToken()) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  fetchAccountStatus() async {
    if (await refreshToken()) {
      var response = await authApi.post("/api/login/accountStatus/");

      if (response.data["verified"]) {
        state = state.copyWith(accountStatus: AccountStatus.loggedVerified);
      } else {
        state = state.copyWith(accountStatus: AccountStatus.loggedNotVerified);
      }
    } else {
      state = state.copyWith(accountStatus: AccountStatus.notLogged);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return authApi.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  login({String email = "", String password = ""}) async {
    state = state.copyWith(loginStatus: LoginStatus.pending);

    try {
      var request = await simpleApi.post("/api/login/getToken/", data: {
        "username": email.toLowerCase(),
        "password": password,
      });

      await storage.write(key: "accessToken", value: request.data["access"]);
      await storage.write(key: "refreshToken", value: request.data["refresh"]);

      fetchAccountStatus();

      state = state.copyWith(loginStatus: LoginStatus.ok);
    } on DioError {
      logout();
    }
  }

  Future<bool> refreshToken() async {
    String? refreshTokenValue = await storage.read(key: "refreshToken");

    if (refreshTokenValue != null) {
      try {
        var request = await simpleApi.post("/api/login/refreshToken/",
            data: {"refresh": refreshTokenValue});
        if (request.data["access"] != null) {
          await storage.write(
              key: "accessToken", value: request.data["access"]);

          state = state.copyWith(loginStatus: LoginStatus.ok);

          return true;
        }
      } on DioError {
        state = state.copyWith(loginStatus: LoginStatus.none);
      }
    }

    return false;
  }

  logout() async {
    await storage.delete(key: "refreshToken");
    await storage.delete(key: "accessToken");

    state = state.copyWith(
        loginStatus: LoginStatus.none, accountStatus: AccountStatus.notLogged);
  }

  signin(
      {String email = "",
      String password = "",
      String firstname = "",
      String lastname = ""}) async {
    state = state.copyWith(signinStatus: SigninStatus.pending);

    try {
      var request = await simpleApi.post("/api/signin/", data: {
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
    await authApi.post("/api/login/resendActivationCode/");

    state = state.copyWith(
        resendActivationCodeStatus: ResendActivationCodeStatus.ok);
  }

  activateAccountByCode(String code) async {
    try {
      var response = await authApi.post(
        "/api/login/verifyAccount/",
        data: {"code": code},
      );

      if (response.data["status"] == "Ok") {
        state = state.copyWith(
          verificationStatus: VerificationStatus.succeed,
          accountStatus: AccountStatus.loggedVerified,
          resendActivationCodeStatus: ResendActivationCodeStatus.none,
        );
      } else {
        state = state.copyWith(
            verificationStatus: VerificationStatus.failed,
            accountStatus: AccountStatus.loggedNotVerified,
            resendActivationCodeStatus: ResendActivationCodeStatus.none);
      }
    } on DioError {
      state = state.copyWith(
          verificationStatus: VerificationStatus.failed,
          accountStatus: AccountStatus.loggedNotVerified,
          resendActivationCodeStatus: ResendActivationCodeStatus.none);
    }
  }
}

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  return AccountNotifier();
});
