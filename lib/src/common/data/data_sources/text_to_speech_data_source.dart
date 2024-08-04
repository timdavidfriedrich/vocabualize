import 'package:galli_text_to_speech/text_to_speech.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';

class TextToSpeechDataSource {
  TextToSpeechDataSource._privateConstructor() : _tts = TextToSpeech();

  static final TextToSpeechDataSource _instance = TextToSpeechDataSource._privateConstructor();

  static TextToSpeechDataSource get instance => _instance;

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
    _tts.stop();
  }
}
