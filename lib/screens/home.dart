import 'package:flutter/material.dart';
import 'package:vocabualize/widgets/micButton.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool micDisabled = false;
  bool textDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Vocabualize",
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48, 0, 48, 64),
        child: Column(
          // physics: const BouncingScrollPhysics(),
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(flex: 3),
            const MicButton(),
            const Spacer(flex: 1),
            TextFormField(
              readOnly: textDisabled,
              decoration: const InputDecoration(hintText: "Type instead"),
            ),
            const Spacer(flex: 4),
            ElevatedButton(
              onPressed: () => print("hi"),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primary,
                  onPrimary: Theme.of(context).colorScheme.onPrimary),
              child: const Text("Practise"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,
                      onPrimary: Theme.of(context).colorScheme.onSecondary),
                  child: const Icon(Icons.settings_outlined),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        onPrimary: Theme.of(context).colorScheme.onSecondary),
                    child: const Text("Collection"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
