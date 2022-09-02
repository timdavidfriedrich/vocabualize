import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vocabualize/screens/home.dart';
import 'package:vocabualize/utils/teleport.dart';

class PractiseDone extends StatelessWidget {
  const PractiseDone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
        child: Column(
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
              // change pop to pushReplace (fix collection grow)
              onPressed: () => Navigator.pop(
                context,
                //Teleport(child: const Home(), type: "fade"),
              ),
              style: ElevatedButton.styleFrom(primary: Theme.of(context).colorScheme.surface, onPrimary: Theme.of(context).colorScheme.onSurface),
              child: const Text("Main menu"),
            ),
            const SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}
