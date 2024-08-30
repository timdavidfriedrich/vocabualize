import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/widgets/replace_vocabulary_dialog.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';

class EditSourceTargetDialog extends StatefulWidget {
  final Vocabulary vocabulary;
  final bool editTarget;

  const EditSourceTargetDialog({super.key, required this.vocabulary, this.editTarget = false});

  @override
  State<EditSourceTargetDialog> createState() => _EditSourceTargetDialogState();
}

class _EditSourceTargetDialogState extends State<EditSourceTargetDialog> {
  final deleteVocabulary = sl.get<DeleteVocabularyUseCase>();
  final updateVocabulary = sl.get<UpdateVocabularyUseCase>();
  TextEditingController controller = TextEditingController();
  String input = "";

  void _reportTranslation() {
    Navigator.pushNamed(context, ReportScreen.routeName, arguments: ReportArguments.translation(vocabulary: widget.vocabulary));
  }

  void _submit() async {
    if (input.isEmpty || !_hasChanged()) return Navigator.pop(context);
    if (widget.editTarget) {
      final updatedVocabulary = widget.vocabulary.copyWith(target: input);
      updateVocabulary(updatedVocabulary);
      Navigator.pop(context);
    } else {
      bool hasClickedReplace = await HelperWidgets.showStaticDialog(ReplaceVocabularyDialog(vocabulary: widget.vocabulary));
      if (hasClickedReplace) {
        if (mounted) deleteVocabulary(widget.vocabulary);
        RecordService().validateAndSave(source: input);
      } else {
        final updatedVocabulary = widget.vocabulary.copyWith(source: input);
        updateVocabulary(updatedVocabulary);
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
