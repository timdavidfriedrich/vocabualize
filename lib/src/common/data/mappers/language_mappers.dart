import 'package:vocabualize/src/common/data/models/rdb_language.dart';
import 'package:vocabualize/src/common/domain/entities/language.dart';

extension RdbLanguageMappers on RdbLanguage {
  Language toLanguage() {
    return Language(
      id: id,
      name: name,
      translatorId: translatorId,
      speechToTextId: speechToTextId,
      textToSpeechId: textToSpeechId,
    );
  }
}

extension LanguageMappers on Language {
  RdbLanguage toRdbLanguage() {
    return RdbLanguage(
      id: id,
      name: name,
      translatorId: translatorId,
      speechToTextId: speechToTextId,
      textToSpeechId: textToSpeechId,
    );
  }
}
