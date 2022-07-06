import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:menu/app_options.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninInitial()) {
    on<SigninEvent>((event, emit) async {
      emit(SigninRequestState(status: SigninStatus.pending));
      if (event is SigninRequestEvent) {
        /* await Future.delayed(
          Duration(seconds: 3),
          () {
            //emit(SigninRequestState(status: SigninStatus.ok));
            emit(SigninRequestState(status: SigninStatus.emailBusy));
          },
        );*/
        try {
          await Dio().post(
            "$apiBaseUrl/webapi/register/",
            data: FormData.fromMap(
              {
                "username": event.email,
                "email": event.email,
                "password": event.password,
                "password2": event.password,
                "first_name": event.firstName,
                "last_name": event.lastName
              },
            ),
          );
          emit(SigninRequestState(status: SigninStatus.ok));
        } on DioError {
          emit(SigninRequestState(status: SigninStatus.error));
        }
      }
    });
  }
}
