import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';

class TTS {
  TTS._privateConstructor() : _tts = TextToSpeech();

  static final TTS _instance = TTS._privateConstructor();

  static TTS get instance => _instance;

  final TextToSpeech _tts;
  bool isSpeaking = false;

  Future<List<String>> getLanguages() async {
    return await _tts.getLanguages();
  }

  Future<void> setLanguage(Language language) async {
    _tts.setLanguage(language.textToSpeechId);
  }

  Future<void> speak(Vocabulary vocabulary) async {
    isSpeaking = true;
    isSpeaking = await _tts.speak(vocabulary.target) ?? false;
  }

  void stop() {
    //_tts.pause();
    _tts.stop();
  }
}
