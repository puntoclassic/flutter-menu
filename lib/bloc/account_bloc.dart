import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  bool accountIsLogged = false;

  AccountBloc() : super(AccountInitial(isLogged: false)) {
    on<AccountEvent>((event, emit) async {
      if (event is AccountInitEvent) {
        emit(AccountLoginState(isLogged: accountIsLogged));
      }

      if (event is AccountSigninResetEvent) {
        emit(
          AccountSigninRequestState(
            status: SigninStatus.none,
          ),
        );
      }

      if (event is AccountSigninRequestEvent) {
        emit(
          AccountSigninRequestState(
            status: SigninStatus.pending,
          ),
        );

        try {
          var request = await Dio().post("$apiBaseUrl/api/user/signin/", data: {
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
          var response = await Dio().post("$apiBaseUrl/api/user/login/", data: {
            "email": event.email,
            "password": event.password,
          });

          emit(AccountLoginRequestState(
              status: LoginStatus.ok, verified: response.data["verified"]));
        } on DioError {
          emit(AccountLoginRequestState(status: LoginStatus.badLogin));
        }
      }
    });
  }
}
