import 'package:flutter/material.dart';

class SettingsSheet extends StatelessWidget {
  const SettingsSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(48, 0, 48, 0),
      color: Theme.of(context).colorScheme.surface,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 48),
          Text("Settings", style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 48),
          ListTile(
            title: Text("My language"),
            trailing: PopupMenuButton(
              child: Text("Hui"),
              onSelected: (value) => {},
              itemBuilder: (context) => [
                PopupMenuItem(child: Text("Hihihi")),
                PopupMenuItem(child: Text("Hihihi")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
