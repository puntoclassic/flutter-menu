import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu/widgets/menu_body.dart';

import '../bloc/account_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(AccountInitEvent());

    return BlocConsumer<AccountBloc, AccountState>(builder: (context, state) {
      var mainContent = const Center(
        child: CircularProgressIndicator(),
      );

      if (state is AccountLoginState) {
        if (state.isLogged && state.isVerified) {
          mainContent = const Center(
            child: Text("Sei loggato"),
          );
        } else {
          mainContent = const Center(
            child: Text("Non sei loggato"),
          );
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
                child: mainContent,
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is AccountLoginState) {
        if (state.isLogged == false) {
          Navigator.pushReplacementNamed(context, '/account/login');
        } else {
          if (!state.isVerified) {
            Navigator.pushReplacementNamed(
                context, '/account/verifica-account');
          }
        }
      }
    });
  }
}
