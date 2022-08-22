import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vocabualize"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(64, 0, 64, 0),
        child: Column(
          // physics: const BouncingScrollPhysics(),
          children: [
            const Spacer(flex: 3),
            MaterialButton(
              height: 256,
              onPressed: () {},
              shape: const CircleBorder(
                side: BorderSide(
                  width: 8,
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.mic_none_rounded,
                color: Colors.white,
                size: 128,
              ),
            ),
            const Spacer(flex: 1),
            const TextField(
              decoration: InputDecoration(hintText: "Type instead"),
            ),
            const Spacer(flex: 3),
            TextButton(
              onPressed: () {},
              child: const Text("Practise"),
            ),
            const Spacer(flex: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Collection"),
                ),
              ],
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
