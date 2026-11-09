import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/practice/practice_bloc.dart';
import 'package:feature_practice/presentation/practice/practice_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/practice_card.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';
import 'package:shared/presentation/widgets/language_segments.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

sealed class _EditResult {
  const _EditResult();
}

class const _TextsEdited({
  required final Map<Language, String> texts,
}) extends _EditResult;

class const _FullEditingRequested() extends _EditResult;

Future<void> editPracticeWord(
  BuildContext context, {
  required PracticeCard card,
  required Language main,
}) async {
  final bloc = context.read<PracticeBloc>();
  final vocabulary = card.item.vocabulary;
  final languages = {main, card.prompt, card.item.language}.toList();
  final result = await showModalBottomSheet<_EditResult>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (_) => _EditWordSheet(
      languages: languages,
      texts: {for (final language in languages) language: vocabulary.textIn(language) ?? ""},
      initialLanguage: card.item.language,
      onSpeak: (text, language) =>
          bloc.add(PracticeTextSpeakRequested(text: text, language: language)),
    ),
  );
  switch (result) {
    case _TextsEdited(:final texts) when texts.isNotEmpty:
      bloc.add(PracticeTextsSaved(texts: texts));
    case _FullEditingRequested() when context.mounted:
      await context.pushEditVocabularyDetailsUntilClosed(vocabularyId: vocabulary.id);
      bloc.add(const PracticeDetailsClosed());
    case _TextsEdited() || _FullEditingRequested() || null:
      break;
  }
}

class const _EditWordSheet({
  required final List<Language> _languages,
  required final Map<Language, String> _texts,
  required final Language _initialLanguage,
  required final void Function(String text, Language language) _onSpeak,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selected = useState(_initialLanguage);
    final edits = useMemoized(() => Map.of(_texts));
    final controller = useTextEditingController(text: _texts[_initialLanguage]);
    void select(Language language) {
      edits[selected.value] = controller.text;
      selected.value = language;
      final text = edits[language] ?? "";
      controller.value = TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }

    Map<Language, String> changes() {
      edits[selected.value] = controller.text;
      return {
        for (final language in _languages)
          if (edits[language]?.trim() case final text?
              when text.isNotEmpty && text != _texts[language])
            language: text,
      };
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(Spacing.xl, 0, Spacing.xl, Spacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(context.s.practiceEditTitle, style: context.t.headlineSmall),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: context.s.close,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.l),
              if (_languages.length > 1) ...[
                LanguageSegments(
                  languages: _languages,
                  selected: selected.value,
                  onSelected: select,
                ),
                const SizedBox(height: Spacing.m),
              ],
              FilledTextField(
                controller: controller,
                style: context.t.bodyLarge,
                suffix: Padding(
                  padding: const EdgeInsets.only(right: Spacing.xs),
                  child: IconButton.filled(
                    style: IconButton.styleFrom(
                      backgroundColor: context.c.surface,
                      foregroundColor: context.c.primary,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () => _onSpeak(controller.text, selected.value),
                    tooltip: context.s.vocabularySpeakTooltip,
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.l),
              Row(
                children: [
                  Expanded(
                    child: TonalButton(
                      onPressed: () => Navigator.of(context).pop(const _FullEditingRequested()),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.open_in_new_rounded),
                          const SizedBox(width: Spacing.xs),
                          Flexible(
                            child: Text(
                              context.s.practiceEditFullButton,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.s),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(_TextsEdited(texts: changes())),
                      child: Text(context.s.practiceEditSaveButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
