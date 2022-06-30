import 'package:flutter/material.dart';

class MenuBody extends StatelessWidget {
  final Widget child;

  const MenuBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.2))
        ],
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
