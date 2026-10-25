import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/level_indicator.dart';
import 'package:feature_home/presentation/widgets/vocabulary_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const VocabularyTile({
  super.key,
  required final Vocabulary _vocabulary,
  required final VoidCallback _onTap,
  required final VoidCallback _onSpeak,
  required final VoidCallback _onDelete,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.radiusL),
      child: Dismissible(
        key: ValueKey(_vocabulary.id),
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) async {
          _onDelete();
          return false;
        },
        background: Container(
          alignment: AlignmentDirectional.centerEnd,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
          color: context.c.error,
          child: Icon(Icons.delete_rounded, color: context.c.onError),
        ),
        child: ListTile(
          onTap: _onTap,
          contentPadding: const EdgeInsetsDirectional.only(start: Spacing.xs),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
          leading: VocabularyTileLeading(vocabulary: _vocabulary),
          title: Text(_vocabulary.target, maxLines: 2, overflow: TextOverflow.ellipsis),
          subtitle: Text(
            _vocabulary.source,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.t.bodyLarge?.copyWith(color: context.c.outline),
          ),
          trailing: IconButton(
            onPressed: _onSpeak,
            tooltip: context.s.vocabularySpeakTooltip,
            icon: const Icon(Icons.volume_up),
          ),
        ),
      ),
    );
  }
}

class const VocabularyTileLeading({
  super.key,
  required final Vocabulary _vocabulary,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LevelIndicator(
          level: _vocabulary.level.toVocabularyLevel(),
          margin: const EdgeInsets.symmetric(vertical: Spacing.xs),
        ),
        const SizedBox(width: Spacing.s),
        VocabularyThumbnail(image: _vocabulary.image),
      ],
    );
  }
}
