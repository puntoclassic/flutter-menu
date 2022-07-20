import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';
import 'package:menu/widgets/menu_body.dart';

import '../models/provider_states/account_state.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountStatus =
        ref.watch(accountProvider.select((value) => value.accountStatus));

    print(accountStatus);

    Widget? loginButton = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/account/login");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.login),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Accedi"),
              )
            ],
          ),
        ),
      ),
    );

    Widget? signinButton = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed("/account/signin");
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.account_box),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Crea account"),
              )
            ],
          ),
        ),
      ),
    );

    Column? manageMenu = Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: const BoxDecoration(border: Border(bottom: BorderSide())),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text("GESTIONE"),
                )
              ]),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.display_settings),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text("Le mie informazioni"),
                  )
                ],
              ),
            ),
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.shopping_bag),
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("I miei ordini"),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );

    Widget logoutButton = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          ref.read(accountProvider.notifier).logout();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(Icons.logout),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );

    switch (accountStatus) {
      case AccountStatus.notLogged:
        manageMenu = Column();
        logoutButton = Container();
        break;
      case AccountStatus.loggedVerified:
        signinButton = Column();
        loginButton = Column();
        break;
      case AccountStatus.loggedNotVerified:
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(context, '/account/verificaAccount');
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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide())),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("ACCOUNT"),
                            )
                          ]),
                    ),
                    loginButton,
                    signinButton,
                    logoutButton,
                    manageMenu,
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide())),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Text("APP"),
                            )
                          ]),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.privacy_tip),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text("Privacy app"),
                                )
                              ]),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(Icons.settings),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Text("Impostazioni"),
                                )
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
