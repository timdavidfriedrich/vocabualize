import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/language/record_speech_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/features/details/screens/details_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';

// TODO ARCHITECTURE: Remove Provider package from MicButton

class MicButton extends ConsumerWidget {
  const MicButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordSpeech = ref.watch(recordSpeechUseCaseProvider);

    // TODO: Create a use case for translate and go to details (maybe in record folder)
    void translateAndProceed(String source) async {
      final translate = ref.read(translateUseCaseProvider);
      await translate(source).then((String target) {
        final draftVocabulary = Vocabulary(
          source: source,
          target: target,
        );
        Navigator.pushNamed(
          context,
          DetailsScreen.routeName,
          arguments: DetailsScreenArguments(vocabulary: draftVocabulary),
        );
      });
    }

    void clicked() async {
      if (await HelperWidgets.isOnline()) {
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
        //height: context.size!.width,
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
