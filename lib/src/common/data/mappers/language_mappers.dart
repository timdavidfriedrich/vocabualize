import 'package:pocketbase/pocketbase.dart';
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'translatorId': translatorId,
      'speechToTextId': speechToTextId,
      'textToSpeechId': textToSpeechId,
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
    };
  }
}

extension LanguageJsonMappers on Map<String, dynamic> {
  Language toLanguage() {
    return Language(
      id: this['id'] ?? "empty_id",
      name: this['name'],
      translatorId: this['translatorId'],
      speechToTextId: this['speechToTextId'],
      textToSpeechId: this['textToSpeechId'],
      created: this['created'] != null ? DateTime.parse(this['created']) : null,
      updated: this['updated'] != null ? DateTime.parse(this['updated']) : null,
    );
  }
}

extension RecordModelLanguageMappers on RecordModel {
  RdbLanguage toRdbLanguage() {
    return RdbLanguage(
      id: id,
      name: data['name'],
      translatorId: data['translatorId'],
      speechToTextId: data['speechToTextId'],
      textToSpeechId: data['textToSpeechId'],
      created: data['created'],
      updated: data['updated'],
    );
  }
}
