import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/widgets/photo_actions.dart';
import 'package:feature_practice/presentation/widgets/practice_text_row.dart';
import 'package:feature_practice/presentation/widgets/shrinkable_box.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _targetMaxLines = 3;
const _photoMinimumHeight = Spacing.xxxxl * 2;
const _nonBreakingSpace = " ";

class const IntroCard({
  super.key,
  required final PracticeCard _card,
  required final Language _main,
  required final bool _areImagesHidden,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final target = _card.item.language;
    final vocabulary = _card.item.vocabulary;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Align(
        alignment: Alignment.topCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: context.c.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.l, Spacing.m, Spacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.s.practiceIntroTitle(
                    "${target.toFlag()}$_nonBreakingSpace${target.toShortLabel(context)}",
                  ),
                  style: context.t.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.m),
                if (!_areImagesHidden) ...[
                  Flexible(
                    child: ShrinkableBox(
                      minimumHeight: _photoMinimumHeight,
                      child: Center(
                        heightFactor: 1,
                        child: AspectRatio(
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
                                Positioned(
                                  right: Spacing.s,
                                  bottom: Spacing.s,
                                  child: PhotoActions(card: _card, main: _main),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: Spacing.m),
                ],
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                  child: Row(
                    children: [
                      Expanded(
                        child: _Texts(card: _card, main: _main),
                      ),
                      if (_areImagesHidden) PhotoActions(card: _card, main: _main),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class const _Texts({
  required final PracticeCard _card,
  required final Language _main,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vocabulary = _card.item.vocabulary;
    final promptText = vocabulary.textIn(_card.prompt) ?? "";
    final mainText = _card.prompt == _main ? null : vocabulary.textIn(_main);
    final secondaryStyle = context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          vocabulary.textIn(_card.item.language) ?? "",
          style: context.t.headlineLarge,
          maxLines: _targetMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Spacing.xxxs),
        switch (mainText) {
          null => Text(promptText, style: secondaryStyle),
          final mainText => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Spacing.xxxs,
            children: [
              PracticeTextRow(
                leading: Text(_card.prompt.toFlag(), style: context.t.bodyLarge),
                text: promptText,
                style: context.t.bodyLarge,
                isCentered: false,
              ),
              PracticeTextRow(
                leading: Text(_main.toFlag(), style: context.t.bodyLarge),
                text: mainText,
                style: secondaryStyle,
                isCentered: false,
              ),
            ],
          ),
        },
      ],
    );
  }
}
