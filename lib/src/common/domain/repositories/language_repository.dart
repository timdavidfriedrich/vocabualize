import 'package:vocabualize/src/common/domain/entities/language.dart';

abstract interface class LanguageRepository {
  Future<Language?> findLanguage({String? translatorId, String? speechToTextId, String? textToSpeechId});
  Future<List<Language>> getLangauges({bool? usePremiumTranslator});
}
