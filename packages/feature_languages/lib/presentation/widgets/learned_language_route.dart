import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/flag_circle.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';

const _lineWidth = Spacing.borderWidthThick;
const _stopSpacing = Spacing.m;
const _roundButtonSize = Spacing.xxxl;

class const LearnedLanguageRoute({
  super.key,
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setup = _state.setup;
    final learned = _state.learned;
    final askMeIn = learned.askMeIn;
    return Stack(
      children: [
        Positioned(
          left: (flagCircleSize - _lineWidth) / 2,
          top: flagCircleSize / 2,
          bottom: flagCircleSize / 2,
          width: _lineWidth,
          child: ColoredBox(color: context.c.primaryContainer),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: _stopSpacing,
          children: [
            _Stop(
              language: setup.main,
              color: context.c.primaryContainer,
              role: context.s.languagesSpeakTitle,
            ),
            switch ((askMeIn, learned.isPaused)) {
              (final askMeIn?, true) => _Stop(
                language: askMeIn,
                color: context.c.primaryContainer,
                role: setup.isLearning(askMeIn)
                    ? context.s.learnedLanguageAskMeInFromRole(
                        learned.askMeInFromLevel.toLabel(context),
                      )
                    : context.s.learnedLanguageAskMeInLabel,
              ),
              (final askMeIn?, false) => _AskMeInStop(askMeIn: askMeIn, state: _state),
              (null, true) => const SizedBox.shrink(),
              (null, false) => _AddAskMeInStop(state: _state),
            },
            _Stop(
              language: learned.language,
              color: learned.isPaused ? context.c.onSurfaceVariant : context.c.secondaryContainer,
              role: context.s.languagesLearnTitle,
            ),
          ],
        ),
      ],
    );
  }
}

class const _Stop({
  required final Language _language,
  required final Color _color,
  required final String _role,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlagCircle(language: _language, color: _color),
        const SizedBox(width: Spacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_language.toLabel(context), style: context.t.titleMedium),
              Text(
                _role,
                style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class const _AddAskMeInStop({
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

class const _AskMeInStop({
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
                    _RoundButton(
                      icon: Icons.help_outline_rounded,
                      tooltip: context.s.learnedLanguageAskMeInHelpTooltip,
                      onPressed: () => _explainAskMeIn(context, _state, _askMeIn),
                    ),
                    const SizedBox(width: Spacing.xs),
                    _RoundButton(
                      icon: Icons.close_rounded,
                      tooltip: context.s.learnedLanguageRemoveAskMeInTooltip,
                      onPressed: _state.isBusy
                          ? null
                          : () => bloc.add(const LearnedLanguageAskMeInChanged(language: null)),
                    ),
                  ],
                ),
                if (_state.setup.isLearning(_askMeIn)) ...[
                  const SizedBox(height: Spacing.s),
                  _LevelCard(
                    level: _state.learned.askMeInFromLevel,
                    main: _state.setup.main,
                    isBusy: _state.isBusy,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class const _RoundButton({
  required final IconData _icon,
  required final String _tooltip,
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _roundButtonSize,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: context.c.surfaceContainerHighest,
          foregroundColor: context.c.onSurface,
        ),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon),
      ),
    );
  }
}

class const _LevelCard({
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
        final askMeIn? => context.s.learnedLanguageAskMeInAlwaysHelpMessage(
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
