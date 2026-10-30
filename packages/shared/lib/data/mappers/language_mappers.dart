import 'package:dart_mappable/dart_mappable.dart';
import 'package:shared/data/models/local_language_pair_setting.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:vocabualize_client/vocabualize_client.dart';

const _tagEnglishUk = "en-GB";
const _tagEnglishUs = "en-US";
const _tagSpanishSpain = "es-ES";
const _tagSpanishLatinAmerica = "es-419";
const _tagFrenchFrance = "fr-FR";
const _tagFrenchCanada = "fr-CA";
const _tagGermanGermany = "de-DE";
const _tagGermanSwitzerland = "de-CH";
const _tagPolish = "pl";
const _tagItalian = "it";
const _tagGreek = "el";
const _tagRomanian = "ro";
const _tagUndetermined = "und";
const _rootEnglish = "en";
const _rootSpanish = "es";
const _rootFrench = "fr";
const _rootGerman = "de";
const _speechSpanishUnitedStates = "es-US";
const _speechSpanishMexico = "es-MX";
const _speechPolish = "pl-PL";
const _speechItalian = "it-IT";
const _speechGreek = "el-GR";
const _speechRomanian = "ro-RO";
const _tagSeparator = "-";
const _localeSeparator = "_";

extension LanguageCodeMappers on String {
  Language toLanguage() => switch (replaceAll(_localeSeparator, _tagSeparator)) {
    _tagEnglishUk => Language.englishUk,
    _tagEnglishUs => Language.englishUs,
    _tagSpanishSpain => Language.spanishSpain,
    _tagSpanishLatinAmerica => Language.spanishLatinAmerica,
    _tagFrenchFrance => Language.frenchFrance,
    _tagFrenchCanada => Language.frenchCanada,
    _tagGermanGermany => Language.germanGermany,
    _tagGermanSwitzerland => Language.germanSwitzerland,
    final tag => switch (tag.split(_tagSeparator).first.toLowerCase()) {
      _rootEnglish => Language.englishUs,
      _rootSpanish => Language.spanishSpain,
      _rootFrench => Language.frenchFrance,
      _rootGerman => Language.germanGermany,
      _tagPolish => Language.polish,
      _tagItalian => Language.italian,
      _tagGreek => Language.greek,
      _tagRomanian => Language.romanian,
      _ => Language.unknown,
    },
  };
}

extension LanguageMappers on Language {
  String toLanguageCode() => switch (this) {
    Language.englishUk => _tagEnglishUk,
    Language.englishUs => _tagEnglishUs,
    Language.spanishSpain => _tagSpanishSpain,
    Language.spanishLatinAmerica => _tagSpanishLatinAmerica,
    Language.frenchFrance => _tagFrenchFrance,
    Language.frenchCanada => _tagFrenchCanada,
    Language.germanGermany => _tagGermanGermany,
    Language.germanSwitzerland => _tagGermanSwitzerland,
    Language.polish => _tagPolish,
    Language.italian => _tagItalian,
    Language.greek => _tagGreek,
    Language.romanian => _tagRomanian,
    Language.unknown => _tagUndetermined,
  };

  List<String> toSpeechLanguageCodes() => switch (this) {
    Language.englishUk => const [_tagEnglishUk, _rootEnglish],
    Language.englishUs => const [_tagEnglishUs, _rootEnglish],
    Language.spanishSpain => const [_tagSpanishSpain, _rootSpanish],
    Language.spanishLatinAmerica => const [
      _speechSpanishUnitedStates,
      _speechSpanishMexico,
      _rootSpanish,
    ],
    Language.frenchFrance => const [_tagFrenchFrance, _rootFrench],
    Language.frenchCanada => const [_tagFrenchCanada, _rootFrench],
    Language.germanGermany => const [_tagGermanGermany, _rootGerman],
    Language.germanSwitzerland => const [_tagGermanSwitzerland, _tagGermanGermany, _rootGerman],
    Language.polish => const [_speechPolish, _tagPolish],
    Language.italian => const [_speechItalian, _tagItalian],
    Language.greek => const [_speechGreek, _tagGreek],
    Language.romanian => const [_speechRomanian, _tagRomanian],
    Language.unknown => const [],
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
