import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const LanguageNotes({
  super.key,
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
              context.s.detailsAskMeInMessage(
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
