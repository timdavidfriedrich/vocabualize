import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/ask_me_in_level_card.dart';
import 'package:feature_languages/presentation/widgets/flag_circle.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_extensions.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/round_icon_button.dart';

class const AddAskMeInStop({
  super.key,
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          left: flagCircleSize / 2,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.c.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(Spacing.radiusFull),
            ),
          ),
        ),
        Row(
          children: [
            Material(
              color: context.c.primaryContainer,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: _state.isBusy ? null : () => _chooseAskMeIn(context),
                child: SizedBox.square(
                  dimension: flagCircleSize,
                  child: Icon(Icons.add_rounded, color: context.c.primary),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: _state.isBusy ? null : () => _chooseAskMeIn(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                  child: Text(
                    context.s.learnedLanguageAddAskMeInButton,
                    style: context.t.titleMedium?.copyWith(color: context.c.primary),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () => _explainAskMeIn(context, _state, null),
              tooltip: context.s.learnedLanguageAskMeInHelpTooltip,
              icon: const Icon(Icons.help_outline_rounded),
            ),
            const SizedBox(width: Spacing.xxxs),
          ],
        ),
      ],
    );
  }

  Future<void> _chooseAskMeIn(BuildContext context) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final setup = _state.setup;
    final learned = _state.learned;
    final language = await requestsLanguage(
      context,
      options: [
        for (final language in supportedLanguages)
          if (!language.isSameLanguageAs(setup.main) &&
              !language.isSameLanguageAs(learned.language))
            language,
      ],
    );
    if (language != null) bloc.add(LearnedLanguageAskMeInChanged(language: language));
  }
}

class const AskMeInStop({
  super.key,
  required final Language _askMeIn,
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlagCircle(language: _askMeIn, color: context.c.primaryContainer),
        const SizedBox(width: Spacing.m),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(Spacing.s),
            decoration: BoxDecoration(
              color: context.c.primaryContainer,
              borderRadius: BorderRadius.circular(Spacing.radiusXxl),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: Spacing.s),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.s.learnedLanguageAskMeInLabel,
                              style: context.t.bodyMedium?.copyWith(
                                color: context.c.onSurfaceVariant,
                              ),
                            ),
                            Text(_askMeIn.toLabel(context), style: context.t.titleLarge),
                          ],
                        ),
                      ),
                    ),
                    RoundIconButton(
                      icon: Icons.help_outline_rounded,
                      tooltip: context.s.learnedLanguageAskMeInHelpTooltip,
                      onPressed: () => _explainAskMeIn(context, _state, _askMeIn),
                    ),
                    const SizedBox(width: Spacing.xs),
                    RoundIconButton(
                      icon: Icons.close_rounded,
                      tooltip: context.s.learnedLanguageRemoveAskMeInTooltip,
                      onPressed: _state.isBusy
                          ? null
                          : () => bloc.add(const LearnedLanguageAskMeInChanged(language: null)),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.s),
                AskMeInLevelCard(
                  level: _state.learned.askMeInFromLevel,
                  main: _state.setup.main,
                  isBusy: _state.isBusy,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

void _explainAskMeIn(BuildContext context, LearnedLanguageLoaded state, Language? askMeIn) {
  final setup = state.setup;
  final main = setup.main.toShortLabel(context);
  final learned = state.learned.language.toShortLabel(context);
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog.adaptive(
      title: Text(context.s.learnedLanguageAskMeInLabel),
      content: Text(switch (askMeIn) {
        final askMeIn? when setup.isLearning(askMeIn) =>
          context.s.learnedLanguageAskMeInHelpMessage(askMeIn.toShortLabel(context), main, learned),
        final askMeIn? => context.s.learnedLanguageAskMeInUnlearnedHelpMessage(
          askMeIn.toShortLabel(context),
          main,
          learned,
        ),
        null => context.s.learnedLanguageAskMeInIntroMessage(main, learned),
      }),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(context.s.close),
        ),
      ],
    ),
  );
}
