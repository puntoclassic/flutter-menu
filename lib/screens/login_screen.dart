import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/widgets/login_form.dart';
import 'package:menu/widgets/menu_body.dart';

import '../bloc/account_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: MenuBody(
              child: BlocConsumer<AccountBloc, AccountState>(
                  builder: (context, state) {
                return LoginForm();
              }, listener: (context, state) {
                if (state is AccountLoginRequestState) {
                  if (state.status == LoginStatus.badLogin) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Nome utente o password errata"),
                      ),
                    );
                  }

                  if (state.status == LoginStatus.ok) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Accesso effettuato"),
                      ),
                    );
                  }

                  if (state.status == LoginStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Si è verificato un errore inaspettato"),
                      ),
                    );
                  }
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
