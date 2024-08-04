import 'package:avatar_glow/avatar_glow.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/src/common/services/messaging_service.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';
import 'package:vocabualize/src/common/services/text/speech_to_text_service.dart';

class MicButton extends StatelessWidget {
  const MicButton({Key? key}) : super(key: key);

  _clicked() async {
    if (await MessangingService.isOnline()) SpeechToTextService.instance.record();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: MaterialButton(
        padding: const EdgeInsets.all(0),
        onPressed: () => _clicked(),
        //height: context.size!.width,
        color: Provider.of<ActiveProvider>(context).micIsActive ? Theme.of(context).colorScheme.onPrimary : null,
        shape: CircleBorder(side: BorderSide(width: 8, color: Theme.of(context).colorScheme.onPrimary)),
        child: AvatarGlow(
          animate: Provider.of<ActiveProvider>(context).micIsActive,
          endRadius: MediaQuery.of(context).size.width / 2,
          repeat: true,
          repeatPauseDuration: Duration.zero,
          duration: const Duration(milliseconds: 2500),
          startDelay: Duration.zero,
          showTwoGlows: true,
          curve: Curves.fastOutSlowIn,
          glowColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Provider.of<ActiveProvider>(context).micIsActive ? Icons.mic_rounded : Icons.mic_none_rounded,
            color: Provider.of<ActiveProvider>(context).micIsActive
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onPrimary,
            size: 128,
          ),
        ),
      ),
    );
  }
}
