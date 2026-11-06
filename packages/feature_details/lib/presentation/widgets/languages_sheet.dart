import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_language_extensions.dart';
import 'package:feature_details/presentation/widgets/edit_words_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _textMaxLines = 2;

Future<void> showLanguagesSheet(
  BuildContext context, {
  required Language shown,
  required ValueChanged<Language> onShown,
}) {
  final bloc = context.read<DetailsBloc>();
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: context.c.surfaceContainerLowest,
    builder: (sheetContext) => BlocProvider.value(
      value: bloc,
      child: _LanguagesSheet(shown: shown, onShown: onShown),
    ),
  );
}

class const _LanguagesSheet({
  required final Language _shown,
  required final ValueChanged<Language> _onShown,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) => switch (state) {
          final DetailsEditing editing => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              Spacing.m,
              0,
              Spacing.m,
              Spacing.m,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: Spacing.xs,
              children: [
                for (final language in editing.learnedLanguages)
                  _LearnedCard(
                    editing: editing,
                    language: language,
                    isShown: language == _shown,
                    onShown: () {
                      _onShown(language);
                      Navigator.of(context).pop();
                    },
                  ),
                for (final language in editing.askMeInLanguages)
                  _LanguageRow(editing: editing, language: language, isAskMeIn: true),
                _LanguageRow(editing: editing, language: editing.setup.main, isAskMeIn: false),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      context.pushLanguages();
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: Text(
                      context.s.detailsAddLanguageButton,
                      style: context.t.titleMedium?.copyWith(color: context.c.primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }
}

class const _LearnedCard({
  required final DetailsEditing _editing,
  required final Language _language,
  required final bool _isShown,
  required final VoidCallback _onShown,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    final isEnabled = _editing.enabledLanguages.contains(_language);
    final learned = _editing.setup.learnedOf(_language);
    final label = _language.toLabel(context);
    final subtitle = switch ((isEnabled, learned)) {
      (false, _) => context.s.detailsNotLearningLabel(label),
      (true, LearnedLanguage(isPaused: true)) => context.s.detailsPausedRoleLabel(label),
      (true, LearnedLanguage(:final askMeIn?)) => context.s.detailsAsksInLabel(
        label,
        askMeIn.toShortLabel(context),
      ),
      (true, _) => label,
    };
    return Material(
      color: _isShown ? context.c.primaryContainer : context.c.surfaceContainerLow,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: isEnabled && !_isShown ? _onShown : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.xxs, Spacing.s),
          child: Row(
            children: [
              Text(_language.toFlag(), style: context.t.titleLarge),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: _Texts(
                  editing: _editing,
                  language: _language,
                  subtitle: subtitle,
                  style: context.t.titleMedium?.copyWith(
                    color: isEnabled ? null : context.c.onSurfaceVariant,
                  ),
                ),
              ),
              Semantics(
                label: context.s.detailsLearnSwitchLabel(label),
                child: Switch(
                  value: isEnabled,
                  onChanged: _editing.canSwitchOff(_language) && _editing.runningAction == null
                      ? (_) => bloc.add(DetailsLanguageToggled(language: _language))
                      : null,
                ),
              ),
              _EditButton(editing: _editing, language: _language),
            ],
          ),
        ),
      ),
    );
  }
}

class const _LanguageRow({
  required final DetailsEditing _editing,
  required final Language _language,
  required final bool _isAskMeIn,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.xxs, Spacing.s),
      child: Row(
        children: [
          Text(_language.toFlag(), style: context.t.titleLarge),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: _Texts(
              editing: _editing,
              language: _language,
              subtitle: _language.toRoleLabel(context, _editing),
              style: context.t.bodyLarge,
            ),
          ),
          if (_isAskMeIn)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xs),
              decoration: BoxDecoration(
                color: context.c.surfaceContainer,
                borderRadius: BorderRadius.circular(Spacing.radiusM),
              ),
              child: Text(context.s.learnedLanguageAskMeInLabel, style: context.t.labelLarge),
            ),
          _EditButton(editing: _editing, language: _language),
        ],
      ),
    );
  }
}

class const _Texts({
  required final DetailsEditing _editing,
  required final Language _language,
  required final String _subtitle,
  required final TextStyle? _style,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = _editing.textOf(_language);
    final isTranslating = text.isEmpty && _editing.translatingLanguages.contains(_language);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isTranslating)
          const ButtonProgress()
        else
          Text(
            text.isEmpty ? _language.toLabel(context) : text,
            maxLines: _textMaxLines,
            overflow: TextOverflow.ellipsis,
            style: text.isEmpty ? _style?.copyWith(color: context.c.outline) : _style,
          ),
        Text(
          _subtitle,
          style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
        ),
      ],
    );
  }
}

class const _EditButton({
  required final DetailsEditing _editing,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _editing.runningAction == null
          ? () => editWords(context, _editing, languages: [_language])
          : null,
      tooltip: context.s.edit,
      icon: const Icon(Icons.edit_outlined),
    );
  }
}
