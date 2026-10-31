import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

const _maxLines = 2;

typedef WrittenWord = ({String text, Language language});

Future<WrittenWord?> requestsWrittenWord(
  BuildContext context, {
  required List<Language> languages,
}) {
  return showDialog<WrittenWord>(
    context: context,
    builder: (dialogContext) => _WriteWordDialog(languages: languages),
  );
}

class const _WriteWordDialog({
  required final List<Language> _languages,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final language = useState(_languages.first);
    final hasText = useListenableSelector(controller, () => controller.text.trim().isNotEmpty);
    void submit() => Navigator.of(
      context,
    ).pop(hasText ? (text: controller.text.trim(), language: language.value) : null);
    return AlertDialog.adaptive(
      contentPadding: const EdgeInsets.all(Spacing.s),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_languages.length > 1)
            Wrap(
              spacing: Spacing.xs,
              runSpacing: Spacing.xs,
              children: [
                for (final option in _languages)
                  ChoiceChip(
                    label: LanguageLabel(language: option),
                    selected: option == language.value,
                    onSelected: (_) => language.value = option,
                  ),
              ],
            ),
          if (_languages.length > 1) const SizedBox(height: Spacing.s),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  onSubmitted: (_) => submit(),
                  minLines: 1,
                  maxLines: _maxLines,
                  decoration: InputDecoration(hintText: context.s.homeWriteHint),
                ),
              ),
              const SizedBox(width: Spacing.xs),
              IconButton(
                onPressed: submit,
                icon: Icon(hasText ? Icons.arrow_forward_rounded : Icons.close_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
