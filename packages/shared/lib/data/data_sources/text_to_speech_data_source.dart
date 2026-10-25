import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

const _success = 1;

abstract class TextToSpeechDataSource {
  Future<bool> speak({required String text, required String languageCode});
}

@LazySingleton(as: TextToSpeechDataSource)
class TextToSpeechDataSourceImpl() implements TextToSpeechDataSource {
  final _textToSpeech = FlutterTts();
  String? _languageCode;

  @override
  Future<bool> speak({required String text, required String languageCode}) async {
    if (_languageCode != languageCode) {
      if (await _textToSpeech.setLanguage(languageCode) != _success) return false;
      _languageCode = languageCode;
    }
    await _textToSpeech.stop();
    return await _textToSpeech.speak(text) == _success;
  }
}
