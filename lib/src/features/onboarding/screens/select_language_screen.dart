import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/usecases/language/get_available_languages_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class SelectLanguageScreen extends ConsumerWidget {
  static const String routeName = "${WelcomeScreen.routeName}/SelectLanguage";

  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final setTargetLanguage = ref.watch(setTargetLanguageUseCaseProvider);
    final getLanguages = ref.watch(getAvailableLanguagesUseCaseProvider);

    // TODO ARCHITECTURE: Remove Provider package and use Settings Source/Repo/UseCase..

    void submit(BuildContext context) {
      // TODO: Implement usage of signInAnonymously from AuthService
      setTargetLanguage(provider.Provider.of<SettingsProvider>(context, listen: false).targetLanguage);
      Navigator.pop(context);
    }

    return getLanguages.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        // TODO: Replace with error widget and arb
        return Center(child: Text("Error: $error"));
      },
      data: (List<Language> languages) {
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                // TODO: Replace with arb
                title: const Text("Select Language"),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 32),
                    PopupMenuButton(
                      onSelected: (value) => {},
                      itemBuilder: (context) => List.generate(
                        languages.length,
                        (index) {
                          Language selectedLanguage = languages.elementAt(index);
                          return PopupMenuItem(
                            onTap: () {
                              provider.Provider.of<SettingsProvider>(context, listen: false).sourceLanguage = selectedLanguage;
                            },
                            enabled: selectedLanguage != provider.Provider.of<SettingsProvider>(context, listen: false).sourceLanguage,
                            child: Text(selectedLanguage.name),
                          );
                        },
                      ),
                      child: Text(provider.Provider.of<SettingsProvider>(context).sourceLanguage.name),
                    ),
                    const SizedBox(height: 16),
                    PopupMenuButton(
                      onSelected: (value) => {},
                      itemBuilder: (context) => List.generate(
                        languages.length,
                        (index) {
                          Language selectedLanguage = languages.elementAt(index);
                          return PopupMenuItem(
                            onTap: () {
                              provider.Provider.of<SettingsProvider>(context, listen: false).targetLanguage = selectedLanguage;
                            },
                            enabled: selectedLanguage != provider.Provider.of<SettingsProvider>(context, listen: false).targetLanguage,
                            child: Text(selectedLanguage.name),
                          );
                        },
                      ),
                      child: Text(provider.Provider.of<SettingsProvider>(context).targetLanguage.name),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () => submit(context),
                      child: const Text("Save"),
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
