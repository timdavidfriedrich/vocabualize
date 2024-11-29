import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/dimensions.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/presentation/extensions/context_extensions.dart';
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
  ConsumerState<EditSourceTargetDialog> createState() =>
      _EditSourceTargetDialogState();
}

class _EditSourceTargetDialogState
    extends ConsumerState<EditSourceTargetDialog> {
  final TextEditingController _controller = TextEditingController();

  bool hasChanged = false;

  bool checkIfhasChanged(String input) {
    if (widget.editTarget) {
      return input != widget.vocabulary.target;
    } else {
      return input != widget.vocabulary.source;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text =
        widget.editTarget ? widget.vocabulary.target : widget.vocabulary.source;
  }

  @override
  Widget build(BuildContext context) {
    void submitOrCancel() async {
      if (_controller.text.isEmpty || !hasChanged) {
        return context.pop();
      }
      final updatedVocabulary = switch (widget.editTarget) {
        true => widget.vocabulary.copyWith(target: _controller.text),
        false => widget.vocabulary.copyWith(source: _controller.text),
      };
      context.pop<Vocabulary>(updatedVocabulary);
    }

    return AlertDialog.adaptive(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: Dimensions.extraExtraLargeSpacing,
      ),
      contentPadding: EdgeInsets.only(
        left: Dimensions.semiSmallSpacing,
        right: Dimensions.semiSmallSpacing,
        top: Dimensions.smallSpacing,
        bottom: widget.editTarget
            ? Dimensions.smallSpacing
            : Dimensions.semiSmallSpacing,
      ),
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
                    onChanged: (value) {
                      setState(() {
                        hasChanged = checkIfhasChanged(value);
                      });
                    },
                    decoration: InputDecoration(
                      hintText: widget.editTarget
                          ? widget.vocabulary.target
                          : widget.vocabulary.source,
                      // TODO: Replace with arb
                      label: Text(widget.editTarget ? "Target" : "Source"),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: submitOrCancel,
                  icon: switch (_controller.text.isNotEmpty && hasChanged) {
                    true => const Icon(Icons.save_rounded),
                    false => const Icon(Icons.close_rounded),
                  },
                ),
              ],
            ),
            if (widget.editTarget) ...[
              const SizedBox(height: Dimensions.smallSpacing),
              _ReportTranslationButton(vocabulary: widget.vocabulary),
            ]
          ],
        ),
      ),
    );
  }
}

class _ReportTranslationButton extends StatelessWidget {
  final Vocabulary vocabulary;
  const _ReportTranslationButton({required this.vocabulary});

  @override
  Widget build(BuildContext context) {
    void reportTranslation() {
      context.pushNamed(
        ReportScreen.routeName,
        arguments: ReportArguments.translation(vocabulary: vocabulary),
      );
    }

    return TextButton(
      onPressed: () => reportTranslation(),
      child: Text(
        // TODO: Replace with arb
        "Report faulty translation",
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
      ),
    );
  }
}
