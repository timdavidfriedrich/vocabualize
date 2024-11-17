import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/features/reports/presentation/screens/report_screen.dart';

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
      if (_controller.text.isEmpty || !hasChanged()) {
        return Navigator.pop(context);
      }
      final updatedVocabulary = switch (widget.editTarget) {
        true => widget.vocabulary.copyWith(target: _controller.text),
        false => widget.vocabulary.copyWith(source: _controller.text),
      };
      Navigator.pop<Vocabulary>(context, updatedVocabulary);
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
                    decoration: InputDecoration(
                      hintText: switch (widget.editTarget) {
                        true => widget.vocabulary.target,
                        false => widget.vocabulary.source,
                      },
                      // TODO: Replace with arb
                      label: switch (widget.editTarget) {
                        true => const Text("Target"),
                        false => const Text("Source"),
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () => submit(),
                  icon: switch (_controller.text.isNotEmpty && hasChanged()) {
                    true => const Icon(Icons.save_rounded),
                    false => const Icon(Icons.close_rounded),
                  },
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
