import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/tag_extensions.dart';
import 'package:shared/presentation/widgets/collection_select_tile.dart';

Future<Set<String>?> requestsCollections(
  BuildContext context, {
  required List<Tag> tags,
  required Map<String, VocabularyImage> images,
  required Map<String, int> counts,
  required Set<String> selected,
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (sheetContext) => _CollectionsPicker(
      tags: tags,
      images: images,
      counts: counts,
      selected: selected,
    ),
  );
}

class const _CollectionsPicker({
  required final List<Tag> _tags,
  required final Map<String, VocabularyImage> _images,
  required final Map<String, int> _counts,
  required final Set<String> _selected,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selection = useState(_selected);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.s.customPracticeCollectionsTitle, style: context.t.headlineSmall),
            const SizedBox(height: Spacing.m),
            Flexible(
              child: SingleChildScrollView(
                child: CollectionSelectGroup(
                  children: [
                    for (final tag in _tags)
                      CollectionSelectTile(
                        title: tag.toLabel(),
                        image: _images[tag.id],
                        subtitle: switch (_counts[tag.id]) {
                          final count? => context.s.languagesWordCount(count),
                          null => null,
                        },
                        isChecked: selection.value.contains(tag.id),
                        onTap: () => selection.value = selection.value.contains(tag.id)
                            ? selection.value.difference({tag.id})
                            : {...selection.value, tag.id},
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Spacing.m),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(selection.value),
              child: Text(context.s.customPracticeDoneButton),
            ),
          ],
        ),
      ),
    );
  }
}
