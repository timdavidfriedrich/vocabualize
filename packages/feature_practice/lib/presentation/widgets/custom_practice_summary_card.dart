import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:feature_practice/presentation/extensions/custom_practice_editing_extensions.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/photo_stack.dart';
import 'package:shared/presentation/widgets/segmented_bar.dart';
import 'package:shared/presentation/widgets/striped_fill.dart';

const _photoSize = Spacing.xxl + Spacing.xxxs;
const _newTint = 0.5;
const _legendDotSize = Spacing.s;

Color _colorOf(BuildContext context, CustomPracticeEditing state, Language language) {
  final colors = context.series.colors;
  final index = state.activeLanguages.indexOf(language);
  return colors[(index < 0 ? 0 : index) % colors.length];
}

Color _newColorOf(BuildContext context, Color color) =>
    Color.lerp(color, context.c.onPrimary, _newTint)!;

class const CustomPracticeSummaryCard({
  super.key,
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languages = _state.shownEnabledLanguages;
    final legendCount = languages.fold(
      0,
      (sum, language) => sum + (_state.waitingCountOf(language) > 0 ? 2 : 1),
    );
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                _state.totalCount.toCountLabel(context),
                style: context.t.displayMedium,
              ),
              const SizedBox(width: Spacing.s),
              Padding(
                padding: const EdgeInsets.only(bottom: Spacing.xs),
                child: Text(
                  context.s.customPracticeWordsLabel(_state.totalCount),
                  style: context.t.titleMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
              const Spacer(),
              PhotoStack(
                images: _state.previewImages,
                size: _photoSize,
                borderColor: context.c.surfaceContainerLow,
              ),
            ],
          ),
          if (legendCount > 1) ...[
            const SizedBox(height: Spacing.m),
            SegmentedBar(
              parts: [
                for (final language in languages) ...[
                  SegmentedBarPart(
                    value: _state.reviewCountOf(language),
                    color: _colorOf(context, _state, language),
                  ),
                  SegmentedBarPart(
                    value: _state.newCountOf(language),
                    color: _newColorOf(context, _colorOf(context, _state, language)),
                    stripeColor: _colorOf(context, _state, language),
                  ),
                ],
              ],
            ),
            const SizedBox(height: Spacing.m),
            for (final language in languages)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: Spacing.xxxs),
                child: Row(
                  children: [
                    Expanded(
                      child: _LegendEntry(
                        color: _colorOf(context, _state, language),
                        language: language,
                        label: _state.includesAllWords(language)
                            ? context.s.customPracticeAllLegend(_state.reviewCountOf(language))
                            : context.s.customPracticeDueLegend(_state.reviewCountOf(language)),
                      ),
                    ),
                    Expanded(
                      child: switch (_state.waitingCountOf(language)) {
                        0 => const SizedBox.shrink(),
                        _ => _LegendEntry(
                          color: _newColorOf(context, _colorOf(context, _state, language)),
                          stripeColor: _colorOf(context, _state, language),
                          language: language,
                          label: context.s.customPracticeNewLegend(_state.newCountOf(language)),
                        ),
                      },
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class const _LegendEntry({
  required final Color _color,
  required final Language _language,
  required final String _label,
  final Color? _stripeColor,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox.square(
          dimension: _legendDotSize,
          child: ClipOval(
            child: switch (_stripeColor) {
              final stripeColor? => StripedFill(color: stripeColor, background: _color),
              null => ColoredBox(color: _color),
            },
          ),
        ),
        const SizedBox(width: Spacing.s),
        Text(_language.toFlag(), style: context.t.bodyMedium),
        const SizedBox(width: Spacing.xs),
        Flexible(
          child: Text(_label, style: context.t.bodyLarge, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
