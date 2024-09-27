import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/details/widgets/replace_vocabulary_dialog.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';
import 'package:vocabualize/src/features/reports/screens/report_screen.dart';
import 'package:vocabualize/src/features/reports/utils/report_arguments.dart';

class EditSourceTargetDialog extends ConsumerStatefulWidget {
  final Vocabulary vocabulary;
  final bool editTarget;

  const EditSourceTargetDialog({
    super.key,
    required this.vocabulary,
    this.editTarget = false,
  });

  @override
  ConsumerState<EditSourceTargetDialog> createState() => _EditSourceTargetDialogState();
}

class _EditSourceTargetDialogState extends ConsumerState<EditSourceTargetDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.editTarget ? widget.vocabulary.target : widget.vocabulary.source;
  }

  @override
  Widget build(BuildContext context) {
    void reportTranslation() {
      Navigator.pushNamed(
        context,
        ReportScreen.routeName,
        arguments: ReportArguments.translation(vocabulary: widget.vocabulary),
      );
    }

    bool hasChanged() {
      if (widget.editTarget) {
        return _controller.text != widget.vocabulary.target;
      } else {
        return _controller.text != widget.vocabulary.source;
      }
    }

    void submit() async {
      if (_controller.text.isEmpty || !hasChanged()) return Navigator.pop(context);
      if (widget.editTarget) {
        final updatedVocabulary = widget.vocabulary.copyWith(target: _controller.text);
        ref.read(updateVocabularyUseCaseProvider(updatedVocabulary));
        Navigator.pop(context);
      } else {
        bool hasClickedReplace = await HelperWidgets.showStaticDialog(
          ReplaceVocabularyDialog(vocabulary: widget.vocabulary),
        );
        if (hasClickedReplace) {
          if (mounted) {
            ref.read(deleteVocabularyUseCaseProvider(widget.vocabulary));
          }
          // TODO ARCHITECTURE: Replace RecordService() with use case
          RecordService().validateAndSave(unwantedRef: ref, source: _controller.text);
        } else {
          final updatedVocabulary = widget.vocabulary.copyWith(source: _controller.text);
          ref.read(updateVocabularyUseCaseProvider(updatedVocabulary));
          if (context.mounted) Navigator.pop(context);
        }
      }
    }

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
                    controller: _controller,
                    // TODO: Update deprecated toolbar options for EditSourceTargetDialog
                    toolbarOptions: const ToolbarOptions(
                      copy: false,
                      cut: false,
                      paste: false,
                      selectAll: false,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.editTarget ? widget.vocabulary.target : widget.vocabulary.source,
                      // TODO: Replace with arb
                      label: widget.editTarget ? const Text("Target") : const Text("Source"),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => submit(),
                  icon: Icon(
                    _controller.text.isNotEmpty && hasChanged() ? Icons.save_rounded : Icons.close_rounded,
                  ),
                ),
              ],
            ),
            if (widget.editTarget)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextButton(
                  onPressed: () => reportTranslation(),
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
