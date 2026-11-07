import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:feature_practice/presentation/extensions/typed_answer_extensions.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:feature_practice/presentation/practice/practice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/send_text_field.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _nonBreakingSpace = " ";
const _buttonsPadding = EdgeInsets.fromLTRB(Spacing.xxxl, 0, Spacing.xxxl, Spacing.xl);

typedef _Controls = ({
  PracticeItem item,
  bool isIntro,
  bool isSolutionShown,
  PracticeAnswer? grade,
  bool isBusy,
});

class const PracticeControls({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PracticeBloc, PracticeState, _Controls?>(
      selector: (state) => switch (state) {
        PracticeActive(:final queue, :final isSolutionShown, :final grade, :final isBusy) => (
          item: queue.first.item,
          isIntro: queue.first.isIntro,
          isSolutionShown: isSolutionShown,
          grade: grade,
          isBusy: isBusy,
        ),
        _ => null,
      },
      builder: (context, controls) => switch (controls) {
        null => const SizedBox.shrink(),
        (isIntro: true, :final item, :final isBusy, isSolutionShown: _, grade: _) => _IntroControls(
          item: item,
          isBusy: isBusy,
        ),
        (isSolutionShown: true, isIntro: _, item: _, grade: _, isBusy: _) => _RatingControls(
          controls: controls,
        ),
        (:final item, isIntro: _, isSolutionShown: _, grade: _, isBusy: _) => _QuestionControls(
          item: item,
        ),
      },
    );
  }
}

class const _QuestionControls({
  required final PracticeItem _item,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PreferencesCubit, Preferences, bool>(
      selector: (preferences) => preferences.isTypeAnswerDisabled,
      builder: (context, isTypeAnswerDisabled) => switch (!isTypeAnswerDisabled &&
          _item.vocabulary.levelOf(_item.language) != VocabularyLevel.novice) {
        true => _AnswerBox(key: ValueKey((_item.vocabulary.id, _item.language)), item: _item),
        false => Padding(
          padding: _buttonsPadding,
          child: ElevatedButton(
            onPressed: () => context.read<PracticeBloc>().add(const PracticeSolutionRequested()),
            child: Text(context.s.practiceSolutionButton),
          ),
        ),
      },
    );
  }
}

class const _RatingControls({
  required final _Controls _controls,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: _buttonsPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdaptiveActions.stretched(
            spacing: Spacing.s,
            stackedSpacing: Spacing.s,
            children: [
              _RateButton(
                controls: _controls,
                answer: PracticeAnswer.hard,
                label: context.s.practiceHardButton,
              ),
              _RateButton(
                controls: _controls,
                answer: PracticeAnswer.good,
                label: context.s.practiceGoodButton,
              ),
              _RateButton(
                controls: _controls,
                answer: PracticeAnswer.easy,
                label: context.s.practiceEasyButton,
              ),
            ],
          ),
          const SizedBox(height: Spacing.m),
          _Suggestion(
            answer: PracticeAnswer.forgot,
            isShown: _controls.grade.suggests(PracticeAnswer.forgot),
            child: TonalButton(
              onPressed: _controls.isBusy
                  ? null
                  : () => context.read<PracticeBloc>().add(
                      const PracticeAnswered(answer: PracticeAnswer.forgot),
                    ),
              child: Text(context.s.practiceForgotButton),
            ),
          ),
        ],
      ),
    );
  }
}

class const _RateButton({
  required final _Controls _controls,
  required final PracticeAnswer _answer,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final grade = _controls.grade;
    final isTonal = grade != null && !grade.suggests(_answer);
    return _Suggestion(
      answer: _answer,
      isShown: grade.suggests(_answer),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isTonal ? _answer.toTint(context) : _answer.toColor(context),
          foregroundColor: isTonal ? _answer.toTintTextColor(context) : context.c.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
        ),
        onPressed: _controls.isBusy
            ? null
            : () => context.read<PracticeBloc>().add(PracticeAnswered(answer: _answer)),
        child: Text(_label),
      ),
    );
  }
}

class const _Suggestion({
  required final PracticeAnswer _answer,
  required final bool _isShown,
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return switch (_isShown) {
      false => _child,
      true => Stack(
        clipBehavior: Clip.none,
        fit: StackFit.passthrough,
        children: [
          _child,
          Positioned(
            top: -Spacing.xs,
            left: 0,
            right: 0,
            child: Center(
              child: DecoratedBox(
                decoration: ShapeDecoration(
                  color: _answer.toTint(context),
                  shape: const StadiumBorder(),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                  child: Text(
                    context.s.practiceSuggestedLabel,
                    style: context.t.labelSmall?.copyWith(
                      color: _answer.toTintTextColor(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    };
  }
}

class const _AnswerBox({
  super.key,
  required final PracticeItem _item,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final language = _item.language;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.c.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.l, Spacing.m, Spacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                child: Text(
                  context.s.practiceAnswerTitle(
                    "${language.toFlag()}$_nonBreakingSpace${language.toShortLabel(context)}",
                  ),
                  style: context.t.titleLarge,
                ),
              ),
              const SizedBox(height: Spacing.m),
              SendTextField(
                controller: controller,
                isCorrectionDisabled: true,
                onTap: () {
                  if (controller.text.isNotEmpty) return;
                  final article = _item.vocabulary
                      .textIn(language)
                      ?.leadingArticle(language.articles);
                  if (article != null) controller.text = article;
                },
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                onSubmitted: (text) =>
                    context.read<PracticeBloc>().add(PracticeAnswerTyped(text: text)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _IntroControls({
  required final PracticeItem _item,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PracticeBloc>();
    return Padding(
      padding: _buttonsPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: _isBusy ? null : () => bloc.add(const PracticeIntroConfirmed()),
            child: Text(context.s.practiceIntroGotItButton),
          ),
          const SizedBox(height: Spacing.s),
          TonalButton(
            onPressed: _isBusy ? null : () => bloc.add(const PracticeIntroSkipped()),
            child: Text(context.s.practiceIntroSkipButton(_item.language.toShortLabel(context))),
          ),
        ],
      ),
    );
  }
}
