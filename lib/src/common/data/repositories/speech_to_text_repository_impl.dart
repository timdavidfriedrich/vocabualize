import 'package:speech_to_text/speech_to_text.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';

class SpeechToTextRepositoryImpl implements SpeechToTextRepository {
  final speechToTextDataSource = sl.get<SpeechToTextDataSource>();

  @override
  Future<List<LocaleName>> getLocales() {
    return speechToTextDataSource.getLocales();
  }

  @override
  Future<void> record() {
    return speechToTextDataSource.record();
  }
}
