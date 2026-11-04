import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/widgets/language_option_row.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

Future<Language?> requestsLanguage(
  BuildContext context, {
  required List<Language> options,
  Set<Language> paused = const {},
}) {
  return showModalBottomSheet<Language>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    backgroundColor: context.c.surface,
    builder: (sheetContext) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
            child: Text(context.s.languagesPickTitle, style: context.t.headlineSmall),
          ),
          const SizedBox(height: Spacing.m),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
              itemCount: options.length,
              separatorBuilder: (_, _) => const SizedBox(height: Spacing.xs),
              itemBuilder: (context, index) {
                final language = options[index];
                return LanguageOptionRow(
                  language: language,
                  isSelected: false,
                  onTap: () => Navigator.of(sheetContext).pop(language),
                  trailing: paused.contains(language)
                      ? Text(
                          context.s.languagesPausedTitle,
                          style: context.t.bodyMedium?.copyWith(
                            color: context.c.onSurfaceVariant,
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
