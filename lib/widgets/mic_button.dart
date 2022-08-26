import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/utils/logging.dart';
import 'package:vocabualize/utils/messenger.dart';
import 'package:vocabualize/utils/providers/visible_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/translator.dart';

class MicButton extends StatefulWidget {
  const MicButton({Key? key}) : super(key: key);

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  late SpeechToText _stt;
  String _text = "";

  void _record() async {
    if (!Provider.of<VisibleProv>(context, listen: false).getMicIsActive()) {
      Provider.of<VisibleProv>(context, listen: false).setMicIsActive(true);
      bool available = await _stt.initialize(
        onStatus: (status) async {
          if (_stt.isNotListening && status == "done") {
            Provider.of<VisibleProv>(context, listen: false).setMicIsActive(false);
            if (_stt.lastRecognizedWords.isNotEmpty) {
              Messenger.loadingAnimation(context);
              Provider.of<VocProv>(context, listen: false)
                  .addToVocabularyList(Vocabulary(source: _text, target: await Translator.translate(context, _text)))
                  .whenComplete(
                () {
                  Navigator.pop(context);
                  Messenger.saveMessage(context, _text);
                },
              );
            }
            _stt.stop;
          }
        },
        onError: (error) async {
          printError("[STT] ${error.errorMsg}");
          Provider.of<VisibleProv>(context, listen: false).setMicIsActive(false);
          _stt.stop;
        },
      );
      if (available) {
        _stt.listen(
          onResult: (text) => setState(() => _text = text.recognizedWords),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _stt = SpeechToText();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _record,
      child: Container(
        height: Provider.of<VisibleProv>(context).getTypeIsActive() ? 0 : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Provider.of<VisibleProv>(context).getMicIsActive()
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(width: 8, color: Theme.of(context).colorScheme.secondary)),
        child: AvatarGlow(
          animate: Provider.of<VisibleProv>(context).getMicIsActive(),
          endRadius: MediaQuery.of(context).size.width / 2,
          repeat: true,
          repeatPauseDuration: Duration.zero,
          duration: const Duration(milliseconds: 2500),
          startDelay: Duration.zero,
          showTwoGlows: true,
          curve: Curves.fastOutSlowIn,
          glowColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Provider.of<VisibleProv>(context).getMicIsActive() ? Icons.mic_rounded : Icons.mic_none_rounded,
            color: Provider.of<VisibleProv>(context).getTypeIsActive()
                ? Colors.transparent
                : Provider.of<VisibleProv>(context).getMicIsActive()
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.secondary,
            size: 128,
          ),
        ),
      ),
    );
  }
}
