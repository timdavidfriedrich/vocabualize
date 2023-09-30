import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';

class AddTagDialog extends StatefulWidget {
  final Vocabulary vocabulary;

  const AddTagDialog({super.key, required this.vocabulary});

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  String input = "";

  void _submit() {
    /// ?: add directly to vocabulary, or just to list first and confirm with save
    if (input.isNotEmpty) widget.vocabulary.addTag(input.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)?.record_addTagHint,
                  label: Text(AppLocalizations.of(context)?.record_addTagLabel ?? ""),
                ),
                onChanged: (text) => setState(() => input = text),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(onPressed: () => _submit(), icon: Icon(input.isNotEmpty ? Icons.save_rounded : Icons.close_rounded)),
          ],
        ),
      ),
    );
  }
}
