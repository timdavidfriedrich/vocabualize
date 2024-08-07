import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/usecases/language/get_available_languages_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/features/onboarding/screens/welcome_screen.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class SelectLanguageScreen extends StatefulWidget {
  static const String routeName = "${WelcomeScreen.routeName}/SelectLanguage";

  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() => SelectLanguageScreenState();
}

class SelectLanguageScreenState extends State<SelectLanguageScreen> {
  final setTargetLanguage = sl.get<SetTargetLanguageUseCase>();
  final getLanguages = sl.get<GetAvailableLanguagesUseCase>();

  List<Language> languages = [];

  void _getLanguages() async {
    languages = await getLanguages();
  }

  void _submit(BuildContext context) {
    // TODO: Implement usage of signInAnonymously from AuthService
    // if (AuthService.instance.user == null) AuthService.instance.signInAnonymously();
    setTargetLanguage(Provider.of<SettingsProvider>(context, listen: false).targetLanguage);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _getLanguages();
  }

  @override
  Widget build(BuildContext context) {
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
                        onTap: () => Provider.of<SettingsProvider>(context, listen: false).sourceLanguage = selectedLanguage,
                        enabled: selectedLanguage != Provider.of<SettingsProvider>(context, listen: false).sourceLanguage,
                        child: Text(selectedLanguage.name),
                      );
                    },
                  ),
                  child: Text(Provider.of<SettingsProvider>(context).sourceLanguage.name),
                ),
                const SizedBox(height: 16),
                PopupMenuButton(
                  onSelected: (value) => {},
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
                const Spacer(),
                ElevatedButton(
                  onPressed: () => _submit(context),
                  child: const Text("Save"),
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
