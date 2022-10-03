import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class TTS {
  TTS._privateConstructor() : _tts = TextToSpeech();

  static final TTS _instance = TTS._privateConstructor();

  static TTS get instance => _instance;

  final TextToSpeech _tts;
  bool isSpeaking = false;

  speak(String text) async {
    _tts.setLanguage(Provider.of<SettingsProvider>(Keys.context, listen: false).targetLanguage.textToSpeechId);
    isSpeaking = true;
    isSpeaking = await _tts.speak(text) ?? false;
  }

  stop() {
    //_tts.pause();
    _tts.stop();
  }
}
