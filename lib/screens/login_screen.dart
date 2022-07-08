import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';
import 'package:menu/widgets/menu_body.dart';

import '../models/account_state.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginStatus =
        ref.watch(accountProvider.select((value) => value.loginStatus));

    Center loginForm = Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci un indirizzo email valido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Password',
                ),
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una password valida';
                  }
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Ho dimenticato la password"),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ref.read(accountProvider.notifier).signinReset();
                      Navigator.pushNamed(context, "/account/signin");
                    },
                    child: const Text("Crea account"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(accountProvider.notifier).login(
                            email: emailController.text,
                            password: passwordController.text);
                      }
                    },
                    child: const Text("Accedi"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    Widget content = loginForm;

    switch (loginStatus) {
      case LoginStatus.none:
        break;
      case LoginStatus.ok:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Accesso effettuato"),
          ),
        );
        break;
      case LoginStatus.pending:
        content = const Center(
          child: CircularProgressIndicator(),
        );
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
