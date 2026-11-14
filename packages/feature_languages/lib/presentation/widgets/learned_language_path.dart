import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/ask_me_in_stop.dart';
import 'package:feature_languages/presentation/widgets/flag_circle.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';

const _lineWidth = Spacing.borderWidthThick;
const _stopSpacing = Spacing.m;

class const LearnedLanguagePath({
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
                role: context.s.learnedLanguageAskMeInFromRole(
                  learned.askMeInFromLevel.toLabel(context),
                ),
              ),
              (final askMeIn?, false) => AskMeInStop(askMeIn: askMeIn, state: _state),
              (null, true) => const SizedBox.shrink(),
              (null, false) => AddAskMeInStop(state: _state),
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
