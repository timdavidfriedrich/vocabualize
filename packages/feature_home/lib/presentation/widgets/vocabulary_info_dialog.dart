import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/extensions/date_time_extensions.dart';
import 'package:feature_home/presentation/widgets/level_indicator.dart';
import 'package:feature_home/presentation/widgets/vocabulary_image_view.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _targetMaxLines = 7;
const _sourceMaxLines = 5;

Future<void> showVocabularyInfoDialog(
  BuildContext context, {
  required Vocabulary vocabulary,
  required VoidCallback onSpeak,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _VocabularyInfoDialog(vocabulary: vocabulary, onSpeak: onSpeak),
  );
}

class const _VocabularyInfoDialog({
  required final Vocabulary _vocabulary,
  required final VoidCallback _onSpeak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LevelIndicator(level: _vocabulary.level.toVocabularyLevel()),
            const SizedBox(width: Spacing.s),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _vocabulary.target,
                    style: context.t.titleLarge,
                    maxLines: _targetMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    _vocabulary.source,
                    style: context.t.bodyLarge,
                    maxLines: _sourceMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: _onSpeak,
              tooltip: context.s.vocabularySpeakTooltip,
              icon: const Icon(Icons.volume_up_rounded),
            ),
          ],
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_vocabulary.image case CustomImage() || StockImage())
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacing.radiusL),
                  child: VocabularyImageView(
                    image: _vocabulary.image,
                    variant: VocabularyImageVariant.full,
                    displayWidth: MediaQuery.sizeOf(context).width,
                  ),
                ),
              ),
            ),
          const SizedBox(height: Spacing.m),
          _DatesInformationRow(vocabulary: _vocabulary),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.s.close),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class const _DatesInformationRow({
  required final Vocabulary _vocabulary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: _DateInformation(
            label: context.s.vocabularyCreatedLabel,
            value: _vocabulary.createdAt.toDateLabel(context),
            textAlign: TextAlign.left,
          ),
        ),
        Flexible(
          child: _DateInformation(
            label: context.s.vocabularyReappearsLabel,
            value: _vocabulary.nextReviewAt.toReappearsLabel(context),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class const _DateInformation({
  required final String _label,
  required final String _value,
  required final TextAlign _textAlign,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: _textAlign,
      TextSpan(
        children: [
          TextSpan(
            text: "$_label\n",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: _value),
        ],
      ),
    );
  }
}
