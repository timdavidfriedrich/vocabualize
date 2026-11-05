import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_language_extensions.dart';
import 'package:feature_details/presentation/widgets/replace_dialog.dart';
import 'package:feature_details/presentation/widgets/report_translation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

typedef _WordField = ({
  Language language,
  String label,
  String text,
  bool isLearned,
  bool canReport,
});

Future<void> editWords(
  BuildContext context,
  DetailsEditing editing, {
  required List<Language> languages,
}) async {
  final bloc = context.read<DetailsBloc>();
  final fields = [
    for (final language in languages)
      (
        language: language,
        label: language.toRoleLabel(context, editing),
        text: editing.textOf(language),
        isLearned: editing.setup.isLearning(language),
        canReport:
            language != editing.enteredLanguage &&
            editing.textOf(language).isNotEmpty &&
            editing.texts[language]?.origin == TranslationOrigin.translated,
      ),
  ];
  final edits = await showModalBottomSheet<Map<Language, String>>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (sheetContext) => _EditWordsSheet(
      title: languages.length == 1
          ? context.s.detailsEditWordTitle
          : context.s.detailsEditWordsTitle,
      fields: fields,
      onSpeak: (language) => bloc.add(DetailsSpeakRequested(language: language)),
      onReport: (language) => _report(context, editing, language),
    ),
  );
  if (edits == null || !context.mounted) return;
  final ordered = [
    for (final entry in edits.entries)
      if (entry.key != editing.enteredLanguage) entry,
    for (final entry in edits.entries)
      if (entry.key == editing.enteredLanguage) entry,
  ];
  for (final MapEntry(key: language, value: text) in ordered) {
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
  required final String _title,
  required final List<_WordField> _fields,
  required final ValueChanged<Language> _onSpeak,
  required final ValueChanged<Language> _onReport,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final edits = useMemoized(() => <Language, String>{});
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(
          Spacing.m,
          0,
          Spacing.m,
          Spacing.m + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.xxs),
              child: Text(_title, style: context.t.titleLarge),
            ),
            const SizedBox(height: Spacing.m),
            for (final field in _fields)
              _WordInput(
                field: field,
                onChanged: (text) => edits[field.language] = text,
                onSpeak: () => _onSpeak(field.language),
                onReport: field.canReport ? () => _onReport(field.language) : null,
              ),
            const SizedBox(height: Spacing.xs),
            Row(
              children: [
                Expanded(
                  child: TonalButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(context.s.cancel),
                  ),
                ),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop({
                      for (final field in _fields)
                        if (edits[field.language]?.trim() case final text?
                            when text.isNotEmpty && text != field.text)
                          field.language: text,
                    }),
                    child: Text(context.s.detailsDoneButton),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class const _WordInput({
  required final _WordField _field,
  required final ValueChanged<String> _onChanged,
  required final VoidCallback _onSpeak,
  required final VoidCallback? _onReport,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: _field.text);
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xxs),
            child: Row(
              children: [
                Text(_field.language.toFlag(), style: context.t.bodyLarge),
                const SizedBox(width: Spacing.s),
                Expanded(
                  child: Text(
                    _field.label,
                    style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: Spacing.xs),
          FilledTextField(
            controller: controller,
            style: _field.isLearned ? context.t.titleMedium : context.t.bodyLarge,
            onChanged: _onChanged,
            suffix: IconButton(
              onPressed: _onSpeak,
              tooltip: context.s.vocabularySpeakTooltip,
              icon: const Icon(Icons.volume_up_outlined),
            ),
          ),
          if (_onReport case final onReport?)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: context.c.onSurfaceVariant),
                onPressed: onReport,
                icon: const Icon(Icons.flag_outlined, size: Spacing.iconS),
                label: Text(context.s.detailsReportTranslationButton),
              ),
            ),
        ],
      ),
    );
  }
}
