import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice_bloc.dart';
import 'package:feature_practice/presentation/practice_event.dart';
import 'package:feature_practice/presentation/practice_state.dart';
import 'package:feature_practice/presentation/widgets/solution_diff_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/domain/entities/practice_answer.dart';
import 'package:shared/domain/entities/practice_item.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _solutionOpacity = 0.75;
const _solutionMaxLines = 7;
const _sourceMaxLines = 4;

typedef _Card = ({
  PracticeItem item,
  Language mainLanguage,
  bool showsLanguages,
  bool isStrictCorrection,
  bool isSolutionShown,
  String? typedAnswer,
  PracticeAnswer? grade,
});

class const PracticeCard({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<PracticeBloc, PracticeState, _Card?>(
      selector: (state) => switch (state) {
        PracticeActive(
          :final queue,
          :final mainLanguage,
          :final showsLanguages,
          :final isStrictCorrection,
          :final isSolutionShown,
          :final typedAnswer,
          :final grade,
        ) =>
          (
            item: queue.first,
            mainLanguage: mainLanguage,
            showsLanguages: showsLanguages,
            isStrictCorrection: isStrictCorrection,
            isSolutionShown: isSolutionShown,
            typedAnswer: typedAnswer,
            grade: grade,
          ),
        _ => null,
      },
      builder: (context, card) => switch (card) {
        null => const SizedBox.shrink(),
        final card => BlocSelector<PreferencesCubit, Preferences, bool>(
          selector: (preferences) => preferences.areImagesHidden,
          builder: (context, areImagesHidden) => _CardContent(
            card: card,
            areImagesHidden: areImagesHidden,
          ),
        ),
      },
    );
  }
}

class const _CardContent({
  required final _Card _card,
  required final bool _areImagesHidden,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final card = _card;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (_areImagesHidden) const SizedBox(height: Spacing.xxxxl),
        if (card.showsLanguages)
          Text(
            LanguagePair(source: card.mainLanguage, target: card.item.language).toLabel(context),
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
                    image: card.item.vocabulary.image,
                    variant: VocabularyImageVariant.full,
                    displayWidth: MediaQuery.sizeOf(context).width,
                  ),
                ),
              ),
            if (card.isSolutionShown)
              AspectRatio(
                aspectRatio: 1,
                child: _Solution(
                  solution: card.item.vocabulary.textIn(card.item.language) ?? "",
                  typedAnswer: card.typedAnswer,
                  grade: card.grade,
                  isStrictCorrection: card.isStrictCorrection,
                ),
              ),
          ],
        ),
        const SizedBox(height: Spacing.xxl),
        Text(
          card.item.vocabulary.promptIn(card.mainLanguage),
          style: context.t.bodyLarge,
          maxLines: _sourceMaxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
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
