import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/send_text_field.dart';
import 'package:shared/presentation/widgets/word_language_chip.dart';

typedef WrittenWord = ({String text, Language language});

Future<WrittenWord?> requestsWrittenWord(
  BuildContext context, {
  required LanguageSetup setup,
}) {
  return showDialog<WrittenWord>(
    context: context,
    builder: (dialogContext) => _WriteWordDialog(setup: setup),
  );
}

class const _WriteWordDialog({
  required final LanguageSetup _setup,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final language = useState(_setup.main);
    return Dialog(
      alignment: Alignment.bottomCenter,
      insetPadding: const EdgeInsets.all(Spacing.s),
      backgroundColor: context.c.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Spacing.l, Spacing.xs, Spacing.l, Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(context.s.homeWriteTitle, style: context.t.titleLarge)),
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
              hintText: context.s.homeWriteHint,
              prefix: _setup.writingLanguages.length > 1
                  ? WordLanguageChip(
                      setup: _setup,
                      selected: language.value,
                      onSelected: (selected) => language.value = selected,
                    )
                  : null,
              onSubmitted: (text) =>
                  Navigator.of(context).pop((text: text, language: language.value)),
            ),
          ],
        ),
      ),
    );
  }
}
