import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/src/features/record/presentation/providers/active_provider.dart';

final speechToTextDataSourceProvider = Provider((ref) => SpeechToTextDataSource());

// TODO ARCHITECTURE: Remove ActiveProvider + Provider package, and move this UI to an UI layer

class SpeechToTextDataSource {
  SpeechToTextDataSource() {
    _init();
  }

  final SpeechToText _stt = SpeechToText();
  bool _available = false;

  Future<List<LocaleName>> getLocales() async => _available ? await _stt.locales() : [];

  Future<void> _init() async {
    _available = await _stt.initialize(
      onStatus: (status) async {
        if (_stt.isNotListening && status == "done") {
          provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
          if (_stt.lastRecognizedWords.isNotEmpty) {
            // TODO: Is _stt.lastRecognizedWords.isNotEmpty necessary?
            Log.debug("onStatus Recognized words: ${_stt.lastRecognizedWords}");
          }
          _stt.stop;
        }
      },
      onError: (e) async {
        Log.error("Failed to initialize speech to text service.", exception: e);
        provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;

        _stt.stop;
      },
    );
  }

  Future<void> record({required String sourceSpeechToTextId, required Function(String) onResult}) async {
    if (!provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive) {
      provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = true;

      // ? Braucht man Mic überhaupt?? Man kann ja stt von tastatur nutzen

      if (_available) {
        _stt.listen(
          localeId: sourceSpeechToTextId,
          onResult: (result) {
            if (result.recognizedWords.isEmpty) return;
            if (!result.finalResult) return;
            Log.debug("onResult Recognized words: ${result.recognizedWords}");
            onResult(result.recognizedWords);
          },
        );
      }
    } else {
      if (_stt.isListening) _stt.cancel();
      provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
    }
  }
}
