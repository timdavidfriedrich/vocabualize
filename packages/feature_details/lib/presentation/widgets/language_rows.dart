import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/widgets/edit_language_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/section_title.dart';

const _textMaxLines = 2;
const _roundButtonSize = Spacing.xxxl - Spacing.xxxs;
const _expandDuration = Duration(milliseconds: 200);

class const LanguageRows({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) => switch (state) {
        final DetailsEditing editing => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: Spacing.xs,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: Spacing.xxxs, bottom: Spacing.xxs),
              child: SectionTitle(title: context.s.detailsLanguagesTitle),
            ),
            for (final language in editing.activeLanguages)
              _LearnedCard(editing: editing, language: language),
            _LanguageRow(
              editing: editing,
              language: editing.setup.main,
              role: context.s.languagesSpeakTitle,
            ),
            for (final language in editing.askMeInLanguages)
              _LanguageRow(
                editing: editing,
                language: language,
                role: context.s.learnedLanguageAskMeInLabel,
              ),
            if (editing.pausedLanguages.isNotEmpty) _PausedLanguages(editing: editing),
          ],
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _LearnedCard({
  required final DetailsEditing _editing,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    final isEnabled = _editing.enabledLanguages.contains(_language);
    final label = _language.toLabel(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.s, Spacing.s),
      decoration: BoxDecoration(
        color: isEnabled ? context.c.primaryContainer : context.c.surfaceContainerLow,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(_language.toFlag(), style: context.t.titleMedium),
              const SizedBox(width: Spacing.s),
              Expanded(
                child: Text(
                  isEnabled ? label : context.s.detailsNotLearningLabel(label),
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                  overflow: TextOverflow.ellipsis,
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
            ],
          ),
          const SizedBox(height: Spacing.xs),
          Row(
            children: [
              Expanded(
                child: _Text(
                  editing: _editing,
                  language: _language,
                  style: context.t.headlineSmall?.copyWith(
                    color: isEnabled ? null : context.c.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: Spacing.xs),
              _RoundButton(
                icon: Icons.edit_outlined,
                tooltip: context.s.edit,
                isHighlighted: isEnabled,
                onPressed: () => editLanguageText(context, _editing, _language),
              ),
              const SizedBox(width: Spacing.xs),
              _RoundButton(
                icon: Icons.volume_up_outlined,
                tooltip: context.s.vocabularySpeakTooltip,
                isHighlighted: isEnabled,
                onPressed: _editing.textOf(_language).isEmpty
                    ? null
                    : () => bloc.add(DetailsSpeakRequested(language: _language)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class const _LanguageRow({
  required final DetailsEditing _editing,
  required final Language _language,
  required final String _role,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXl),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => editLanguageText(context, _editing, _language),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.xxs, Spacing.s),
          child: Row(
            children: [
              Text(_language.toFlag(), style: context.t.titleLarge),
              const SizedBox(width: Spacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Text(editing: _editing, language: _language, style: context.t.titleMedium),
                    Text(
                      context.s.detailsLanguageRoleLabel(_language.toLabel(context), _role),
                      style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => editLanguageText(context, _editing, _language),
                tooltip: context.s.edit,
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const _PausedLanguages({
  required final DetailsEditing _editing,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    final languages = _editing.pausedLanguages;
    return AnimatedSize(
      duration: _expandDuration,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: Spacing.xs,
        children: [
          InkWell(
            onTap: () => isOpen.value = !isOpen.value,
            borderRadius: BorderRadius.circular(Spacing.radiusXl),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.s),
              child: Row(
                children: [
                  Text(
                    [for (final language in languages) language.toFlag()].join(),
                    style: context.t.titleMedium,
                  ),
                  const SizedBox(width: Spacing.m),
                  Expanded(
                    child: Text(
                      context.s.detailsPausedLanguagesTitle(languages.length),
                      style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                  ),
                  Icon(
                    isOpen.value
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: context.c.onSurfaceVariant,
                  ),
                ],
              ),
            ),
          ),
          if (isOpen.value)
            for (final language in languages) _LearnedCard(editing: _editing, language: language),
        ],
      ),
    );
  }
}

class const _Text({
  required final DetailsEditing _editing,
  required final Language _language,
  required final TextStyle? _style,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final text = _editing.textOf(_language);
    if (text.isEmpty && _editing.translatingLanguages.contains(_language)) {
      return const Align(alignment: Alignment.centerLeft, child: ButtonProgress());
    }
    return Text(
      text.isEmpty ? _language.toLabel(context) : text,
      maxLines: _textMaxLines,
      overflow: TextOverflow.ellipsis,
      style: text.isEmpty ? _style?.copyWith(color: context.c.outline) : _style,
    );
  }
}

class const _RoundButton({
  required final IconData _icon,
  required final String _tooltip,
  required final bool _isHighlighted,
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _roundButtonSize,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: _isHighlighted
              ? context.c.surfaceContainerHighest
              : context.c.surfaceContainer,
          foregroundColor: context.c.onSurface,
        ),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon, size: Spacing.iconS),
      ),
    );
  }
}
