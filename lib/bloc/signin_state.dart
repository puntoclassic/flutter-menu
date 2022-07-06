part of 'signin_bloc.dart';

@immutable
abstract class SigninState {}

class SigninInitial extends SigninState {}

enum SigninStatus { none, ok, pending, error, badPassword, emailBusy }

class SigninRequestState extends SigninState {
  final SigninStatus? status;

  SigninRequestState({required this.status});
}
