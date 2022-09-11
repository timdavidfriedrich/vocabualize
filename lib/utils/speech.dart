import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/utils/logging.dart';
import 'package:vocabualize/utils/messenger.dart';
import 'package:vocabualize/utils/providers/active_provider.dart';
import 'package:vocabualize/utils/providers/voc_provider.dart';
import 'package:vocabualize/utils/translator.dart';

class Speech {
  static final SpeechToText _stt = SpeechToText();
  static String _text = "";

  static void record(BuildContext context) async {
    if (!Provider.of<ActiveProv>(context, listen: false).getMicIsActive()) {
      Provider.of<ActiveProv>(context, listen: false).setMicIsActive(true);

      bool available = await _stt.initialize(
        options: [],
        onStatus: (status) async {
          if (_stt.isNotListening && status == "done") {
            Provider.of<ActiveProv>(context, listen: false).setMicIsActive(false);

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
          Provider.of<ActiveProv>(context, listen: false).setMicIsActive(false);

          _stt.stop;
        },
      );

      List<LocaleName> locs = await _stt.locales();
      for (LocaleName ln in locs) printHint("${ln.localeId} : ${ln.name}");

      if (available) {
        _stt.listen(
          /// TODO: Make it choosable
          /// - Compare STT langs with Translator langs => if both available, show as option
          /// - Maybe custom list? e.g. es : es_AR, es_BO, es_CL, ...
          /// - If not in the list, compare STT letters before underscore with Translator langs
          localeId: locs[1].localeId,
          onResult: (result) => _text = result.recognizedWords,
        );
      }
    }
  }
}
