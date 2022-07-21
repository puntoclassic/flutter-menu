import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'account_event.dart';
part 'account_state.dart';

enum LoginStatus {
  ok,
  error,
  badLogin,
}

enum AccountStatus { notLogged, logged, loggedNotVerified }

enum SigninStatus { ok, error, emailBusy, none }

enum ResendActivationCodeStatus { none, ok }

enum AccountActivateByCodeStatus { none, ok, failed }

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final storage = const FlutterSecureStorage();
  final authApi = Dio();
  final simpleApi = Dio();
  AccountStatus accountStatus = AccountStatus.notLogged;

  Future<bool> refreshToken() async {
    String? refreshTokenValue = await storage.read(key: "refreshToken");

    if (refreshTokenValue != null) {
      try {
        var request = await simpleApi.post("/api/login/refreshToken/",
            data: {"refresh": refreshTokenValue});
        if (request.data["access"] != null) {
          await storage.write(
              key: "accessToken", value: request.data["access"]);

          accountStatus = AccountStatus.logged;
          return true;
        }
      } on DioError {
        //Il token di refresh non è più valido quindi l'utente deve rifare il login
        add(AccountLogoutRequestEvent());
      }
    }

    return false;
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

  AccountBloc() : super(AccountInitial()) {
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

    on<AccountEvent>((event, emit) async {
      if (event is AccountUpdateStatusEvent) {
        if (await refreshToken()) {
          var response = await authApi.post("/api/login/accountStatus/");
          if (response.data["verified"] == true) {
            emit(
                AccountStatusUpdatedState(accountStatus: AccountStatus.logged));
          } else {
            emit(AccountStatusUpdatedState(
                accountStatus: AccountStatus.loggedNotVerified));
          }
        } else {
          emit(AccountStatusUpdatedState(
              accountStatus: AccountStatus.notLogged));
        }
      }

      //LOGOUT EVENT
      if (event is AccountLogoutRequestEvent) {
        await storage.delete(key: "refreshToken");
        await storage.delete(key: "accessToken");

        emit(AccountStatusUpdatedState(accountStatus: AccountStatus.notLogged));
      }

      //LOGIN EVENT
      if (event is AccountLoginRequestEvent) {
        try {
          var request = await simpleApi.post("/api/login/getToken/", data: {
            "username": event.email.toLowerCase(),
            "password": event.password,
          });

          await storage.write(
              key: "accessToken", value: request.data["access"]);
          await storage.write(
              key: "refreshToken", value: request.data["refresh"]);

          emit(AccountLoginRequestResponseState(loginStatus: LoginStatus.ok));

          add(AccountUpdateStatusEvent());
        } on DioError {
          emit(AccountLoginRequestResponseState(
              loginStatus: LoginStatus.badLogin));
        }
      }

      //RESET SIGNIN PAGE
      if (event is AccountSigninRequestResetEvent) {
        emit(
          AccountSigninRequestResponseState(
            signinStatus: SigninStatus.none,
          ),
        );
      }

      if (event is AccountResendActivationEmailCodeRequestEvent) {
        await authApi.post("/api/login/resendActivationCode/");

        emit(
          AccountResendActivationEmailCodeResponseState(
            resendActivationCodeStatus: ResendActivationCodeStatus.ok,
          ),
        );
      }

      if (event is AccountSigninRequestEvent) {
        emit(AccountSigninRequestPendingState());
        emit(
          AccountActivateByCodeResponseState(
            accountActivateByCodeStatus: AccountActivateByCodeStatus.none,
          ),
        );

        try {
          var request = await simpleApi.post("/api/signin/", data: {
            "email": event.email.toLowerCase(),
            "username": event.email.toLowerCase(),
            "password": event.password,
            "password2": event.password,
            "first_name": event.firstname,
            "last_name": event.lastname
          });

          var requestResponse = request.data;

          if (requestResponse["status"] == "Email is busy") {
            emit(AccountSigninRequestResponseState(
                signinStatus: SigninStatus.emailBusy));
          } else if (requestResponse["status"] == "User created") {
            emit(AccountSigninRequestResponseState(
                signinStatus: SigninStatus.ok));
          }
          emit(
            AccountStatusUpdatedState(
              accountStatus: AccountStatus.notLogged,
            ),
          );
        } on DioError {
          emit(
            AccountSigninRequestResponseState(
              signinStatus: SigninStatus.error,
            ),
          );
          emit(
            AccountStatusUpdatedState(
              accountStatus: AccountStatus.notLogged,
            ),
          );
        }
      }

      if (event is AccountActivateByCodeEvent) {
        try {
          await authApi.post(
            "/api/login/verifyAccount/",
            data: {"code": event.code},
          );

          emit(
            AccountActivateByCodeResponseState(
              accountActivateByCodeStatus: AccountActivateByCodeStatus.ok,
            ),
          );
        } on DioError {
          emit(
            AccountActivateByCodeResponseState(
              accountActivateByCodeStatus: AccountActivateByCodeStatus.failed,
            ),
          );
        }
      }
    });
  }
}
