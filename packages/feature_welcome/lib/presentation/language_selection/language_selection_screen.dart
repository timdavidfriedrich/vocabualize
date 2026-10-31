import 'package:core/theme/spacing.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_bloc.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_event.dart';
import 'package:feature_welcome/presentation/language_selection/language_selection_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_pair.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const LanguageSelectionScreen({
  super.key,
  required final bool _isOnboarding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageSelectionBloc, LanguageSelectionState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, LanguageSelectionSaved()) => true,
        (LanguageSelectionEditing(error: null), LanguageSelectionEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        LanguageSelectionSaved() when !_isOnboarding => context.closeScreen(),
        LanguageSelectionEditing(:final error?) => context.showToast(error.toMessage(context)),
        LanguageSelectionSaved() ||
        LanguageSelectionEditing() ||
        LanguageSelectionLoading() => null,
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.languageSelectionTitle)),
        body: BlocBuilder<LanguageSelectionBloc, LanguageSelectionState>(
          builder: (context, state) => switch (state) {
            LanguageSelectionEditing(:final pair, :final isSaving) => _Content(
              pair: pair,
              isSaving: isSaving,
              isOnboarding: _isOnboarding,
            ),
            LanguageSelectionLoading() || LanguageSelectionSaved() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final LanguagePair _pair,
  required final bool _isSaving,
  required final bool _isOnboarding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageSelectionBloc>();
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(Spacing.xl),
              children: [
                _LanguageChoice(
                  title: context.s.settingsSourceLanguageTitle,
                  hint: context.s.settingsSourceLanguageHint,
                  selected: _pair.source,
                  onSelected: (language) =>
                      bloc.add(LanguageSelectionSourceChanged(language: language)),
                ),
                const SizedBox(height: Spacing.xl),
                _LanguageChoice(
                  title: context.s.settingsTargetLanguageTitle,
                  hint: context.s.settingsTargetLanguageHint,
                  selected: _pair.target,
                  onSelected: (language) =>
                      bloc.add(LanguageSelectionTargetChanged(language: language)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            child: FilledButton(
              onPressed: _isSaving ? null : () => bloc.add(const LanguageSelectionSaveRequested()),
              child: Text(
                _isOnboarding
                    ? context.s.languageSelectionContinueButton
                    : context.s.languageSelectionSaveButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _LanguageChoice({
  required final String _title,
  required final String _hint,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_title, style: context.t.titleMedium),
        const SizedBox(height: Spacing.xxxs),
        Text(_hint, style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant)),
        const SizedBox(height: Spacing.s),
        Wrap(
          spacing: Spacing.xs,
          runSpacing: Spacing.xs,
          children: [
            for (final language in supportedLanguages)
              ChoiceChip(
                label: Text("${language.toFlag()} ${language.toLabel(context)}"),
                selected: language == _selected,
                onSelected: (_) => _onSelected(language),
              ),
          ],
        ),
      ],
    );
  }
}
