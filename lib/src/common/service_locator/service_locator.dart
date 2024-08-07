import 'package:get_it/get_it.dart';
import 'package:vocabualize/src/common/data/data_sources/free_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/premium_translator_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/speech_to_text_data_source.dart';
import 'package:vocabualize/src/common/data/data_sources/text_to_speech_data_source.dart';
import 'package:vocabualize/src/common/data/repositories/language_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/speech_to_text_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/text_to_speech_repository_impl.dart';
import 'package:vocabualize/src/common/data/repositories/translator_repository_impl.dart';
import 'package:vocabualize/src/common/domain/repositories/language_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/speech_to_text_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/text_to_speech_repository.dart';
import 'package:vocabualize/src/common/domain/repositories/translator_repository.dart';
import 'package:vocabualize/src/common/domain/usecases/language/find_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/get_available_languages_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/record_speech_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/set_target_language_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/language/read_out_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_use_case.dart';

Future<void> initializeCommonDependencies(GetIt di) async {
  // * Data sources
  di.registerSingleton<FreeTranslatorDataSource>(FreeTranslatorDataSource());
  di.registerSingleton<PremiumTranslatorDataSource>(PremiumTranslatorDataSource());
  di.registerSingleton<SpeechToTextDataSource>(SpeechToTextDataSource());
  di.registerSingleton<TextToSpeechDataSource>(TextToSpeechDataSource());

  // * Repositories
  di.registerSingleton<LanguageRepository>(LanguageRepositoryImpl());
  di.registerSingleton<SpeechToTextRepository>(SpeechToTextRepositoryImpl());
  di.registerSingleton<TextToSpeechRepository>(TextToSpeechRepositoryImpl());
  di.registerSingleton<TranslatorRepository>(TranslatorRepositoryImpl());

  // * Use cases
  di.registerSingleton<FindLanguageUseCase>(FindLanguageUseCase());
  di.registerSingleton<GetAvailableLanguagesUseCase>(GetAvailableLanguagesUseCase());
  di.registerSingleton<RecordSpeechUseCase>(RecordSpeechUseCase());
  di.registerSingleton<SetTargetLanguageUseCase>(SetTargetLanguageUseCase());
  di.registerSingleton<ReadOutUseCase>(ReadOutUseCase());
  di.registerSingleton<TranslateToEnglishUseCase>(TranslateToEnglishUseCase());
  di.registerSingleton<TranslateUseCase>(TranslateUseCase());
}
