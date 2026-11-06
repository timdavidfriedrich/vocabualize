import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/app_dropdown.dart';
import 'package:shared/presentation/widgets/emoji_picker.dart';
import 'package:shared/presentation/widgets/send_text_field.dart';

sealed class CollectionEdit {
  const CollectionEdit();
}

class const CollectionSaved({
  required final String name,
  required final String? emoji,
}) extends CollectionEdit;

class const CollectionDeleteChosen() extends CollectionEdit;

Future<CollectionSaved?> requestsNewCollection(
  BuildContext context, {
  required List<String> usedEmojis,
}) async {
  final edit = await showDialog<CollectionEdit>(
    context: context,
    builder: (dialogContext) => _CollectionDialog(tag: null, usedEmojis: usedEmojis),
  );
  return switch (edit) {
    final CollectionSaved saved => saved,
    CollectionDeleteChosen() || null => null,
  };
}

Future<CollectionEdit?> requestsCollectionEdit(
  BuildContext context, {
  required Tag tag,
  required List<String> usedEmojis,
}) {
  return showDialog<CollectionEdit>(
    context: context,
    builder: (dialogContext) => _CollectionDialog(tag: tag, usedEmojis: usedEmojis),
  );
}

class const _CollectionDialog({
  required final Tag? _tag,
  required final List<String> _usedEmojis,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final tag = _tag;
    final emoji = useState(tag?.emoji);
    final isPickerOpen = useState(false);
    final focusNode = useFocusNode();
    useEffect(() {
      void closePicker() {
        if (focusNode.hasFocus) isPickerOpen.value = false;
      }

      focusNode.addListener(closePicker);
      return () => focusNode.removeListener(closePicker);
    }, [focusNode]);
    void setPickerOpen(bool isOpen) {
      isPickerOpen.value = isOpen;
      isOpen ? focusNode.unfocus() : focusNode.requestFocus();
    }

    void save(String name) => Navigator.of(context).pop(
      switch (tag) {
        Tag(name: final previous, emoji: final previousEmoji)
            when previous == name && previousEmoji == emoji.value =>
          null,
        _ => CollectionSaved(name: name, emoji: emoji.value),
      },
    );
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.all(Spacing.s),
      backgroundColor: context.c.surfaceContainerLow,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    tag == null
                        ? context.s.detailsNewCollectionTitle
                        : context.s.collectionsEditTitle,
                    style: context.t.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: context.s.close,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: Spacing.s),
            SendTextField(
              autofocus: true,
              focusNode: focusNode,
              initialText: tag?.name,
              hintText: context.s.detailsCollectionNameHint,
              prefix: Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.xs, Spacing.xs, Spacing.s, Spacing.xs),
                child: DropdownChip(
                  leading: switch (emoji.value) {
                    final emoji? => Text(emoji, style: context.t.titleMedium),
                    null => const Icon(Icons.add_reaction_outlined),
                  },
                  semanticsLabel: context.s.collectionsEmojiTooltip,
                  isOpen: isPickerOpen.value,
                  onPressed: () => setPickerOpen(!isPickerOpen.value),
                ),
              ),
              onSubmitted: save,
            ),
            if (isPickerOpen.value) ...[
              const SizedBox(height: Spacing.m),
              EmojiPicker(
                usedEmojis: _usedEmojis,
                selected: emoji.value,
                onSelected: (selected) {
                  emoji.value = selected == emoji.value ? null : selected;
                  setPickerOpen(false);
                },
              ),
            ],
            if (tag != null) ...[
              const SizedBox(height: Spacing.s),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () => Navigator.of(context).pop(const CollectionDeleteChosen()),
                  style: TextButton.styleFrom(foregroundColor: context.c.error),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(context.s.collectionsDeleteButton),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
