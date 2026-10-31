import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

Future<Language?> requestsLanguage(
  BuildContext context, {
  required List<Language> options,
  Set<Language> paused = const {},
}) {
  return showDialog<Language>(
    context: context,
    builder: (dialogContext) => SimpleDialog(
      title: Text(context.s.languagesPickTitle),
      children: [
        for (final language in options)
          ListTile(
            title: LanguageLabel(language: language),
            trailing: paused.contains(language) ? Text(context.s.languagesPausedTitle) : null,
            onTap: () => Navigator.of(dialogContext).pop(language),
          ),
      ],
    ),
  );
}
