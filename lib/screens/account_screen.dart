import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:menu/providers/account_provider.dart';
import 'package:menu/widgets/menu_body.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userIsLogged =
        ref.watch(accountProvider.select((value) => value.userIsLogged));
    var mainContent = const Center(
      child: CircularProgressIndicator(),
    );
    if (userIsLogged) {
      mainContent = const Center(
        child: Text("Sei loggato"),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, '/account/login');
      });
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
  }
}
