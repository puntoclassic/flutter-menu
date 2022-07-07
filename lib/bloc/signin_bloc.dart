import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:menu/app_options.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) async {
      if (event is SigninResetEvent) {
        emit(
          SigninRequestState(
            status: SigninStatus.none,
          ),
        );
      }

      if (event is SigninRequestEvent) {
        emit(
          SigninRequestState(
            status: SigninStatus.pending,
          ),
        );

        try {
          var request =
              await Dio().post("$apiBaseUrl/webapi/user/signin/", data: {
            "email": event.email,
            "username": event.email,
            "password": event.password,
            "password2": event.password,
            "first_name": event.firstName,
            "last_name": event.lastName
          });

          var requestResponse = request.data;

          if (requestResponse["status"] == "Email is busy") {
            emit(SigninRequestState(status: SigninStatus.emailBusy));
          } else if (requestResponse["status"] == "User created") {
            emit(SigninRequestState(status: SigninStatus.ok));
          } else {}
        } on DioError {
          emit(SigninRequestState(status: SigninStatus.error));
        }
      }
    });
  }
}
