import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_extensions.dart';
import 'package:shared/presentation/widgets/vocabulary_tile_leading.dart';

class const VocabularyTile({
  super.key,
  required final Vocabulary _vocabulary,
  required final Language _language,
  required final Language _mainLanguage,
  required final VoidCallback _onTap,
  required final VoidCallback _onLongPress,
  required final VoidCallback _onSpeak,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _onTap,
      onLongPress: _onLongPress,
      contentPadding: const EdgeInsetsDirectional.only(start: Spacing.xs),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      leading: VocabularyTileLeading(vocabulary: _vocabulary, language: _language),
      title: Text(
        _vocabulary.titleIn(context, _language),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        _vocabulary.promptIn(_mainLanguage),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: context.t.bodyLarge?.copyWith(color: context.c.outline),
      ),
      trailing: IconButton(
        onPressed: _onSpeak,
        tooltip: context.s.vocabularySpeakTooltip,
        icon: const Icon(Icons.volume_up),
      ),
    );
  }
}
