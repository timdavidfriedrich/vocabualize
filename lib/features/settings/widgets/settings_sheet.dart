import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/services/language.dart';
import 'package:vocabualize/features/core/services/languages.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/features/settings/widgets/settings_list_tile.dart';

class SettingsSheet extends StatefulWidget {
  const SettingsSheet({Key? key}) : super(key: key);

  @override
  State<SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<SettingsSheet> {
  List<Language> languages = [];

  _getLanguages() async {
    languages = await Languages.getLangauges();
  }

  @override
  void initState() {
    super.initState();
    _getLanguages();
  }

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
            title: const Text("Source language"),
            subtitle: const Text("Your mother tongue."),
            trailing: PopupMenuButton(
              onSelected: (value) => {},
              itemBuilder: (context) => List.generate(
                languages.length,
                (index) {
                  Language selectedLanguage = languages.elementAt(index);
                  return PopupMenuItem(
                    onTap: () => Provider.of<SettingsProvider>(context, listen: false).sourceLanguage = selectedLanguage,
                    enabled: selectedLanguage != Provider.of<SettingsProvider>(context, listen: false).sourceLanguage,
                    child: Text(selectedLanguage.name),
                  );
                },
              ),
              child: Text(Provider.of<SettingsProvider>(context).sourceLanguage.name),
            ),
          ),
          SettingsListTile(
            title: const Text("Target language"),
            subtitle: const Text("The language you learn."),
            trailing: PopupMenuButton(
              padding: const EdgeInsets.all(128),
              itemBuilder: (context) => List.generate(
                languages.length,
                (index) {
                  Language selectedLanguage = languages.elementAt(index);
                  return PopupMenuItem(
                    onTap: () => Provider.of<SettingsProvider>(context, listen: false).targetLanguage = selectedLanguage,
                    enabled: selectedLanguage != Provider.of<SettingsProvider>(context, listen: false).targetLanguage,
                    child: Text(selectedLanguage.name),
                  );
                },
              ),
              child: Text(Provider.of<SettingsProvider>(context).targetLanguage.name),
            ),
          ),
          SettingsListTile(
            title: const Text("Words have images"),
            subtitle: Text(
              /* "If disabled, all images will be hidden."*/ "Enable for better learning.",
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            trailing: Switch(
              value: Provider.of<SettingsProvider>(context).areImagesEnabled,
              onChanged: (value) {
                Provider.of<SettingsProvider>(context, listen: false).areImagesEnabled = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
