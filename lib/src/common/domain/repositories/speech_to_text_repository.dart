import 'package:speech_to_text/speech_to_text.dart';

abstract interface class SpeechToTextRepository {
  Future<List<LocaleName>> getLocales();
  Future<void> record();
}
