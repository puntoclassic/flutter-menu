import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/bloc/account_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listenWhen: (previous, current) => current is AccountStatusUpdatedState,
      listener: (context, state) {
        if (state is AccountStatusUpdatedState) {
          final accountStatus = state.accountStatus;

          if (accountStatus == AccountStatus.loggedNotVerified) {
            Navigator.pushReplacementNamed(context, '/account/verificaAccount');
          }
        }
      },
      builder: (context, state) {
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
              decoration:
                  const BoxDecoration(border: Border(bottom: BorderSide())),
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
              context.read<AccountBloc>().add(AccountLogoutRequestEvent());
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

        if (state is AccountStatusUpdatedState) {
          final accountStatus = state.accountStatus;

          if (accountStatus == AccountStatus.logged) {
            manageMenu = Column();
            logoutButton = Container();
          } else {
            signinButton = Column();
            loginButton = Column();
          }
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
      },
    );
  }
}
