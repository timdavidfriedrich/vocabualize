import 'package:log/log.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:vocabualize/features/core/models/language.dart';
import 'package:vocabualize/features/core/models/vocabulary.dart';

class TextToSpeechService {
  TextToSpeechService._privateConstructor() : _tts = TextToSpeech();

  static final TextToSpeechService _instance = TextToSpeechService._privateConstructor();

  static TextToSpeechService get instance => _instance;

  final TextToSpeech _tts;
  bool isSpeaking = false;

  String? _currentLanguage;

  Future<List<String>> getLanguages() async {
    return await _tts.getLanguages();
  }

  Future<void> setLanguage(Language language) async {
    _tts.setLanguage(language.textToSpeechId);
    _currentLanguage = language.textToSpeechId;
  }

  Future<void> speak(Vocabulary vocabulary) async {
    if (_currentLanguage != vocabulary.targetLanguage.textToSpeechId) {
      setLanguage(vocabulary.targetLanguage);
    }
    isSpeaking = true;
    isSpeaking = await _tts.speak(vocabulary.target) ?? false;
  }

  void stop() {
    //_tts.pause();
    _tts.stop();
  }
}
