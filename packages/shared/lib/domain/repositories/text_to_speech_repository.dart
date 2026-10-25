import 'package:core/error/app_result.dart';
import 'package:shared/domain/entities/language.dart';

abstract class TextToSpeechRepository {
  Future<AppResult<()>> speak({required String text, required Language language});
}
