import 'package:speech_to_text/speech_to_text.dart';

abstract interface class SpeechToTextRepository {
  Future<List<LocaleName>> getLocales();
  Future<void> record({
    required String sourceSpeechToTextId,
    required Function(String) onResult,
  });
}
