import 'package:flutter/scheduler.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/firebase/root.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/details/widgets/source_to_target.dart';
import 'package:vocabualize/features/details/widgets/tag_wrap.dart';
import 'package:vocabualize/features/details/services/details_arguments.dart';
import 'package:vocabualize/features/settings/screens/settings_screen.dart';

class DetailsDisabledImagesScreen extends StatefulWidget {
  const DetailsDisabledImagesScreen({super.key});

  @override
  State<DetailsDisabledImagesScreen> createState() => _DetailsDisabledImagesScreenState();
}

class _DetailsDisabledImagesScreenState extends State<DetailsDisabledImagesScreen> {
  Vocabulary vocabulary = Vocabulary(source: "", target: "");

  void _save() {
    Navigator.pop(Global.context);
  }

  void _delete() {
    Provider.of<VocabularyProvider>(context, listen: false).remove(vocabulary);
    Navigator.pushNamed(context, Root.routeName);
  }

  void _navigateToSettings() async {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      DetailsScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;
      setState(() => vocabulary = arguments.vocabulary);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        child: Scaffold(
          body: vocabulary.source.isEmpty
              ? const Center(child: CircularProgressIndicator())
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
                            onPressed: () => _delete(),
                            child: const Icon(Icons.delete_rounded),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => _save(),
                              child: Text(AppLocalizations.of(context)?.record_addDetails_saveButton ?? ""),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () => _navigateToSettings(),
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
