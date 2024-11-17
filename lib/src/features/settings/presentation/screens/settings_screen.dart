import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/features/home/presentation/screens/home_screen.dart';
import 'package:vocabualize/src/features/settings/presentation/controllers/settings_controller.dart';
import 'package:vocabualize/src/features/settings/presentation/states/settings_state.dart';
import 'package:vocabualize/src/features/settings/presentation/widgets/profile_container.dart';
import 'package:vocabualize/src/features/settings/presentation/widgets/settings_list_tile.dart';

class SettingsScreen extends ConsumerWidget {
  static const String routeName = "${HomeScreen.routeName}/Settings";
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(settingsControllerProvider).when(
      loading: () {
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      error: (error, stackTrace) {
        // TODO: Replace with error widget
        return Center(child: Text(error.toString()));
      },
      data: (SettingsState state) {
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text(AppLocalizations.of(context)?.settings_title ?? "", style: Theme.of(context).textTheme.headlineMedium)),
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
                          ref.read(settingsControllerProvider.notifier).selectSourceLanguage(context);
                        },
                        child: Text(state.sourceLanguage.name),
                      ),
                    ),
                    SettingsListTile(
                      title: Text(AppLocalizations.of(context)?.settings_target ?? ""),
                      subtitle: Text(AppLocalizations.of(context)?.settings_targetHint ?? ""),
                      trailing: OutlinedButton(
                        onPressed: () {
                          ref.read(settingsControllerProvider.notifier).selectTargetLanguage(context);
                        },
                        child: Text(state.targetLanguage.name),
                      ),
                    ),
                    SettingsListTile(
                      title: Text(AppLocalizations.of(context)?.settings_images ?? ""),
                      subtitle: Text(AppLocalizations.of(context)?.settings_imagesHint ?? "",
                          style: TextStyle(color: Theme.of(context).hintColor)),
                      trailing: Switch(
                        value: state.areImagesEnabled,
                        onChanged: ref.read(settingsControllerProvider.notifier).setAreImagesEnabled,
                      ),
                    ),
                    SettingsListTile(
                      // TODO: Replace with arb
                      title: const Text("Use DeepL translator"),
                      // TODO: Replace with arb
                      subtitle: Text("Likely to increase translation quality.", style: TextStyle(color: Theme.of(context).hintColor)),
                      trailing: Switch(
                        value: state.usePremiumTranslator,
                        onChanged: ref.read(settingsControllerProvider.notifier).setUsePremiumTranslator,
                      ),
                    ),
                    SettingsListTile(
                      // TODO: Replace with arb
                      title: const Text("Gather notification"),
                      // TODO: Replace with arb
                      subtitle: Text("Time to be reminded to gather words.", style: TextStyle(color: Theme.of(context).hintColor)),
                      trailing: OutlinedButton(
                          onPressed: () {
                            ref.read(settingsControllerProvider.notifier).selectGatherNotificationTime(context);
                          },
                          child: Text("${state.gatherNotificationTime.hour.toString().padLeft(2, '0')}:"
                              "${state.gatherNotificationTime.minute.toString().padLeft(2, '0')}")),
                    ),
                    SettingsListTile(
                      // TODO: Replace with arb
                      title: const Text("Practise notification"),
                      // TODO: Replace with arb
                      subtitle: Text("Time to be reminded to practise.", style: TextStyle(color: Theme.of(context).hintColor)),
                      trailing: OutlinedButton(
                          onPressed: () {
                            ref.read(settingsControllerProvider.notifier).selectPractiseNotificationTime(context);
                          },
                          child: Text("${state.practiseNotificationTime.hour.toString().padLeft(2, '0')}:"
                              "${state.practiseNotificationTime.minute.toString().padLeft(2, '0')}")),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
