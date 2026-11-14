import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/text_to_speech_data_source.dart';

const _success = 1;

@LazySingleton(as: TextToSpeechDataSource)
class TextToSpeechDataSourceImpl() implements TextToSpeechDataSource {
  final _textToSpeech = FlutterTts();
  final _availableLanguageCodes = <String, String?>{};
  String? _languageCode;

  @override
  Future<bool> speak({required String text, required List<String> languageCodes}) async {
    final languageCode = await _availableLanguageCode(languageCodes);
    if (languageCode == null) return false;
    if (_languageCode != languageCode) {
      if (await _textToSpeech.setLanguage(languageCode) != _success) return false;
      _languageCode = languageCode;
    }
    await _textToSpeech.stop();
    return await _textToSpeech.speak(text) == _success;
  }

  Future<String?> _availableLanguageCode(List<String> candidates) async {
    if (candidates.isEmpty) return null;
    final key = candidates.join();
    if (_availableLanguageCodes.containsKey(key)) return _availableLanguageCodes[key];
    String? available;
    for (final candidate in candidates) {
      if (await _textToSpeech.isLanguageAvailable(candidate) == true) {
        available = candidate;
        break;
      }
    }
    return _availableLanguageCodes[key] = available;
  }
}
