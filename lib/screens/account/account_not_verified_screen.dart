import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';
import 'package:menu/widgets/forms/verify_account_form.dart';

import '../../models/provider_states/account_state.dart';
import '../../widgets/menu_body.dart';

class AccountNotVerifiedScreen extends ConsumerWidget {
  const AccountNotVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var resendActivationCodeStatus = ref.watch(
        accountProvider.select((value) => value.resendActivationCodeStatus));
    var accountVerifyStatus =
        ref.watch(accountProvider.select((value) => value.accountVerifyStatus));

    if (resendActivationCodeStatus == ResendActivationCodeStatus.ok) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Richiesta inviata, controlla la tua email"),
          ),
        );
      });
    }

    switch (accountVerifyStatus) {
      case AccountVerifyStatus.none:
        break;
      case AccountVerifyStatus.ok:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pushReplacementNamed("/account");
        });
        break;
      case AccountVerifyStatus.failed:
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Impossibile verificare il tuo account, codice errato."),
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
            title: const Text("Il mio account"),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: MenuBody(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                          "Il tuo account è attivo ma deve essere verificato, inserisci il codice di attivazione che ti abbiamo inviato via email."),
                      VerifyAccountForm()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
