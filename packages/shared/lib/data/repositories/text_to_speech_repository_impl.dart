import 'package:core/error/app_error.dart';
import 'package:core/error/app_result.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/data/data_sources/text_to_speech_data_source.dart';
import 'package:shared/data/extensions/error_extensions.dart';
import 'package:shared/domain/repositories/text_to_speech_repository.dart';

@Injectable(as: TextToSpeechRepository)
class const TextToSpeechRepositoryImpl(
  final TextToSpeechDataSource _dataSource,
) implements TextToSpeechRepository {
  @override
  Future<AppResult<()>> speak({required String text, required String languageCode}) async {
    try {
      final isSpoken = await _dataSource.speak(text: text, languageCode: languageCode);
      return isSpoken ? const Success(()) : const Failure(TextToSpeechUnavailableError());
    } on Object catch (error) {
      return Failure(error.toAppError());
    }
  }
}
