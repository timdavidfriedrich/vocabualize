import 'package:text_to_speech/text_to_speech.dart';

class TTS {
  static final TextToSpeech _tts = TextToSpeech();

  static speak(String text) async {
    // List<String> languages = await _tts.getLanguages();
    // Log.hint(languages);
    _tts.setLanguage("es-ES"); // TODO: make dynamic
    _tts.speak(text);
  }
}
