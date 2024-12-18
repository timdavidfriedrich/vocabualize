import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_source_language_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/settings/get_target_language_use_case.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
import 'package:vocabualize/src/features/record/domain/use_cases/speech_to_text/record_speech_use_case.dart';
import 'package:vocabualize/src/common/domain/use_cases/translator/translate_use_case.dart';
import 'package:vocabualize/src/features/details/presentation/screens/details_screen.dart';
import 'package:vocabualize/src/features/record/presentation/controllers/record_controller.dart';
import 'package:vocabualize/src/features/record/presentation/providers/active_provider.dart';

// TODO: Remove ActiveProvider package from MicButton
// TODO: Create RecordController and move functions to this reuse them in TypeButton

class MicButton extends ConsumerWidget {
  const MicButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordSpeech = ref.watch(recordSpeechUseCaseProvider);

    // TODO: Create a use case for translate and go to details (maybe in record folder)
    void translateAndProceed(String source) async {
      final translate = ref.read(translateUseCaseProvider);
      final sourceLanguage = await ref.read(getSourceLanguageUseCaseProvider);
      final targetLanguage = await ref.read(getTargetLanguageUseCaseProvider);
      await translate(source).then((String target) {
        final draftVocabulary = Vocabulary(
          source: source,
          target: target,
          sourceLanguageId: sourceLanguage.id,
          targetLanguageId: targetLanguage.id,
        );
        context.pushNamed(
          DetailsScreen.routeName,
          arguments: DetailsScreenArguments(vocabulary: draftVocabulary),
        );
      });
    }

    void clicked() async {
      if (!await ref.read(recordControllerProvider.notifier).isOnlineAndShowDialogIfNot(context)) {
        recordSpeech(
          onResult: translateAndProceed,
        );
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => clicked(),
        color: provider.Provider.of<ActiveProvider>(context).micIsActive ? Theme.of(context).colorScheme.onPrimary : null,
        shape: CircleBorder(side: BorderSide(width: 8, color: Theme.of(context).colorScheme.onPrimary)),
        child: AvatarGlow(
          animate: provider.Provider.of<ActiveProvider>(context).micIsActive,
          endRadius: MediaQuery.of(context).size.width / 2,
          repeat: true,
          repeatPauseDuration: Duration.zero,
          duration: const Duration(milliseconds: 2500),
          startDelay: Duration.zero,
          showTwoGlows: true,
          curve: Curves.fastOutSlowIn,
          glowColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            provider.Provider.of<ActiveProvider>(context).micIsActive ? Icons.mic_rounded : Icons.mic_none_rounded,
            color: provider.Provider.of<ActiveProvider>(context).micIsActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
            size: 128,
          ),
        ),
      ),
    );
  }
}
