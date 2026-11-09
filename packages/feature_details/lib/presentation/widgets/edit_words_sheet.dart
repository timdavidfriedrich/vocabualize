import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_editing_extensions.dart';
import 'package:feature_details/presentation/widgets/replace_dialog.dart';
import 'package:feature_details/presentation/widgets/report_translation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';
import 'package:shared/presentation/widgets/language_segments.dart';

typedef _WordField = ({
  String text,
  bool canReport,
});

Future<void> editWords(
  BuildContext context,
  DetailsEditing editing, {
  required List<Language> languages,
}) async {
  final bloc = context.read<DetailsBloc>();
  final ordered = [
    if (languages.contains(editing.setup.main)) editing.setup.main,
    for (final language in languages)
      if (language != editing.setup.main) language,
  ];
  final edits = await showModalBottomSheet<Map<Language, String>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (sheetContext) => _EditWordsSheet(
      languages: ordered,
      initialLanguage: languages.first,
      fields: {
        for (final language in ordered)
          language: (
            text: editing.textOf(language),
            canReport:
                language != editing.enteredLanguage &&
                editing.textOf(language).isNotEmpty &&
                editing.texts[language]?.origin == TranslationOrigin.translated,
          ),
      },
      onSpeak: (language) => bloc.add(DetailsSpeakRequested(language: language)),
      onReport: (language) => _report(context, editing, language),
    ),
  );
  if (edits == null || !context.mounted) return;
  final changes = [
    for (final entry in edits.entries)
      if (entry.key != editing.enteredLanguage) entry,
    for (final entry in edits.entries)
      if (entry.key == editing.enteredLanguage) entry,
  ];
  for (final MapEntry(key: language, value: text) in changes) {
    final retranslates =
        language == editing.enteredLanguage &&
        context.mounted &&
        await confirmsRetranslation(context);
    bloc.add(DetailsTextChanged(language: language, text: text, retranslates: retranslates));
  }
}

Future<void> _report(BuildContext context, DetailsEditing editing, Language language) async {
  final bloc = context.read<DetailsBloc>();
  final note = await requestsTranslationReportNote(
    context,
    source: editing.enteredText,
    target: editing.textOf(language),
  );
  if (note != null) bloc.add(DetailsTranslationReported(language: language, note: note));
}

class const _EditWordsSheet({
  required final List<Language> _languages,
  required final Language _initialLanguage,
  required final Map<Language, _WordField> _fields,
  required final ValueChanged<Language> _onSpeak,
  required final ValueChanged<Language> _onReport,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selected = useState(_initialLanguage);
    final edits = useMemoized(
      () => {for (final MapEntry(:key, :value) in _fields.entries) key: value.text},
    );
    final controller = useTextEditingController(text: _fields[_initialLanguage]?.text);
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
              when text.isNotEmpty && text != _fields[language]?.text)
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
                    child: Text(context.s.detailsEditWordTitle, style: context.t.headlineSmall),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: context.s.close,
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: Spacing.l),
              LanguageSegments(
                languages: _languages,
                selected: selected.value,
                onSelected: select,
              ),
              const SizedBox(height: Spacing.m),
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
                    onPressed: () => _onSpeak(selected.value),
                    tooltip: context.s.vocabularySpeakTooltip,
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ),
              ),
              if (_fields[selected.value]?.canReport ?? false)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(foregroundColor: context.c.onSurfaceVariant),
                    onPressed: () => _onReport(selected.value),
                    icon: const Icon(Icons.flag_outlined, size: Spacing.iconS),
                    label: Text(context.s.detailsReportTranslationButton),
                  ),
                ),
              const SizedBox(height: Spacing.l),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(changes()),
                child: Text(context.s.detailsDoneButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
