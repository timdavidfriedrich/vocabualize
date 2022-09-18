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
          /*
            String _sourceLang = "de";
            String _targetLang = "es";
            bool _enableImages = true;
            int _initialInterval = 1440 * 1;
            int _initialNoviceInterval = 1;
            double _initialEase = 2.5;
            double _easeDowngrade = 0.2;
            double _easyBonus = 1.3;
            double _easyLevelFactor = 0.6;
            double _goodLevelFactor = 0.3;
            double _hardLevelFactor = -0.3;
          */
          SettingsListTile(
            title: const Text("Source language"),
            subtitle: const Text("Your mother tongue."),
            trailing: PopupMenuButton(
              child: const Text("Deutsch"),
              onSelected: (value) => {},
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text("Deutsch")),
              ],
            ),
          ),
          SettingsListTile(
            title: const Text("Target language"),
            subtitle: const Text("The language you learn."),
            trailing: PopupMenuButton(
              child: const Text("Español"),
              onSelected: (value) => {},
              itemBuilder: (context) => [
                const PopupMenuItem(child: Text("Español")),
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
        ],
      ),
    );
  }
}
