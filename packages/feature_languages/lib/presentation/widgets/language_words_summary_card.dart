import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/extensions/language_words_editing_extensions.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/widgets/segmented_bar.dart';

const _addedTint = 0.5;

class const LanguageWordsSummaryCard({
  super.key,
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coverage = _state.coverage;
    final added = _state.preview?.addedCount ?? 0;
    final removed = _state.preview?.removedCount ?? 0;
    final result = _state.resultCount;
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                coverage.inLanguageCount.toCountLabel(context),
                style: context.t.displaySmall?.copyWith(color: context.c.outline),
              ),
              const SizedBox(width: Spacing.m),
              Icon(Icons.arrow_forward_rounded, color: context.c.primary, size: Spacing.iconXl),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Text(
                  result.toCountLabel(context),
                  style: context.t.displaySmall,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: Spacing.xxs,
                children: [
                  if (added > 0)
                    _ChangeChip(
                      label: context.s.languageWordsAddedLabel(added.toCountLabel(context)),
                      color: context.c.primaryContainer,
                      textColor: context.c.primary,
                    ),
                  if (removed > 0)
                    _ChangeChip(
                      label: context.s.languageWordsRemovedLabel(removed.toCountLabel(context)),
                      color: context.c.errorContainer,
                      textColor: context.c.error,
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: Spacing.l),
          SegmentedBar(
            total: coverage.totalCount,
            parts: [
              SegmentedBarPart(value: coverage.inLanguageCount - removed, color: context.c.primary),
              SegmentedBarPart(
                value: added,
                color: Color.lerp(context.c.primary, context.c.onPrimary, _addedTint)!,
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          Text(
            context.s.languageWordsImportedCount(result, coverage.totalCount),
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class const _ChangeChip({
  required final String _label,
  required final Color _color,
  required final Color _textColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
      decoration: BoxDecoration(
        color: _color,
        borderRadius: BorderRadius.circular(Spacing.radiusM),
      ),
      child: Text(_label, style: context.t.labelLarge?.copyWith(color: _textColor)),
    );
  }
}
