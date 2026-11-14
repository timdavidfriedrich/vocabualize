import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';

class const AskMeInLevelCard({
  super.key,
  required final VocabularyLevel _level,
  required final Language _main,
  required final bool _isBusy,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final level = useState(_level);
    useEffect(() {
      level.value = _level;
      return null;
    }, [_level]);
    final color = level.value.toColor(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.m, Spacing.m),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.s.learnedLanguageFromLevelTitle,
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xxs),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(Spacing.radiusFull),
                ),
                child: Text(
                  level.value.toLabel(context),
                  style: context.t.labelLarge?.copyWith(color: context.c.onSecondaryContainer),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: context.c.surfaceContainerHighest,
              thumbColor: context.c.onSurface,
              activeTickMarkColor: context.c.surfaceContainerLow,
              inactiveTickMarkColor: color,
            ),
            child: Slider(
              padding: const EdgeInsets.symmetric(vertical: Spacing.m),
              value: level.value.index.toDouble(),
              max: (VocabularyLevel.values.length - 1).toDouble(),
              divisions: VocabularyLevel.values.length - 1,
              onChanged: _isBusy
                  ? null
                  : (value) => level.value = VocabularyLevel.values[value.round()],
              onChangeEnd: (value) => context.read<LearnedLanguageBloc>().add(
                LearnedLanguageAskMeInLevelChanged(level: VocabularyLevel.values[value.round()]),
              ),
            ),
          ),
          Text(
            context.s.learnedLanguageBelowLevelHint(_main.toShortLabel(context)),
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
