import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

Future<bool> confirmsLanguageDelete(
  BuildContext context, {
  required Language language,
  required int? wordCount,
  required List<Language> keptLanguages,
}) async {
  final label = language.toShortLabel(context);
  final isConfirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => Dialog(
      backgroundColor: context.c.surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusXxxl)),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(context.s.languageDeleteTitle(label), style: context.t.headlineSmall),
            const SizedBox(height: Spacing.l),
            _Heading(text: context.s.languageDeleteDeletedLabel, color: context.c.error),
            _Line(text: context.s.languageDeleteProgressLine(label, wordCount ?? 0)),
            const SizedBox(height: Spacing.s),
            _Heading(text: context.s.languageDeleteKeptLabel, color: context.c.primary),
            _Line(text: context.s.languageDeleteWordsLine),
            for (final kept in keptLanguages)
              _Line(text: context.s.languageDeleteKeptProgressLine(kept.toShortLabel(context))),
            const SizedBox(height: Spacing.xl),
            TonalButton(
              isDestructive: true,
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.s.languageDeleteButton(label)),
            ),
            const SizedBox(height: Spacing.s),
            TonalButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.s.cancel),
            ),
          ],
        ),
      ),
    ),
  );
  return isConfirmed ?? false;
}

class const _Heading({
  required final String _text,
  required final Color _color,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xxs),
      child: Text(_text, style: context.t.labelLarge?.copyWith(color: _color)),
    );
  }
}

class const _Line({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xxs),
      child: Text(_text, style: context.t.bodyLarge),
    );
  }
}
