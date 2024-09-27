import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart' as provider;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

final speechToTextDataSourceProvider = Provider((ref) => SpeechToTextDataSource());

// TODO ARCHITECTURE: Remove Provider package and pass default values and settings to the methods

class SpeechToTextDataSource {
  SpeechToTextDataSource() {
    _init();
  }

  final SpeechToText _stt = SpeechToText();
  String _text = "";
  bool _available = false;

  Future<List<LocaleName>> getLocales() async => _available ? await _stt.locales() : [];

  Future<void> _init() async {
    _available = await _stt.initialize(
      options: [],
      onStatus: (status) async {
        if (_stt.isNotListening && status == "done") {
          provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
          if (_stt.lastRecognizedWords.isNotEmpty) {
            // ! URGENT
            // TODO ARCHITECTURE (URGENT): Refactor RecordService
            RecordService().validateAndSave(source: _text);
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

  Future<void> record() async {
    if (!provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive) {
      provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = true;

      if (_available) {
        _stt.listen(
          localeId: provider.Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage.speechToTextId,
          onResult: (result) => _text = result.recognizedWords,
        );
      }
    } else {
      if (_stt.isListening) _stt.cancel();
      provider.Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
    }
  }
}
