import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/account_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

import '../widgets/forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(
      listenWhen: (previous, current) =>
          current is AccountLoginRequestPendingState ||
          current is AccountLoginRequestResponseState,
      buildWhen: (previous, current) =>
          current is AccountLoginRequestPendingState ||
          current is AccountLoginRequestResponseState,
      builder: (context, state) {
        Widget content = LoginForm();

        if (state is AccountLoginRequestPendingState) {
          content = const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Accedi"),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: MenuBody(child: content),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is AccountLoginRequestResponseState) {
          var loginStatus = state.loginStatus;
          switch (loginStatus) {
            case LoginStatus.ok:
              Navigator.of(context).pop();
              break;
            case LoginStatus.error:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Si è verificato un errore inaspettato"),
                ),
              );
              break;
            case LoginStatus.badLogin:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Nome utente o password errata"),
                ),
              );
              break;
          }
        }
      },
    );
  }
}
