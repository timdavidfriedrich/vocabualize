import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

Future<bool> confirmsAddingLanguage(
  BuildContext context, {
  required String text,
  required Vocabulary vocabulary,
  required Language language,
  required Language knownLanguage,
}) async {
  final addsLanguage = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog.adaptive(
      title: Text(context.s.detailsExistingTitle),
      content: Text(
        context.s.detailsExistingMessage(
          text,
          knownLanguage.toLabel(context),
          vocabulary.textIn(knownLanguage) ?? "",
          language.toLabel(context),
        ),
      ),
      actionsPadding: const EdgeInsets.all(Spacing.m),
      actions: [
        AdaptiveActions(
          spacing: Spacing.xs,
          stackedSpacing: Spacing.xxs,
          children: [
            OutlinedButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.s.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.s.detailsExistingAddButton(language.toLabel(context))),
            ),
          ],
        ),
      ],
    ),
  );
  return addsLanguage ?? false;
}
