import 'package:flutter/material.dart';

class HomeEmpty extends StatelessWidget {
  const HomeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        // TODO: Replace with arb
        "Swipe up to add your first word.",
        textAlign: TextAlign.center,
      ),
    );
  }
}
