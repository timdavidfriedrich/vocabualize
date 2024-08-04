import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';

class SpeechToTextDataSource {
  SpeechToTextDataSource._privateConstructor() : _stt = SpeechToText();

  static final SpeechToTextDataSource _instance = SpeechToTextDataSource._privateConstructor();

  static SpeechToTextDataSource get instance => _instance;

  final SpeechToText _stt;
  String _text = "";
  bool _available = false;

  Future<List<LocaleName>> getLocales() async => _available ? await _stt.locales() : [];

  Future<void> init() async {
    _available = await _stt.initialize(
      options: [],
      onStatus: (status) async {
        if (_stt.isNotListening && status == "done") {
          Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
          if (_stt.lastRecognizedWords.isNotEmpty) {
            RecordService.validateAndSave(source: _text);
          }
          _stt.stop;
        }
      },
      onError: (e) async {
        Log.error("Failed to initialize speech to text service.", exception: e);
        Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;

        _stt.stop;
      },
    );
  }

  Future<void> record() async {
    if (!Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive) {
      Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = true;

      if (_available) {
        _stt.listen(
          localeId: Provider.of<SettingsProvider>(Global.context, listen: false).sourceLanguage.speechToTextId,
          onResult: (result) => _text = result.recognizedWords,
        );
      }
    } else {
      if (_stt.isListening) _stt.cancel();
      Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;
    }
  }
}
