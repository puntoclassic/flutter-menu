import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/account_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget content = signinForm(context);

    return BlocConsumer(
        listenWhen: (previous, current) =>
            current is AccountSigninRequestPendingState ||
            current is AccountSigninRequestResponseState,
        buildWhen: (previous, current) =>
            current is AccountSigninRequestPendingState ||
            current is AccountSigninRequestResponseState,
        builder: (context, state) {
          if (state is AccountSigninRequestPendingState) {
            content = pendingRequest();
          }

          if (state is AccountSigninRequestResponseState) {
            if (state.signinStatus == SigninStatus.ok) {
              content = signinOk();
            }
          }

          return Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: SafeArea(
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text("Crea account"),
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
          if (state is AccountSigninRequestResponseState) {
            if (state.signinStatus == SigninStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Si è verificato un errore"),
                ),
              );
            }

            if (state.signinStatus == SigninStatus.emailBusy) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Email in uso"),
                ),
              );
            }
          }
        });
  }

  Center signinOk() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Icon(
            Icons.done,
            color: Colors.green,
          ),
          Text(
              textAlign: TextAlign.center,
              "Il tuo account è stato creato, effettua il login e segui le istruzioni per attivarlo.")
        ],
      ),
    );
  }

  Center pendingRequest() {
    return const Center(child: CircularProgressIndicator());
  }

  Center signinForm(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Nome',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il tuo nome';
                  }

                  if (RegExp(r'^[a-z A-Z]+$').hasMatch(value) == false) {
                    return "Il nome può contenere solo caratteri";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Cognome',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci il tuo cognome';
                  }
                  if (RegExp(r'^[a-z A-Z]+$').hasMatch(value) == false) {
                    return "Il cognome può contenere solo caratteri";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
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
                  errorMaxLines: 3,
                ),
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci una password valida';
                  }

                  if (!RegExp(
                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$')
                      .hasMatch(value)) {
                    return 'La password deve essere lunga 8 caratteri e contenere: 1 lettera maiuscola, 1 numero e un carattere speciale';
                  }

                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Conferma password',
                ),
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserisci nuovamente la password';
                  }

                  if (value != passwordController.value.text) {
                    return 'Le due password non corrispodono';
                  }

                  return null;
                },
              ),
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<AccountBloc>()
                              .add(AccountSigninRequestEvent(
                                firstname: firstNameController.value.text,
                                lastname: lastNameController.value.text,
                                email: emailController.value.text,
                                password: passwordController.value.text,
                              ));
                        }
                      },
                      child: const Text("Crea account"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
