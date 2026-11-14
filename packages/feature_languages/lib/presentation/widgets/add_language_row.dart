import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_extensions.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

const _addIconSize = Spacing.xxl;

class const AddLanguageRow({
  super.key,
  required final LanguagesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLowest,
      child: InkWell(
        onTap: _state.isBusy ? null : () => _addLanguage(context, _state.setup),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Row(
            children: [
              Container(
                width: _addIconSize,
                height: _addIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.c.primaryContainer,
                ),
                child: Icon(Icons.add_rounded, color: context.c.primary),
              ),
              const SizedBox(width: Spacing.m),
              Text(
                context.s.languagesAddButton,
                style: context.t.titleMedium?.copyWith(color: context.c.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addLanguage(BuildContext context, LanguageSetup setup) async {
    final pausedLanguages = {for (final learned in setup.paused) learned.language};
    final language = await requestsLanguage(
      context,
      options: [
        for (final language in supportedLanguages)
          if (!language.isSameLanguageAs(setup.main) &&
              !setup.active.any((learned) => learned.language == language))
            language,
      ],
      paused: pausedLanguages,
    );
    if (language == null || !context.mounted) return;
    if (pausedLanguages.contains(language)) {
      await context.pushLearnedLanguageDetails(language: language);
    } else {
      await context.pushLanguageWords(language: language, isAdding: true);
    }
  }
}
