import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

sealed class CollectionEdit {
  const CollectionEdit();
}

class const CollectionRename({
  required final String name,
}) extends CollectionEdit;

class const CollectionDelete() extends CollectionEdit;

Future<CollectionEdit?> requestsCollectionEdit(BuildContext context, {required String name}) {
  return showDialog<CollectionEdit>(
    context: context,
    builder: (dialogContext) => _EditCollectionDialog(name: name),
  );
}

Future<bool> confirmsCollectionDelete(BuildContext context) async {
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => const _DeleteCollectionDialog(),
  );
  return isConfirmed ?? false;
}

class const _EditCollectionDialog({
  required final String _name,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _name);
    final hasChanged = useListenableSelector(
      controller,
      () => controller.text.trim().isNotEmpty && controller.text.trim() != _name,
    );
    void submit() => Navigator.of(context).pop(
      hasChanged ? CollectionRename(name: controller.text.trim()) : null,
    );
    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
      contentPadding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.s, Spacing.xs, Spacing.xs),
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    onSubmitted: (_) => submit(),
                    decoration: InputDecoration(
                      hintText: _name,
                      label: Text(context.s.detailsCollectionNameLabel),
                    ),
                  ),
                ),
                const SizedBox(width: Spacing.xs),
                IconButton(
                  onPressed: submit,
                  icon: Icon(hasChanged ? Icons.save_rounded : Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: Spacing.xs),
            TextButton.icon(
              onPressed: () => Navigator.of(context).pop(const CollectionDelete()),
              style: TextButton.styleFrom(foregroundColor: context.c.error),
              icon: const Icon(Icons.delete_rounded),
              label: Text(context.s.collectionsDeleteButton),
            ),
          ],
        ),
      ),
    );
  }
}

class const _DeleteCollectionDialog() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: Text(context.s.collectionsDeleteTitle),
      content: Text(context.s.collectionsDeleteMessage),
      actionsPadding: const EdgeInsets.all(Spacing.xl),
      actionsAlignment: MainAxisAlignment.end,
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(Spacing.s)),
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.s.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: context.c.error),
          child: Text(context.s.delete),
        ),
      ],
    );
  }
}
