import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

class const ImportedWordsCard({
  super.key,
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coverage = _state.coverage;
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.s, Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.s.languagesWordCount(coverage?.inLanguageCount ?? 0),
                  style: context.t.titleMedium,
                ),
                Text(
                  context.s.learnedLanguageTotalWordsHint(coverage?.totalCount ?? 0),
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
          TonalButton(
            isCompact: true,
            onPressed: () =>
                context.pushLanguageWords(language: _state.learned.language, isAdding: false),
            child: Text(context.s.languageWordsManageTitle),
          ),
        ],
      ),
    );
  }
}
