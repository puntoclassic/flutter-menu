import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';

class VerifyAccountForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  VerifyAccountForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                ref.read(accountProvider.notifier).resendActivationEmailCode();
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
                ref
                    .read(accountProvider.notifier)
                    .activateAccountByCode(_codeController.text);
              }
            },
            child: const Text("Attiva"),
          ),
        ],
      ),
    );
  }
}
