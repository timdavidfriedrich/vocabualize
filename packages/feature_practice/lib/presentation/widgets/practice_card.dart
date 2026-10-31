import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:feature_practice/presentation/widgets/solution_diff_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _solutionOpacity = 0.75;
const _solutionMaxLines = 7;
const _promptMaxLines = 4;

typedef _CardView = ({
  PracticeCard card,
  bool showsLanguages,
  bool isStrictCorrection,
  bool isSolutionShown,
  bool isPromptRevealed,
  String? mainText,
  String mainLabel,
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
          showsLanguages: active.showsLanguagesFor(active.current),
          isStrictCorrection: active.isStrictCorrection,
          isSolutionShown: active.isSolutionShown || active.current.isIntro,
          isPromptRevealed: active.isPromptRevealed,
          mainText: active.current.prompt == active.setup.main
              ? null
              : active.current.item.vocabulary.textIn(active.setup.main),
          mainLabel: active.setup.main.toLabel(context),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_areImagesHidden) const SizedBox(height: Spacing.xxxxl),
        if (_view.showsLanguages)
          Text(
            LanguagePair(source: card.prompt, target: item.language).toLabel(context),
            style: context.t.bodyLarge?.copyWith(color: context.c.outline),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: Spacing.s),
        Stack(
          children: [
            if (!_areImagesHidden)
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.radiusXxl),
                  child: VocabularyImageView(
                    image: item.vocabulary.image,
                    variant: VocabularyImageVariant.full,
                    displayWidth: MediaQuery.sizeOf(context).width,
                  ),
                ),
              ),
            if (_view.isSolutionShown)
              AspectRatio(
                aspectRatio: 1,
                child: _Solution(
                  solution: item.vocabulary.textIn(item.language) ?? "",
                  typedAnswer: _view.typedAnswer,
                  grade: _view.grade,
                  isStrictCorrection: _view.isStrictCorrection,
                ),
              ),
          ],
        ),
        const SizedBox(height: Spacing.xxl),
        Text(
          item.vocabulary.textIn(card.prompt) ?? "",
          style: context.t.bodyLarge,
          maxLines: _promptMaxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        if (_view.mainText case final mainText?)
          _view.isPromptRevealed
              ? Text(
                  mainText,
                  style: context.t.bodyMedium?.copyWith(color: context.c.outline),
                  textAlign: TextAlign.center,
                )
              : Center(
                  child: TextButton(
                    onPressed: () =>
                        context.read<PracticeBloc>().add(const PracticePromptRevealed()),
                    child: Text(context.s.practiceShowMainButton(_view.mainLabel)),
                  ),
                ),
      ],
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
