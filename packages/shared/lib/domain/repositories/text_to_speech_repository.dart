import 'package:core/error/app_result.dart';

abstract class TextToSpeechRepository {
  Future<AppResult<()>> speak({required String text, required String languageCode});
}
