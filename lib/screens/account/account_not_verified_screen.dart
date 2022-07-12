import 'package:flutter/material.dart';

import '../../widgets/menu_body.dart';

class AccountNotVerifiedScreen extends StatelessWidget {
  const AccountNotVerifiedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                onPressed: () {},
                                child: const Text("Reinvia codice")),
                            TextFormField(
                              decoration: InputDecoration(
                                  label: Text("Codice di attivazione")),
                            ),
                            OutlinedButton(
                                onPressed: () {}, child: Text("Attiva")),
                          ],
                        ),
                      )
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
