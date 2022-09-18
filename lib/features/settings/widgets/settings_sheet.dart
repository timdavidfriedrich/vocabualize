import 'package:flutter/material.dart';
import 'package:vocabualize/features/settings/widgets/settings_list_tile.dart';

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
          const SizedBox(height: 12),
          SettingsListTile(
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
          SettingsListTile(
            title: const Text("Words have images"),
            subtitle: Text(
              /* "If disabled, all images will be hidden."*/ "Enable for better learning.",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            trailing: Switch(
              value: true,
              onChanged: (value) => {},
            ),
          ),
          SettingsListTile(
            title: Text("Hi"),
            //subtitle: Text("Buenos días!"),
            trailing: Switch(
              value: false,
              onChanged: (value) => {},
            ),
          )
        ],
      ),
    );
  }
}
