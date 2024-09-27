import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/src/features/settings/screens/choose_language_screen.dart';
import 'package:vocabualize/src/features/settings/widgets/profile_container.dart';
import 'package:vocabualize/src/features/settings/widgets/settings_list_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const String routeName = "${HomeScreen.routeName}/Settings";

  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future<TimeOfDay?> timeFromTimePicker() async {
      final TimeOfDay? timeOfDay = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      return timeOfDay;
    }

    void selectGatherNotificationTime() async {
      TimeOfDay? time = await timeFromTimePicker();
      if (time == null || !context.mounted) return;
      provider.Provider.of<SettingsProvider>(context, listen: false).gatherNotificationTime = time;
    }

    void selectPractiseNotificationTime() async {
      TimeOfDay? time = await timeFromTimePicker();
      if (time == null || !context.mounted) return;
      provider.Provider.of<SettingsProvider>(context, listen: false).practiseNotificationTime = time;
    }

    Future<Language?> selectLanguage() async {
      return await Navigator.pushNamed(context, ChooseLanguageScreen.routeName) as Language?;
    }

    SettingsProvider settings = provider.Provider.of<SettingsProvider>(context, listen: false);
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar:
              AppBar(title: Text(AppLocalizations.of(context)?.settings_title ?? "", style: Theme.of(context).textTheme.headlineMedium)),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const SizedBox(height: 16),
                const ProfileContainer(),
                const SizedBox(height: 16),
                SettingsListTile(
                  title: Text(AppLocalizations.of(context)?.settings_source ?? ""),
                  subtitle: Text(AppLocalizations.of(context)?.settings_sourceHint ?? ""),
                  trailing: OutlinedButton(
                    onPressed: () async {
                      settings.sourceLanguage = await selectLanguage() ?? settings.sourceLanguage;
                    },
                    child: Text(settings.sourceLanguage.name),
                  ),
                ),
                SettingsListTile(
                  title: Text(AppLocalizations.of(context)?.settings_target ?? ""),
                  subtitle: Text(AppLocalizations.of(context)?.settings_targetHint ?? ""),
                  trailing: OutlinedButton(
                    onPressed: () async {
                      settings.targetLanguage = await selectLanguage() ?? settings.targetLanguage;
                    },
                    child: Text(settings.targetLanguage.name),
                  ),
                ),
                SettingsListTile(
                  title: Text(AppLocalizations.of(context)?.settings_images ?? ""),
                  subtitle:
                      Text(AppLocalizations.of(context)?.settings_imagesHint ?? "", style: TextStyle(color: Theme.of(context).hintColor)),
                  trailing: Switch(
                    value: provider.Provider.of<SettingsProvider>(context).areImagesEnabled,
                    onChanged: (value) {
                      provider.Provider.of<SettingsProvider>(context, listen: false).areImagesEnabled = value;
                    },
                  ),
                ),
                SettingsListTile(
                  // TODO: Replace with arb
                  title: const Text("Use DeepL translator"),
                  // TODO: Replace with arb
                  subtitle: Text("Likely to increase translation quality.", style: TextStyle(color: Theme.of(context).hintColor)),
                  trailing: Switch(
                    value: provider.Provider.of<SettingsProvider>(context).usePremiumTranslator,
                    onChanged: (value) {
                      provider.Provider.of<SettingsProvider>(context, listen: false).usePremiumTranslator = value;
                    },
                  ),
                ),
                SettingsListTile(
                  // TODO: Replace with arb
                  title: const Text("Gather notification"),
                  // TODO: Replace with arb
                  subtitle: Text("Time to be reminded to gather words.", style: TextStyle(color: Theme.of(context).hintColor)),
                  trailing: OutlinedButton(
                      onPressed: () => selectGatherNotificationTime(),
                      child: Text(
                          "${provider.Provider.of<SettingsProvider>(context).gatherNotificationTime.hour.toString().padLeft(2, '0')}:"
                          "${provider.Provider.of<SettingsProvider>(context).gatherNotificationTime.minute.toString().padLeft(2, '0')}")),
                ),
                SettingsListTile(
                  // TODO: Replace with arb
                  title: const Text("Practise notification"),
                  // TODO: Replace with arb
                  subtitle: Text("Time to be reminded to practise.", style: TextStyle(color: Theme.of(context).hintColor)),
                  trailing: OutlinedButton(
                      onPressed: () => selectPractiseNotificationTime(),
                      child: Text(
                          "${provider.Provider.of<SettingsProvider>(context).practiseNotificationTime.hour.toString().padLeft(2, '0')}:"
                          "${provider.Provider.of<SettingsProvider>(context).practiseNotificationTime.minute.toString().padLeft(2, '0')}")),
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
