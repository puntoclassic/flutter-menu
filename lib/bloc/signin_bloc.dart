import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:menu/app_options.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  late final GraphQLClient client;

  SigninBloc() : super(SigninInitial()) {
    client = GraphQLClient(
        link: HttpLink('$apiBaseUrl/graphql'), cache: GraphQLCache());
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

        var query = r""" 
 mutation Signin($email:String!,$firstname:String!,$lastname:String!,$password:String!){
    signin(email:$email,firstname:$firstname,lastname:$lastname,password:$password) {
      response
    }
  } 
""";
        var qlResponse = await client.mutate(
          MutationOptions(
            document: gql(query),
            variables: {
              "email": event.email,
              "password": event.password,
              "firstname": event.firstName,
              "lastname": event.lastName
            },
            fetchPolicy: FetchPolicy.noCache,
          ),
        );

        var requestResponse = qlResponse.data!["signin"]["response"];

        if (requestResponse["status"] == "Email is busy") {
          emit(SigninRequestState(status: SigninStatus.emailBusy));
        } else if (requestResponse["status"] == "User created") {
          emit(SigninRequestState(status: SigninStatus.ok));
        } else {
          emit(SigninRequestState(status: SigninStatus.error));
        }
      }
    });
  }
}
