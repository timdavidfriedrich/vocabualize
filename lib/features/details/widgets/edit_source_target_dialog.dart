import 'package:provider/provider.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/features/core/providers/vocabulary_provider.dart';
import 'package:vocabualize/features/core/services/messenger.dart';
import 'package:vocabualize/features/core/services/vocabulary.dart';
import 'package:vocabualize/features/details/widgets/replace_vocabulary_dialog.dart';
import 'package:vocabualize/features/record/services/record_service.dart';
import 'package:vocabualize/features/reports/screens/report_screen.dart';
import 'package:vocabualize/features/reports/services/report_screen_arguments.dart';

class EditSourceTargetDialog extends StatefulWidget {
  final Vocabulary vocabulary;
  final bool editTarget;

  const EditSourceTargetDialog({super.key, required this.vocabulary, this.editTarget = false});

  @override
  State<EditSourceTargetDialog> createState() => _EditSourceTargetDialogState();
}

class _EditSourceTargetDialogState extends State<EditSourceTargetDialog> {
  TextEditingController controller = TextEditingController();
  String input = "";

  void _reportTranslation() {
    Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportScreenArguments.translation(vocabulary: widget.vocabulary));
  }

  void _submit() async {
    if (input.isEmpty || !_hasChanged()) return Navigator.pop(context);
    if (widget.editTarget) {
      widget.vocabulary.target = input;
      Navigator.pop(context);
    } else {
      bool hasClickedReplace = await Messenger.showAnimatedDialog(ReplaceVocabularyDialog(vocabulary: widget.vocabulary));
      if (hasClickedReplace) {
        if (mounted) Provider.of<VocabularyProvider>(context, listen: false).remove(widget.vocabulary);
        RecordService.validateAndSave(source: input);
      } else {
        widget.vocabulary.source = input;
        if (mounted) Navigator.pop(context);
      }
    }
  }

  bool _hasChanged() {
    if (widget.editTarget) {
      return input != widget.vocabulary.target;
    } else {
      return input != widget.vocabulary.source;
    }
  }

  @override
  void initState() {
    super.initState();
    controller.text = widget.editTarget ? widget.vocabulary.target : widget.vocabulary.source;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 64),
      contentPadding: EdgeInsets.fromLTRB(12, 12, 8, widget.editTarget ? 8 : 12),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
                    decoration: InputDecoration(
                      hintText: widget.editTarget ? widget.vocabulary.target : widget.vocabulary.source,
                      // TODO: Replace with arb
                      label: widget.editTarget ? const Text("Target") : const Text("Source"),
                    ),
                    onChanged: (text) => setState(() => input = text),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => _submit(),
                  icon: Icon(input.isNotEmpty && _hasChanged() ? Icons.save_rounded : Icons.close_rounded),
                ),
              ],
            ),
            !widget.editTarget
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: TextButton(
                      onPressed: () => _reportTranslation(),
                      child: Text(
                        // TODO: Replace with arb
                        "Report faulty translation",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
