import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class TTS {
  TTS._privateConstructor() : _tts = TextToSpeech();

  static final TTS _instance = TTS._privateConstructor();

  static TTS get instance => _instance;

  final TextToSpeech _tts;
  bool isSpeaking = false;

  speak(Vocabulary vocabulary) async {
    _tts.setLanguage(vocabulary.targetLanguage.textToSpeechId);
    isSpeaking = true;
    isSpeaking = await _tts.speak(vocabulary.target) ?? false;
  }

  stop() {
    //_tts.pause();
    _tts.stop();
  }
}
