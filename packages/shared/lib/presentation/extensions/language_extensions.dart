import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _flagUnitedKingdom = "🇬🇧";
const _flagUnitedStates = "🇺🇸";
const _flagSpain = "🇪🇸";
const _flagLatinAmerica = "🌎";
const _flagFrance = "🇫🇷";
const _flagCanada = "🇨🇦";
const _flagGermany = "🇩🇪";
const _flagSwitzerland = "🇨🇭";
const _flagPoland = "🇵🇱";
const _flagItaly = "🇮🇹";
const _flagGreece = "🇬🇷";
const _flagRomania = "🇷🇴";
const _flagUnknown = "🏳️";

extension LanguageExtensions on Language {
  String toLabel(BuildContext context) => switch (this) {
    Language.englishUk => context.s.languageEnglishUk,
    Language.englishUs => context.s.languageEnglishUs,
    Language.spanishSpain => context.s.languageSpanishSpain,
    Language.spanishLatinAmerica => context.s.languageSpanishLatinAmerica,
    Language.frenchFrance => context.s.languageFrenchFrance,
    Language.frenchCanada => context.s.languageFrenchCanada,
    Language.germanGermany => context.s.languageGermanGermany,
    Language.germanSwitzerland => context.s.languageGermanSwitzerland,
    Language.polish => context.s.languagePolish,
    Language.italian => context.s.languageItalian,
    Language.greek => context.s.languageGreek,
    Language.romanian => context.s.languageRomanian,
    Language.unknown => context.s.unknown,
  };

  String toFlag() => switch (this) {
    Language.englishUk => _flagUnitedKingdom,
    Language.englishUs => _flagUnitedStates,
    Language.spanishSpain => _flagSpain,
    Language.spanishLatinAmerica => _flagLatinAmerica,
    Language.frenchFrance => _flagFrance,
    Language.frenchCanada => _flagCanada,
    Language.germanGermany => _flagGermany,
    Language.germanSwitzerland => _flagSwitzerland,
    Language.polish => _flagPoland,
    Language.italian => _flagItaly,
    Language.greek => _flagGreece,
    Language.romanian => _flagRomania,
    Language.unknown => _flagUnknown,
  };
}

extension LanguagePairExtensions on LanguagePair {
  String toLabel(BuildContext context) =>
      context.s.languagePairLabel(source.toLabel(context), target.toLabel(context));
}
