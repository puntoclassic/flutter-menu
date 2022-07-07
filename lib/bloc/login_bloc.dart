import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:meta/meta.dart';

import '../app_options.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final GraphQLClient client;

  LoginBloc() : super(LoginInitial()) {
    client = GraphQLClient(
        link: HttpLink('$apiBaseUrl/graphql'), cache: GraphQLCache());
    on<LoginEvent>((event, emit) async {
      if (event is LoginRequestEvent) {
        emit(
          LoginRequestState(
            status: LoginStatus.pending,
          ),
        );

        var request = await Dio().post("$apiBaseUrl/webapi/user/login/", data: {
          "email": event.email,
          "password": event.password,
        });

        var requestResponse = request.data;

        if (requestResponse["status"] == "Login failed") {
          emit(LoginRequestState(status: LoginStatus.badLogin));
        } else if (requestResponse["status"] == "Ok") {
          emit(LoginRequestState(status: LoginStatus.ok));
        } else {
          emit(LoginRequestState(status: LoginStatus.error));
        }
      }
    });
  }
}
