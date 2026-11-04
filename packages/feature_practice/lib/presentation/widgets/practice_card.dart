import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:feature_practice/presentation/widgets/solution_diff_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _solutionOpacity = 0.75;
const _introOverlayOpacity = 0.8;
const _solutionMaxLines = 7;
const _promptMaxLines = 4;
const _speakButtonSize = Spacing.xxxl;
const _nonBreakingSpace = "\u00A0";

typedef _CardView = ({
  PracticeCard card,
  Language main,
  bool isStrictCorrection,
  bool isSolutionShown,
  bool isPromptRevealed,
  String? typedAnswer,
  PracticeAnswer? grade,
});

class const PracticeCardView({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PracticeBloc, PracticeState, _CardView?>(
      selector: (state) => switch (state) {
        final PracticeActive active => (
          card: active.current,
          main: active.setup.main,
          isStrictCorrection: active.isStrictCorrection,
          isSolutionShown: active.isSolutionShown,
          isPromptRevealed: active.isPromptRevealed,
          typedAnswer: active.typedAnswer,
          grade: active.grade,
        ),
        _ => null,
      },
      builder: (context, view) => switch (view) {
        null => const SizedBox.shrink(),
        final view => BlocSelector<PreferencesCubit, Preferences, bool>(
          selector: (preferences) => preferences.areImagesHidden,
          builder: (context, areImagesHidden) => _CardContent(
            view: view,
            areImagesHidden: areImagesHidden,
          ),
        ),
      },
    );
  }
}

class const _CardContent({
  required final _CardView _view,
  required final bool _areImagesHidden,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final card = _view.card;
    final item = card.item;
    final target = item.language;
    final vocabulary = item.vocabulary;
    final solution = vocabulary.textIn(target) ?? "";
    final mainText = card.prompt == _view.main ? null : vocabulary.textIn(_view.main);
    final overlay = switch ((card.isIntro, _view.isSolutionShown)) {
      (true, _) => _IntroOverlay(language: target, text: solution),
      (false, true) => _Solution(
        solution: solution,
        typedAnswer: _view.typedAnswer,
        grade: _view.grade,
        isStrictCorrection: _view.isStrictCorrection,
      ),
      (false, false) => null,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (card.isIntro)
          const SizedBox(height: Spacing.xxxxl)
        else ...[
          Text(
            context.s.practiceQuestionTitle(
              "${target.toFlag()}$_nonBreakingSpace${target.toShortLabel(context)}",
            ),
            style: context.t.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.l),
        ],
        if (!_areImagesHidden)
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Spacing.radiusXxl),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  VocabularyImageView(
                    image: vocabulary.image,
                    variant: VocabularyImageVariant.full,
                    displayWidth: MediaQuery.sizeOf(context).width,
                  ),
                  ?overlay,
                ],
              ),
            ),
          )
        else if (overlay != null)
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Spacing.radiusXxl),
              child: ColoredBox(color: context.c.surfaceContainerLow, child: overlay),
            ),
          ),
        const SizedBox(height: Spacing.xxl),
        _FlaggedText(
          language: mainText == null ? null : card.prompt,
          text: vocabulary.textIn(card.prompt) ?? "",
          style: context.t.titleLarge?.copyWith(fontWeight: FontWeight.normal),
        ),
        if (mainText != null) ...[
          const SizedBox(height: Spacing.s),
          if (_view.isPromptRevealed || _view.isSolutionShown)
            _FlaggedText(
              language: _view.main,
              text: mainText,
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            )
          else
            Center(
              child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: context.c.onSurfaceVariant),
                onPressed: () => context.read<PracticeBloc>().add(const PracticePromptRevealed()),
                icon: const Icon(Icons.visibility_outlined, size: Spacing.iconS),
                label: Text(
                  context.s.practiceShowMainButton(_view.main.toShortLabel(context)),
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

class const _FlaggedText({
  required final Language? _language,
  required final String _text,
  required final TextStyle? _style,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (_language case final language?) ...[
          Text(language.toFlag(), style: _style),
          const SizedBox(width: Spacing.s),
        ],
        Flexible(
          child: Text(
            _text,
            style: _style,
            maxLines: _promptMaxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class const _IntroOverlay({
  required final Language _language,
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final background = context.c.surface.withValues(alpha: _introOverlayOpacity);
    return Padding(
      padding: const EdgeInsets.all(Spacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(Spacing.radiusM),
            ),
            child: Text(
              context.s.practiceIntroBadge(
                "${_language.toFlag()}$_nonBreakingSpace${_language.toShortLabel(context)}",
              ),
              style: context.t.labelLarge,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.s, Spacing.s, Spacing.s),
            decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(Spacing.radiusXl),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _text,
                    style: context.t.headlineSmall,
                    maxLines: _promptMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: Spacing.s),
                SizedBox.square(
                  dimension: _speakButtonSize,
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: context.c.primaryContainer,
                      foregroundColor: context.c.onPrimaryContainer,
                    ),
                    onPressed: () =>
                        context.read<PracticeBloc>().add(const PracticeSpeakRequested()),
                    tooltip: context.s.vocabularySpeakTooltip,
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class const _Solution({
  required final String _solution,
  required final String? _typedAnswer,
  required final PracticeAnswer? _grade,
  required final bool _isStrictCorrection,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow.withValues(alpha: _solutionOpacity),
        border: Border.all(
          color: switch (_grade) {
            PracticeAnswer.forgot => context.levels.novice,
            PracticeAnswer.hard => context.levels.beginner,
            PracticeAnswer.good => context.levels.advanced,
            PracticeAnswer.easy => context.levels.expert,
            null => context.c.surfaceContainerLow.withValues(alpha: 0),
          },
          width: Spacing.borderWidthHeavy,
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SolutionDiffText(
                givenAnswer: _typedAnswer ?? _solution,
                solution: _solution,
                isStrict: _isStrictCorrection,
                maxLines: _solutionMaxLines,
              ),
            ),
            const SizedBox(width: Spacing.xs),
            IconButton(
              onPressed: () => context.read<PracticeBloc>().add(const PracticeSpeakRequested()),
              tooltip: context.s.vocabularySpeakTooltip,
              icon: const Icon(Icons.volume_up_rounded, size: Spacing.iconXl),
            ),
          ],
        ),
      ),
    );
  }
}
