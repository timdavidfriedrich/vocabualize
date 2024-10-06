import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/add_or_update_vocabulary_use_case.dart';

class AddTagDialog extends ConsumerStatefulWidget {
  final Vocabulary vocabulary;

  const AddTagDialog({super.key, required this.vocabulary});

  @override
  ConsumerState<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends ConsumerState<AddTagDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void submit() {
      /// ?: add directly to vocabulary, or just to list first and confirm with save
      final text = _controller.text;
      if (text.isNotEmpty) {
        final tag = Tag(name: text.trim());
        final updatedVocabulary = widget.vocabulary.copyWith(
          tags: [...widget.vocabulary.tags, tag],
        );
        ref.read(addOrUpdateVocabularyUseCaseProvider(updatedVocabulary));
      }
      Navigator.pop(context);
    }

    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 64),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: TextField(
                // TODO: Update deprecated toolbar options for AddTagDialog
                toolbarOptions: const ToolbarOptions(
                  copy: false,
                  cut: false,
                  paste: false,
                  selectAll: false,
                ),
                controller: _controller,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.record_addTagHint,
                  label: Text(AppLocalizations.of(context)?.record_addTagLabel ?? ""),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => submit(),
              icon: Icon(
                _controller.text.isNotEmpty ? Icons.save_rounded : Icons.close_rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
