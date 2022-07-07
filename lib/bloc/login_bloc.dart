import 'package:bloc/bloc.dart';
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

        var query = r""" 
 query Login($email:String!,$password:String!){
    login(email:$email,password:$password) 
  } 
""";
        var qlResponse = await client.query(
          QueryOptions(
            document: gql(query),
            variables: {
              "email": event.email,
              "password": event.password,
            },
            fetchPolicy: FetchPolicy.noCache,
          ),
        );

        var requestResponse = qlResponse.data!["login"];

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
