import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';
import 'package:menu/widgets/menu_body.dart';

import '../models/provider_states/account_state.dart';
import '../widgets/forms/login_form.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginStatus =
        ref.watch(accountProvider.select((value) => value.loginStatus));

    Widget content = LoginForm();

    print(loginStatus);

    switch (loginStatus) {
      case LoginStatus.none:
        break;
      case LoginStatus.ok:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pop();
        });
        break;
      case LoginStatus.pending:
        content = const Center(
          child: CircularProgressIndicator(),
        );
        break;
      case LoginStatus.error:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Si è verificato un errore inaspettato"),
            ),
          );
        });
        break;
      case LoginStatus.badLogin:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Nome utente o password errata"),
            ),
          );
        });
        break;
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
  }
}
