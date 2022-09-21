import 'package:flutter/material.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/home/screens/home.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/translator.dart';

class Speech {
  static final SpeechToText _stt = SpeechToText();
  static String _text = "";

  static void record() async {
    if (!Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive) {
      Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive = true;

      bool available = await _stt.initialize(
        options: [],
        onStatus: (status) async {
          if (_stt.isNotListening && status == "done") {
            Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive = false;

            if (_stt.lastRecognizedWords.isNotEmpty) {
              Messenger.loadingAnimation();
              Vocabulary newVocabulary = Vocabulary(source: _text, target: await Translator.translate(_text));
              await Provider.of<VocabularyProvider>(Keys.context, listen: false).add(newVocabulary).whenComplete(() {
                Navigator.popUntil(Keys.context, ModalRoute.withName(Home.routeName));
                //Messenger.showSaveMessage(newVocabulary);
                Messenger.showAddDetailsDialog(newVocabulary);
              });
            }
            _stt.stop;
          }
        },
        onError: (error) async {
          Log.error("[STT] ${error.errorMsg}");
          Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive = false;

          _stt.stop;
        },
      );

      List<LocaleName> locs = await _stt.locales();
      //for (LocaleName ln in locs) printHint("${ln.localeId} : ${ln.name}");

      if (available) {
        _stt.listen(
          /// TODO: Make it choosable
          /// - Compare STT langs with Translator langs => if both available, show as option
          /// - Maybe custom list? e.g. es : es_AR, es_BO, es_CL, ...
          /// - If not in the list, compare STT letters before underscore with Translator langs
          localeId: locs.firstWhere((element) => element.localeId.startsWith("de")).localeId,
          onResult: (result) => _text = result.recognizedWords,
        );
      }
    } else {
      if (_stt.isListening) _stt.cancel();
      Provider.of<ActiveProvider>(Keys.context, listen: false).micIsActive = false;
    }
  }
}
