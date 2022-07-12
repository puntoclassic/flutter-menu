import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  bool accountIsLogged = false;
  String? accessToken;
  String? refreshToken;

  AccountBloc() : super(AccountInitial(isLogged: false)) {
    on<AccountEvent>((event, emit) async {
      if (event is AccountInitEvent) {
        emit(AccountLoginState(isLogged: false, isVerified: false));
      }

      if (event is AccountSigninResetEvent) {
        emit(
          AccountSigninRequestState(
            status: SigninStatus.none,
          ),
        );
      }

      if (event is AccountRefreshTokenEvent) {
        var response = await Dio().post(
          "$apiBaseUrl/api/login/refreshToken/",
          data: {
            "refresh": refreshToken,
          },
        );

        accessToken = response.data["access"];
      }

      if (event is AccountSigninRequestEvent) {
        emit(
          AccountSigninRequestState(
            status: SigninStatus.pending,
          ),
        );

        try {
          var request = await Dio().post("$apiBaseUrl/api/signin/", data: {
            "email": event.email,
            "username": event.email,
            "password": event.password,
            "password2": event.password,
            "first_name": event.firstName,
            "last_name": event.lastName
          });

          var requestResponse = request.data;

          if (requestResponse["status"] == "Email is busy") {
            emit(AccountSigninRequestState(status: SigninStatus.emailBusy));
          } else if (requestResponse["status"] == "User created") {
            emit(AccountSigninRequestState(status: SigninStatus.ok));
          } else {}
        } on DioError {
          emit(AccountSigninRequestState(status: SigninStatus.error));
        }
      }

      if (event is AccountLoginRequestEvent) {
        emit(
          AccountLoginRequestState(
            status: LoginStatus.pending,
          ),
        );

        try {
          var response = await Dio().post("$apiBaseUrl/api/login/", data: {
            "username": event.email,
            "password": event.password,
          });

          var tokenData = Jwt.parseJwt(response.data["access"]);

          accessToken = response.data["access"];
          refreshToken = response.data["refresh"];

          emit(AccountLoginRequestState(
              status: LoginStatus.ok, isVerified: tokenData["verified"]));
        } on DioError {
          emit(AccountLoginRequestState(status: LoginStatus.badLogin));
        }
      }
    });
  }
}
