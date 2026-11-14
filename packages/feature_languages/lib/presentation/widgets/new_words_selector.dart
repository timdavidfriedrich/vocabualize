import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const NewWordsSelector({
  super.key,
  required final NewWordLimit _selected,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    return Container(
      padding: const EdgeInsets.all(Spacing.xxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          for (final limit in newWordLimits)
            Expanded(
              child: Material(
                color: limit == _selected
                    ? context.c.secondaryContainer
                    : context.c.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(Spacing.radiusXl),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _isBusy || limit == _selected
                      ? null
                      : () => bloc.add(LearnedLanguageNewWordsChanged(newWords: limit)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.s),
                    child: Text(
                      switch (limit) {
                        NewWordsUpTo(:final count) => "$count",
                        AllNewWords() => context.s.learnedLanguageAllNewWords,
                      },
                      textAlign: TextAlign.center,
                      style: context.t.titleMedium?.copyWith(
                        color: limit == _selected
                            ? context.c.onSecondaryContainer
                            : context.c.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
