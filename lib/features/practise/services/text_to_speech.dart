import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/constants/keys.dart';
import 'package:vocabualize/features/settings/providers/settings_provider.dart';

class TTS {
  static final TextToSpeech _tts = TextToSpeech();

  static speak(String text) async {
    _tts.setLanguage(Provider.of<SettingsProvider>(Keys.context, listen: false).targetLanguage.textToSpeechId);
    _tts.speak(text);
  }
}
