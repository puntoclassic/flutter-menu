part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {
  final bool isLogged;

  AccountInitial({required this.isLogged});
}

class AccountLoginState extends AccountState {
  final bool isLogged;

  AccountLoginState({required this.isLogged});
}
