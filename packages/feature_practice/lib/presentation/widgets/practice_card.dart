import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:feature_practice/presentation/widgets/answer_tiles.dart';
import 'package:feature_practice/presentation/widgets/intro_card.dart';
import 'package:feature_practice/presentation/widgets/photo_actions.dart';
import 'package:feature_practice/presentation/widgets/practice_text_row.dart';
import 'package:feature_practice/presentation/widgets/shrinkable_box.dart';
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
const _photoMinimumHeight = Spacing.xxxxl * 2;
const _solutionMaxLines = 5;
const _solutionInset = Spacing.xxxl + Spacing.xs + Spacing.s;
const _nonBreakingSpace = " ";

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
          builder: (context, areImagesHidden) => switch (view.card.isIntro) {
            true => IntroCard(card: view.card, main: view.main, areImagesHidden: areImagesHidden),
            false => _QuestionCard(view: view, areImagesHidden: areImagesHidden),
          },
        ),
      },
    );
  }
}

class const _QuestionCard({
  required final _CardView _view,
  required final bool _areImagesHidden,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final target = _view.card.item.language;
    final solution = _view.card.item.vocabulary.textIn(target) ?? "";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxl),
      child: Column(
        children: [
          Text(
            context.s.practiceQuestionTitle(
              "${target.toFlag()}$_nonBreakingSpace${target.toShortLabel(context)}",
            ),
            style: context.t.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: Spacing.l),
          if (!_areImagesHidden || _view.isSolutionShown) ...[
            Flexible(
              child: ShrinkableBox(
                minimumHeight: _photoMinimumHeight,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: _Photo(
                    view: _view,
                    solution: solution,
                    areImagesHidden: _areImagesHidden,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Spacing.xl),
          ],
          _PromptRows(view: _view),
          if ((_view.isSolutionShown, _view.typedAnswer, _view.grade) case (
            true,
            final typedAnswer?,
            final grade?,
          )) ...[
            const SizedBox(height: Spacing.xl),
            AnswerTiles(answer: typedAnswer, solution: solution, grade: grade),
          ],
        ],
      ),
    );
  }
}

class const _Photo({
  required final _CardView _view,
  required final String _solution,
  required final bool _areImagesHidden,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_areImagesHidden)
            ColoredBox(color: context.c.surfaceContainerLow)
          else
            VocabularyImageView(
              image: _view.card.item.vocabulary.image,
              variant: VocabularyImageVariant.full,
              displayWidth: MediaQuery.sizeOf(context).width,
            ),
          if (_view.isSolutionShown) ...[
            _Solution(
              solution: _solution,
              typedAnswer: _view.typedAnswer,
              grade: _view.grade,
              isStrictCorrection: _view.isStrictCorrection,
            ),
            Positioned(
              right: Spacing.s,
              bottom: Spacing.s,
              child: PhotoActions(card: _view.card, main: _view.main),
            ),
          ],
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
    final background = context.c.surfaceContainerLow;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background.withValues(alpha: _solutionOpacity),
        border: Border.all(
          color: _grade.toGradeColor(context) ?? background.withValues(alpha: 0),
          width: Spacing.borderWidthHeavy,
        ),
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: _solutionInset),
        child: Center(
          child: SolutionDiffText(
            givenAnswer: _typedAnswer ?? _solution,
            solution: _solution,
            isStrict: _isStrictCorrection,
            maxLines: _solutionMaxLines,
          ),
        ),
      ),
    );
  }
}

class const _PromptRows({
  required final _CardView _view,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final card = _view.card;
    final vocabulary = card.item.vocabulary;
    final mainText = card.prompt == _view.main ? null : vocabulary.textIn(_view.main);
    final style = context.t.bodyLarge;
    final secondaryStyle = style?.copyWith(color: context.c.onSurfaceVariant);
    return Column(
      children: [
        PracticeTextRow(
          leading: mainText == null ? null : Text(card.prompt.toFlag(), style: style),
          text: vocabulary.textIn(card.prompt) ?? "",
          style: style,
        ),
        if (mainText != null) ...[
          const SizedBox(height: Spacing.xs),
          SizedBox(
            height: Spacing.xxxl,
            child: Center(
              child: switch (_view.isPromptRevealed || _view.isSolutionShown) {
                true => PracticeTextRow(
                  leading: Text(_view.main.toFlag(), style: style),
                  text: mainText,
                  style: secondaryStyle,
                ),
                false => TextButton(
                  style: TextButton.styleFrom(foregroundColor: context.c.onSurfaceVariant),
                  onPressed: () => context.read<PracticeBloc>().add(const PracticePromptRevealed()),
                  child: PracticeTextRow(
                    leading: const Icon(Icons.visibility_outlined),
                    text: context.s.practiceShowMainButton(_view.main.toShortLabel(context)),
                    style: secondaryStyle,
                  ),
                ),
              },
            ),
          ),
        ],
      ],
    );
  }
}
