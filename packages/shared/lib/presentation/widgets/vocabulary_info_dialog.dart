import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/date_time_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';
import 'package:shared/presentation/widgets/level_indicator.dart';
import 'package:shared/presentation/widgets/vocabulary_image_view.dart';

const _targetMaxLines = 7;
const _sourceMaxLines = 5;
const _editBackgroundOpacity = 0.3;

Future<void> showVocabularyInfoDialog(
  BuildContext context, {
  required Vocabulary vocabulary,
  required List<Tag> tags,
  required VoidCallback onSpeak,
  required VoidCallback onEdit,
}) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => _VocabularyInfoDialog(
      vocabulary: vocabulary,
      tags: [
        for (final tag in tags)
          if (vocabulary.tagIds.contains(tag.id)) tag,
      ],
      onSpeak: onSpeak,
      onEdit: onEdit,
    ),
  );
}

class const _VocabularyInfoDialog({
  required final Vocabulary _vocabulary,
  required final List<Tag> _tags,
  required final VoidCallback _onSpeak,
  required final VoidCallback _onEdit,
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
      content: BlocSelector<PreferencesCubit, Preferences, bool>(
        selector: (preferences) => preferences.areImagesHidden,
        builder: (context, areImagesHidden) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_vocabulary.image case CustomImage() || StockImage() when !areImagesHidden)
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
            if (_tags.isNotEmpty) ...[
              const SizedBox(height: Spacing.m),
              Wrap(
                spacing: Spacing.xs,
                runSpacing: -Spacing.xs,
                children: [for (final tag in _tags) Chip(label: Text(tag.name))],
              ),
            ],
            const SizedBox(height: Spacing.m),
            _DatesInformationRow(vocabulary: _vocabulary),
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _onEdit();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(Spacing.s),
                backgroundColor: context.c.primary.withValues(alpha: _editBackgroundOpacity),
              ),
              child: const Icon(Icons.edit),
            ),
            const SizedBox(width: Spacing.m),
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
