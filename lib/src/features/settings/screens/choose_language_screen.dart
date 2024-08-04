import 'package:flutter/material.dart';
import 'package:vocabualize/src/common/models/language.dart';
import 'package:vocabualize/src/common/services/text/language_service.dart';

class ChooseLanguageScreen extends StatelessWidget {
  static const String routeName = "ChooseLanguageScreen";

  const ChooseLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Language>> getLanguages() async {
      return await LanguageService.getLangauges();
    }

    void returnLanguage(Language language) {
      Navigator.pop(context, language);
    }

    ScrollController scrollController = ScrollController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Select Language"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: FutureBuilder<List<Language>>(
              future: getLanguages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                List<Language> languages = snapshot.data ?? [];
                return ListView(
                  controller: scrollController,
                  children: [
                    const SizedBox(height: 16),
                    GridView.count(
                      controller: scrollController,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 1,
                      children: List.generate(
                        languages.length,
                        (index) {
                          return Card(
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              onTap: () => returnLanguage(languages.elementAt(index)),
                              // enabled: selectedLanguage != Provider.of<SettingsProvider>(context, listen: false).sourceLanguage,
                              title: Text(
                                languages.elementAt(index).name,
                                // textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
