import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/edit_text_dialog.dart';
import 'package:feature_details/presentation/widgets/replace_dialog.dart';
import 'package:feature_details/presentation/widgets/report_translation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/translation.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

Future<void> editLanguageText(
  BuildContext context,
  DetailsEditing editing,
  Language language,
) async {
  final bloc = context.read<DetailsBloc>();
  final current = editing.textOf(language);
  final isEntered = language == editing.enteredLanguage;
  final canReport =
      !isEntered &&
      current.isNotEmpty &&
      editing.texts[language]?.origin == TranslationOrigin.translated;
  final text = await requestsEditedText(
    context,
    text: current,
    label: language.toLabel(context),
    onReportRequested: canReport ? () => _report(context, editing, language) : null,
  );
  if (text == null || text.trim() == current || !context.mounted) return;
  final retranslates = isEntered && await confirmsRetranslation(context);
  bloc.add(DetailsTextChanged(language: language, text: text, retranslates: retranslates));
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
