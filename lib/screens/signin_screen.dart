import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/signin_bloc.dart';
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
    return BlocConsumer<SigninBloc, SigninState>(
      builder: (context, state) {
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
                child: MenuBody(child: BlocBuilder<SigninBloc, SigninState>(
                  builder: (context, state) {
                    if (state is SigninRequestState) {
                      if (state.status == SigninStatus.none) {
                        return signinForm(context);
                      }
                      if (state.status == SigninStatus.pending) {
                        return pendingRequest();
                      }
                      if (state.status == SigninStatus.ok) {
                        return signinOk();
                      }
                    }
                    return signinForm(context);
                  },
                )),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is SigninRequestState) {
          if (state.status == SigninStatus.emailBusy) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email in uso"),
              ),
            );
          }
          if (state.status == SigninStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Si è verificato un errore"),
              ),
            );
          }
        }
      },
    );
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
              "Il tuo account è stato creato, verifica la tua email per attivarlo.")
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
                          context.read<SigninBloc>().add(
                                SigninRequestEvent(
                                  firstName: firstNameController.value.text,
                                  lastName: lastNameController.value.text,
                                  email: emailController.value.text,
                                  password: passwordController.value.text,
                                ),
                              );
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
