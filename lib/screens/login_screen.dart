import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/login_bloc.dart';
import 'package:menu/bloc/signin_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loginForm = Center(
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
                      context.read<SigninBloc>().add(
                            SigninResetEvent(),
                          );
                      Navigator.pushNamed(context, "/account/signin");
                    },
                    child: const Text("Crea account"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(LoginRequestEvent(
                            email: emailController.text,
                            password: passwordController.text));
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
              child: BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                return loginForm;
              }, listener: (context, state) {
                if (state is LoginRequestState) {
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
