import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/delete_language_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';

extension LanguagesContextExtensions on BuildContext {
  Future<void> requestLanguageDelete(LanguagesLoaded state, Language language) async {
    final bloc = read<LanguagesBloc>();
    final isConfirmed = await confirmsLanguageDelete(
      this,
      language: language,
      wordCount: state.wordCounts[language],
      keptLanguages: [
        for (final learned in state.setup.learned)
          if (learned.language != language) learned.language,
      ],
    );
    if (isConfirmed) bloc.add(LanguagesDeleteRequested(language: language));
  }
}
