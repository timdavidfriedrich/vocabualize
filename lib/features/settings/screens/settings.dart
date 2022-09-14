import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.42))],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
          child: Scaffold(
            body: ListView(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 96),
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(child: Text("Settings", style: Theme.of(context).textTheme.headlineMedium)),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close_rounded)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
