import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/models/local_language_pair_setting.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _codeEnglish = "en";
const _codeGerman = "de";
const _codeSpanish = "es";
const _codeFrench = "fr";
const _codePolish = "pl";
const _codeItalian = "it";
const _codeGreek = "el";
const _codeRomanian = "ro";
const _codeUndetermined = "und";

extension LanguageCodeMappers on String {
  Language toLanguage() => switch (this) {
    _codeEnglish => Language.english,
    _codeGerman => Language.german,
    _codeSpanish => Language.spanish,
    _codeFrench => Language.french,
    _codePolish => Language.polish,
    _codeItalian => Language.italian,
    _codeGreek => Language.greek,
    _codeRomanian => Language.romanian,
    _ => Language.unknown,
  };
}

extension LanguageMappers on Language {
  String toLanguageCode() => switch (this) {
    Language.english => _codeEnglish,
    Language.german => _codeGerman,
    Language.spanish => _codeSpanish,
    Language.french => _codeFrench,
    Language.polish => _codePolish,
    Language.italian => _codeItalian,
    Language.greek => _codeGreek,
    Language.romanian => _codeRomanian,
    Language.unknown => _codeUndetermined,
  };
}

extension LocalLanguagePairSettingMappers on LocalLanguagePairSetting {
  LanguagePair? toLanguagePair() {
    return switch ((source.toLanguage(), target.toLanguage())) {
      (Language.unknown, _) || (_, Language.unknown) => null,
      (final source, final target) => LanguagePair(source: source, target: target),
    };
  }
}

extension LanguagePairMappers on LanguagePair {
  LocalLanguagePairSetting toLocalLanguagePairSetting() {
    return LocalLanguagePairSetting(
      source: source.toLanguageCode(),
      target: target.toLanguageCode(),
    );
  }
}

extension LocalSettingLanguagePairMappers on LocalSetting {
  LanguagePair? toLanguagePair() {
    try {
      return LocalLanguagePairSettingMapper.fromJson(value).toLanguagePair();
    } on MapperException {
      return null;
    }
  }
}
