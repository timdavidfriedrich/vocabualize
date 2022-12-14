import 'package:flutter/material.dart';
import 'package:vocabualize/features/home/screens/home.dart';

class PractiseDone extends StatelessWidget {
  const PractiseDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            text: "Congratulations!\n",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const TextSpan(text: "You finished all of your current words!"),
                        ],
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Home.routeName)),
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
