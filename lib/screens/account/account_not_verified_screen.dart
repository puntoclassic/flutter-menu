import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/account_bloc.dart';
import 'package:menu/widgets/forms/verify_account_form.dart';

import '../../widgets/menu_body.dart';

class AccountNotVerifiedScreen extends StatelessWidget {
  const AccountNotVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountBloc, AccountState>(builder: (context, state) {
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
    }, listener: (context, state) {
      if (state is AccountResendActivationEmailCodeResponseState) {
        if (state.resendActivationCodeStatus == ResendActivationCodeStatus.ok) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Richiesta inviata, controlla la tua email"),
            ),
          );
        }
      }

      if (state is AccountActivateByCodeResponseState) {
        if (state.accountActivateByCodeStatus ==
            AccountActivateByCodeStatus.failed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
                  Text("Impossibile verificare il tuo account, codice errato."),
            ),
          );
        }

        if (state.accountActivateByCodeStatus ==
            AccountActivateByCodeStatus.ok) {
          Navigator.of(context).pushReplacementNamed("/account");
        }
      }
    });
  }
}
