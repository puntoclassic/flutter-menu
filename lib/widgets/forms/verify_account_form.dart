import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/account_bloc.dart';

class VerifyAccountForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  VerifyAccountForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                context
                    .read<AccountBloc>()
                    .add(AccountResendActivationEmailCodeRequestEvent());
              },
              child: const Text("Reinvia codice")),
          TextFormField(
            controller: _codeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Inserisci qui il codice ricevuto via email";
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text("Codice di attivazione"),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.green),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<AccountBloc>().add(
                    AccountActivateByCodeEvent(code: _codeController.text));
              }
            },
            child: const Text("Attiva"),
          ),
        ],
      ),
    );
  }
}
