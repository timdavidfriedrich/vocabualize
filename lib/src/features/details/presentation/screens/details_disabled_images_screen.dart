import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/use_cases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/start.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/source_to_target.dart';
import 'package:vocabualize/src/features/details/presentation/widgets/tag_wrap.dart';
import 'package:vocabualize/src/features/settings/presentation/screens/settings_screen.dart';

class DetailsDisabledImagesScreen extends ConsumerWidget {
  const DetailsDisabledImagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Vocabulary vocabulary = Vocabulary(source: "", target: "");

    void save() {
      Navigator.pop(Global.context);
    }

    void delete() {
      ref.read(deleteVocabularyUseCaseProvider(vocabulary));
      Navigator.pushNamed(context, Start.routeName);
    }

    void navigateToSettings() async {
      Navigator.pushNamed(context, SettingsScreen.routeName);
    }

    // TODO ARCHITECTURE: What to do with DetailsScreenArguments?
    /*
    SchedulerBinding.instance.addPostFrameCallback((_) {
      DetailsScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;
      setState(() => vocabulary = arguments.vocabulary);
    });
    */

    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: vocabulary.source.isEmpty
              ? const Center(child: CircularProgressIndicator.adaptive())
              : Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: SourceToTarget(vocabulary: vocabulary, isVertical: true)),
                      TagWrap(vocabulary: vocabulary),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12),
                              backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                              foregroundColor: Theme.of(context).colorScheme.error,
                            ),
                            onPressed: () => delete(),
                            child: const Icon(Icons.delete_rounded),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => save(),
                              child: Text(AppLocalizations.of(context)?.record_addDetails_saveButton ?? ""),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => navigateToSettings(),
                        child: Text(
                          // TODO: Replace with arb
                          "Want to add an image? Go to settings.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
