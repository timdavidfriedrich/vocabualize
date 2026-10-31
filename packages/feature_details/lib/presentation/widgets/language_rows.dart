import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/edit_language_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/language_label.dart';

const _textMaxLines = 2;

class const LanguageRows({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => switch (state) {
        final DetailsEditing editing when !editing.isSingleLayout => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final language in editing.activeLanguages)
              _LanguageRow(editing: editing, language: language, hasSwitch: true),
            for (final language in editing.askMeInLanguages)
              _LanguageRow(editing: editing, language: language, hasSwitch: false),
            if (editing.pausedLanguages.isNotEmpty)
              ExpansionTile(
                tilePadding: EdgeInsets.zero,
                childrenPadding: EdgeInsets.zero,
                shape: const Border(),
                collapsedShape: const Border(),
                title: Text(
                  context.s.detailsPausedLanguagesTitle(editing.pausedLanguages.length),
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
                children: [
                  for (final language in editing.pausedLanguages)
                    _LanguageRow(editing: editing, language: language, hasSwitch: true),
                ],
              ),
            const SizedBox(height: Spacing.s),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _LanguageRow({
  required final DetailsEditing _editing,
  required final Language _language,
  required final bool _hasSwitch,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    final text = _editing.textOf(_language);
    final isEnabled = _editing.enabledLanguages.contains(_language);
    return Row(
      children: [
        LanguageLabel(language: _language, showsName: false, style: context.t.titleLarge),
        const SizedBox(width: Spacing.s),
        Expanded(
          child: text.isEmpty && _editing.translatingLanguages.contains(_language)
              ? const Align(alignment: Alignment.centerLeft, child: ButtonProgress())
              : TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () => editLanguageText(context, _editing, _language),
                  child: Text(
                    text.isEmpty ? _language.toLabel(context) : text,
                    maxLines: _textMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: text.isEmpty || (_hasSwitch && !isEnabled)
                        ? context.t.bodyLarge?.copyWith(color: context.c.outline)
                        : context.t.bodyLarge,
                  ),
                ),
        ),
        IconButton(
          onPressed: text.isEmpty
              ? null
              : () => bloc.add(DetailsSpeakRequested(language: _language)),
          tooltip: context.s.vocabularySpeakTooltip,
          icon: const Icon(Icons.volume_up_rounded),
        ),
        if (_hasSwitch)
          Semantics(
            label: context.s.detailsLearnSwitchLabel(_language.toLabel(context)),
            child: Switch(
              value: isEnabled,
              onChanged: _editing.canSwitchOff(_language) && _editing.runningAction == null
                  ? (_) => bloc.add(DetailsLanguageToggled(language: _language))
                  : null,
            ),
          ),
      ],
    );
  }
}
