import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/extensions/practice_answer_extensions.dart';
import 'package:feature_practice/presentation/extensions/typed_answer_extensions.dart';
import 'package:feature_practice/presentation/practice_bloc.dart';
import 'package:feature_practice/presentation/practice_event.dart';
import 'package:feature_practice/presentation/practice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';

typedef _Controls = ({
  Vocabulary vocabulary,
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
          vocabulary: queue.first,
          isSolutionShown: isSolutionShown,
          grade: grade,
          isBusy: isBusy,
        ),
        _ => null,
      },
      builder: (context, controls) => switch (controls) {
        null => const SizedBox.shrink(),
        final controls => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            if (controls.isSolutionShown) _RateButtons(controls: controls),
            const SizedBox(height: Spacing.m),
            BlocSelector<PreferencesCubit, Preferences, bool>(
              selector: (preferences) => preferences.isTypeAnswerDisabled,
              builder: (context, isTypeAnswerDisabled) => switch (controls) {
                (isSolutionShown: false, :final vocabulary, isBusy: _, grade: _)
                    when !isTypeAnswerDisabled &&
                        vocabulary.level.toVocabularyLevel() != VocabularyLevel.novice =>
                  _AnswerField(key: ValueKey(vocabulary.id), vocabulary: vocabulary),
                (isSolutionShown: false, vocabulary: _, isBusy: _, grade: _) => ElevatedButton(
                  onPressed: () =>
                      context.read<PracticeBloc>().add(const PracticeSolutionRequested()),
                  child: Text(context.s.practiceSolutionButton),
                ),
                (isSolutionShown: true, :final grade, :final isBusy, vocabulary: _) =>
                  OutlinedButton(
                    onPressed: !isBusy && grade.allows(PracticeAnswer.forgot)
                        ? () => context.read<PracticeBloc>().add(
                            const PracticeAnswered(answer: PracticeAnswer.forgot),
                          )
                        : null,
                    child: Text(context.s.practiceForgotButton),
                  ),
              },
            ),
            const SizedBox(height: Spacing.xxxxl),
          ],
        ),
      },
    );
  }
}

class const _RateButtons({
  required final _Controls _controls,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdaptiveActions.stretched(
      spacing: Spacing.s,
      stackedSpacing: Spacing.xxs,
      children: [
        _RateButton(
          controls: _controls,
          answer: PracticeAnswer.hard,
          color: context.levels.beginner,
          label: context.s.practiceHardButton,
        ),
        _RateButton(
          controls: _controls,
          answer: PracticeAnswer.good,
          color: context.levels.advanced,
          label: context.s.practiceGoodButton,
        ),
        _RateButton(
          controls: _controls,
          answer: PracticeAnswer.easy,
          color: context.levels.expert,
          label: context.s.practiceEasyButton,
        ),
      ],
    );
  }
}

class const _RateButton({
  required final _Controls _controls,
  required final PracticeAnswer _answer,
  required final Color _color,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: Spacing.s),
        backgroundColor: _color,
      ),
      onPressed: !_controls.isBusy && _controls.grade.allows(_answer)
          ? () => context.read<PracticeBloc>().add(PracticeAnswered(answer: _answer))
          : null,
      child: Text(_label),
    );
  }
}

class const _AnswerField({
  super.key,
  required final Vocabulary _vocabulary,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final hasText = useListenableSelector(controller, () => controller.text.isNotEmpty);
    void submit() {
      if (controller.text.isEmpty) return;
      context.read<PracticeBloc>().add(PracticeAnswerTyped(text: controller.text));
    }

    return TextField(
      controller: controller,
      onTap: () {
        if (controller.text.isNotEmpty) return;
        final article = _vocabulary.target.leadingArticle(_vocabulary.targetLanguage.articles);
        if (article != null) controller.text = article;
      },
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onSubmitted: (_) => submit(),
      autocorrect: false,
      enableSuggestions: false,
      decoration: InputDecoration(
        label: Text(context.s.practiceAnswerLabel),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        suffixIcon: hasText
            ? IconButton(onPressed: submit, icon: const Icon(Icons.done_rounded))
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(Spacing.radiusS)),
      ),
    );
  }
}
