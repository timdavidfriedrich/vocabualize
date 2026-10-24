import 'package:flutter/widgets.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

extension LanguageExtensions on Language {
  String toLabel(BuildContext context) => switch (this) {
    Language.english => context.s.languageEnglish,
    Language.german => context.s.languageGerman,
    Language.spanish => context.s.languageSpanish,
    Language.french => context.s.languageFrench,
    Language.polish => context.s.languagePolish,
    Language.unknown => context.s.unknown,
  };
}

extension LanguagePairExtensions on LanguagePair {
  String toLabel(BuildContext context) =>
      context.s.languagePairLabel(source.toLabel(context), target.toLabel(context));
}
