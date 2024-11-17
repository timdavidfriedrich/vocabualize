import 'package:flutter/material.dart';

class PractiseDoneScreen extends StatelessWidget {
  const PractiseDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void done() {
      Navigator.pop(context);
    }

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            // TODO: Replace with arb
                            text: "Congratulations!\n",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          // TODO: Replace with arb
                          const TextSpan(text: "You finished all of your current words!"),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => done(),
                  // TODO: Replace with arb
                  child: const Text("Main menu"),
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
