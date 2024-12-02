import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/features/onboarding/presentation/controllers/choose_languages_controller.dart';
import 'package:vocabualize/src/features/onboarding/presentation/screens/welcome_screen.dart';
import 'package:vocabualize/src/features/onboarding/presentation/states/choose_languages_state.dart';

class ChooseLanguagesScreen extends ConsumerWidget {
  static const String routeName = "${WelcomeScreen.routeName}/ChooseLanguagesScreen";

  const ChooseLanguagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(chooseLanguagesControllerProvider);
    return asyncState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text(error.toString())),
      data: (ChooseLanguagesState state) {
        return SafeArea(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 64),
                    Text(
                      // TODO: Replace with arb
                      "I speak:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        ref.read(chooseLanguagesControllerProvider.notifier).openPickerAndSelectSourceLanguage(context);
                      },
                      child: Text(state.selectedSourceLanguage.name),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      // TODO: Replace with arb
                      "I want to learn:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () {
                        ref.read(chooseLanguagesControllerProvider.notifier).openPickerAndSelectTargetLanguage(context);
                      },
                      child: Text(state.selectedTargetLanguage.name),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(chooseLanguagesControllerProvider.notifier).close(context);
                      },
                      // TODO: Replace with arb
                      child: const Text("Finish"),
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
