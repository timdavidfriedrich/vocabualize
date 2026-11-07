import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/vocabulary.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/photo_stack.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _photoSize = Spacing.xxxxl;

class const LanguageImportCard({
  super.key,
  required final Language _language,
  required final Language? _source,
  required final int _sourceCount,
  required final List<Vocabulary> _words,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = _language.toShortLabel(context);
    return Container(
      padding: const EdgeInsets.all(Spacing.l),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_words.isNotEmpty) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: PhotoStack(
                images: [for (final word in _words) word.image],
                size: _photoSize,
                borderColor: context.c.surfaceContainerLow,
                moreCount: _sourceCount - _words.length,
              ),
            ),
            const SizedBox(height: Spacing.m),
          ],
          Text(context.s.homeEmptyLanguageTitle(label), style: context.t.titleLarge),
          const SizedBox(height: Spacing.s),
          Text(
            switch (_source) {
              final source? => context.s.homeEmptyLanguageMessage(
                _sourceCount,
                source.toShortLabel(context),
                label,
              ),
              null => context.s.homeEmptyLanguageNoSourceMessage(label),
            },
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
          const SizedBox(height: Spacing.l),
          TonalButton(
            onPressed: () => context.pushLanguageWords(language: _language, isAdding: false),
            child: Text(context.s.homeImportWordsButton),
          ),
        ],
      ),
    );
  }
}
