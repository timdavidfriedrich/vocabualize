import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:log/log.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/use_cases/language/get_available_languages_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';

class LanguagePickerScreen extends ConsumerWidget {
  static const String routeName = "/LanguagePickerScreen";

  const LanguagePickerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getAvailableLanguages =
        ref.watch(getAvailableLanguagesUseCaseProvider);

    void returnLanguage(Language language) {
      context.pop(language);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // TODO: Replace with arb
          title: const Text("Select Language"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.mediumSpacing,
          ),
          child: getAvailableLanguages.when(
            loading: () {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
            error: (error, stackTrace) {
              Log.error(
                "Error LanguagePickerScreen: $error",
                exception: stackTrace,
              );
              // TODO: Replace with error widget
              return const Text("Error LanguagePickerScreen");
            },
            data: (List<Language> languages) {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: Dimensions.mediumSpacing,
                  bottom: Dimensions.scrollEndSpacing,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: languages.length == 1 ? 1 : 2,
                  childAspectRatio: 2 / 1,
                ),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  return _LanguageCard(
                    language: languages.elementAt(index),
                    onClick: returnLanguage,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  final Language language;
  final void Function(Language) onClick;
  const _LanguageCard({
    required this.language,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        // ? enabled: languages.elementAt(index) != selectedLanguage,
        onTap: () {
          onClick(language);
        },
        titleAlignment: ListTileTitleAlignment.center,
        title: Text(language.name),
      ),
    );
  }
}
