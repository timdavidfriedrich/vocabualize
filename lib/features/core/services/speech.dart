import 'package:vocabualize/constants/common_imports.dart';
import 'package:log/log.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/features/record/providers/active_provider.dart';
import 'package:vocabualize/features/record/services/record_service.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class Speech {
  Speech._privateConstructor() : _stt = SpeechToText();

  static final Speech _instance = Speech._privateConstructor();

  static Speech get instance => _instance;

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
      onError: (error) async {
        Log.error("[STT] ${error.errorMsg}");
        Provider.of<ActiveProvider>(Global.context, listen: false).micIsActive = false;

        _stt.stop;
      },
    );
  }

  Future<void> record() async {
    if (!_available) await init();
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
