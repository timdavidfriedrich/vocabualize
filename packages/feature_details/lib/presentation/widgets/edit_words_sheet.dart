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
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/filled_text_field.dart';
import 'package:shared/presentation/widgets/language_segments.dart';

typedef _WordField = ({
  String text,
  bool canReport,
});

typedef _SheetResult = ({
  Map<Language, String> texts,
  Set<Language> enabledLanguages,
  Language selected,
  bool wantsNewLanguage,
});

Future<void> editWords(
  BuildContext context,
  DetailsEditing editing, {
  required Language shown,
  required ValueChanged<Language> onShown,
}) async {
  final bloc = context.read<DetailsBloc>();
  final isVertical = editing.hasSeveralLanguages;
  final learned = editing.learnedLanguages.toSet();
  final languages = {
    editing.setup.main,
    if (isVertical) ...[...editing.askMeInLanguages, ...editing.learnedLanguages] else shown,
  }.toList();
  final result = await showModalBottomSheet<_SheetResult>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (sheetContext) => _EditWordsSheet(
      languages: languages,
      initialLanguage: shown,
      isVertical: isVertical,
      main: editing.setup.main,
      learnedLanguages: learned,
      enabledLanguages: editing.enabledLanguages,
      askedFor: {
        for (final language in languages)
          language: [
            for (final learnedLanguage in editing.setup.learned)
              if (learnedLanguage.askMeIn == language) learnedLanguage.language,
          ],
      },
      fields: {
        for (final language in languages)
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
  if (result == null || !context.mounted) return;
  if (learned.contains(result.selected) && result.enabledLanguages.contains(result.selected)) {
    onShown(result.selected);
  }
  final retranslates =
      result.texts.containsKey(editing.enteredLanguage) &&
      context.mounted &&
      await confirmsRetranslation(context);
  bloc.add(
    DetailsWordEdited(
      texts: result.texts,
      enabledLanguages: result.enabledLanguages,
      retranslates: retranslates,
    ),
  );
  if (result.wantsNewLanguage && context.mounted) await context.pushLanguages();
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
  required final bool _isVertical,
  required final Language _main,
  required final Set<Language> _learnedLanguages,
  required final Set<Language> _enabledLanguages,
  required final Map<Language, List<Language>> _askedFor,
  required final Map<Language, _WordField> _fields,
  required final ValueChanged<Language> _onSpeak,
  required final ValueChanged<Language> _onReport,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final selected = useState(_initialLanguage);
    final enabled = useState(_enabledLanguages);
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

    _SheetResult result({required bool wantsNewLanguage}) {
      edits[selected.value] = controller.text;
      return (
        texts: {
          for (final language in _languages)
            if (edits[language]?.trim() case final text?
                when text.isNotEmpty && text != _fields[language]?.text)
              language: text,
        },
        enabledLanguages: enabled.value,
        selected: selected.value,
        wantsNewLanguage: wantsNewLanguage,
      );
    }

    final language = selected.value;
    final isOn = enabled.value.contains(language);
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
                selected: language,
                onSelected: select,
                isVertical: _isVertical,
                inactiveLanguages: _learnedLanguages.difference(enabled.value),
              ),
              const SizedBox(height: Spacing.m),
              FilledTextField(
                controller: controller,
                style: context.t.bodyLarge,
                hintText: context.s.detailsMissingTextLabel(language.toLabel(context)),
                suffix: Padding(
                  padding: const EdgeInsets.only(right: Spacing.xs),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_fields[language]?.canReport ?? false)
                        IconButton(
                          style: IconButton.styleFrom(
                            foregroundColor: context.c.onSurfaceVariant,
                          ),
                          onPressed: () => _onReport(language),
                          tooltip: context.s.detailsReportTranslationButton,
                          icon: const Icon(Icons.flag_outlined),
                        ),
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: context.c.surface,
                          foregroundColor: context.c.primary,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () => _onSpeak(language),
                        tooltip: context.s.vocabularySpeakTooltip,
                        icon: const Icon(Icons.volume_up_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              if (_isVertical)
                Stack(
                  children: [
                    for (final measured in _languages)
                      Visibility.maintain(
                        visible: false,
                        child: _LanguageNotes(
                          language: measured,
                          main: _main,
                          askedFor: _askedFor[measured] ?? const [],
                          isLearned: _learnedLanguages.contains(measured),
                          isOn: true,
                          isLastOn: true,
                        ),
                      ),
                    _LanguageNotes(
                      language: language,
                      main: _main,
                      askedFor: _askedFor[language] ?? const [],
                      isLearned: _learnedLanguages.contains(language),
                      isOn: isOn,
                      isLastOn: isOn && enabled.value.length == 1,
                      onChanged: (isTurnedOn) => enabled.value = isTurnedOn
                          ? {...enabled.value, language}
                          : enabled.value.difference({language}),
                    ),
                  ],
                ),
              if (_isVertical)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () => Navigator.of(context).pop(result(wantsNewLanguage: true)),
                    icon: const Icon(Icons.add_rounded),
                    label: Text(context.s.detailsAddLanguageButton),
                  ),
                ),
              const SizedBox(height: Spacing.l),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(result(wantsNewLanguage: false)),
                child: Text(context.s.detailsDoneButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _LanguageNotes({
  required final Language _language,
  required final Language _main,
  required final List<Language> _askedFor,
  required final bool _isLearned,
  required final bool _isOn,
  required final bool _isLastOn,
  final ValueChanged<bool>? _onChanged,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noteStyle = context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant);
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.l, top: Spacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Spacing.xxs,
        children: [
          if (_isLearned) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.s.detailsLearnSwitchLabel(_language.toShortLabel(context)),
                    style: context.t.bodyLarge,
                  ),
                ),
                Switch(value: _isOn, onChanged: _isLastOn ? null : _onChanged),
              ],
            ),
            if (_isLastOn) Text(context.s.detailsLastLanguageHint, style: noteStyle),
          ],
          if (_askedFor.isNotEmpty)
            Text(
              context.s.detailsAskMeInNote(
                [for (final learned in _askedFor) learned.toShortLabel(context)].join(", "),
                _language.toShortLabel(context),
                _main.toShortLabel(context),
              ),
              style: noteStyle,
            ),
        ],
      ),
    );
  }
}
