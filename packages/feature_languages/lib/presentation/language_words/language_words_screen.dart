import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_words_change.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const LanguageWordsScreen({
  super.key,
  required final Language _language,
  required final bool _isAdding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final label = _language.toLabel(context);
    return BlocListener<LanguageWordsBloc, LanguageWordsState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, LanguageWordsSaved()) => true,
        (LanguageWordsEditing(error: null), LanguageWordsEditing(error: _?)) => true,
        (LanguageWordsEditing(preview: null), LanguageWordsEditing(preview: _?)) => true,
        _ => false,
      },
      listener: (context, state) async {
        switch (state) {
          case LanguageWordsSaved():
            context.closeScreen();
          case LanguageWordsEditing(:final preview?):
            await _confirmChange(context, preview);
          case LanguageWordsEditing(:final error?):
            context.showToast(error.toMessage(context));
          case LanguageWordsEditing() || LanguageWordsLoading() || LanguageWordsFailure():
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _isAdding ? context.s.languageWordsAddTitle(label) : context.s.languageWordsTitle(label),
          ),
        ),
        body: BlocBuilder<LanguageWordsBloc, LanguageWordsState>(
          builder: (context, state) => switch (state) {
            LanguageWordsEditing() => _Content(state: state),
            LanguageWordsFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            LanguageWordsLoading() || LanguageWordsSaved() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }

  Future<void> _confirmChange(BuildContext context, LanguageWordsPreview preview) async {
    final bloc = context.read<LanguageWordsBloc>();
    final isConfirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(context.s.languageWordsSummaryTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.s.languageWordsSummaryAdded(preview.addedCount)),
            Text(context.s.languageWordsSummaryRemoved(preview.removedCount)),
            if (preview.removedCount > 0) ...[
              const SizedBox(height: Spacing.s),
              Text(context.s.languageWordsSummaryRestartHint),
            ],
            if (preview.removedAlsoElsewhereCount > 0)
              Text(context.s.languageWordsSummaryAlsoElsewhere(preview.removedAlsoElsewhereCount)),
          ],
        ),
        actionsPadding: const EdgeInsets.all(Spacing.xl),
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
                child: Text(context.s.languageWordsSaveButton),
              ),
            ],
          ),
        ],
      ),
    );
    bloc.add(
      isConfirmed ?? false
          ? const LanguageWordsSaveConfirmed()
          : const LanguageWordsSaveCancelled(),
    );
  }
}

class const _Content({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    final label = _state.language.toLabel(context);
    final hasWords = _state.coverage.totalCount > 0;
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: Spacing.m),
              children: [
                if (_state.isAdding && !hasWords)
                  _Hint(text: context.s.languageWordsNoWordsHint(label))
                else if (_state.isAdding) ...[
                  _Hint(text: context.s.languageWordsAddQuestion(label)),
                  RadioGroup<LanguageWordsOption>(
                    groupValue: _state.option,
                    onChanged: (option) {
                      if (option != null) bloc.add(LanguageWordsOptionChanged(option: option));
                    },
                    child: Column(
                      children: [
                        RadioListTile(
                          value: LanguageWordsOption.all,
                          title: Text(context.s.languageWordsAllOption(_state.coverage.totalCount)),
                        ),
                        RadioListTile(
                          value: LanguageWordsOption.choose,
                          title: Text(context.s.languageWordsChooseOption),
                        ),
                        RadioListTile(
                          value: LanguageWordsOption.none,
                          title: Text(context.s.languageWordsNoneOption),
                        ),
                      ],
                    ),
                  ),
                  if (_state.option == LanguageWordsOption.choose) _Collections(state: _state),
                  if (_state.option != LanguageWordsOption.all)
                    _Hint(text: context.s.languageWordsLeftOutHint(label)),
                ] else
                  _Collections(state: _state),
                if (_state.isAdding) ...[
                  const SizedBox(height: Spacing.m),
                  _Hint(text: context.s.learnedLanguageNewWordsTitle),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                    child: Wrap(
                      spacing: Spacing.xs,
                      children: [
                        for (final limit in newWordLimits)
                          ChoiceChip(
                            label: Text(switch (limit) {
                              NewWordsUpTo(:final count) => "$count",
                              AllNewWords() => context.s.learnedLanguageAllNewWords,
                            }),
                            selected: limit == _state.newWords,
                            onSelected: (_) =>
                                bloc.add(LanguageWordsNewWordsChanged(newWords: limit)),
                          ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            child: FilledButton(
              onPressed: _state.isSaving || (!_state.isAdding && !_state.hasChanges)
                  ? null
                  : () => bloc.add(const LanguageWordsSaveRequested()),
              child: Text(
                _state.isAdding
                    ? context.s.languageWordsStartButton(label)
                    : context.s.languageWordsSaveButton,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Collections({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    return Column(
      children: [
        for (final collection in _state.coverage.collections)
          if (collection.totalCount > 0)
            CheckboxListTile(
              tristate: !_state.isAdding,
              value: _state.selection[collection.tag.id] ?? false,
              onChanged: (_) =>
                  bloc.add(LanguageWordsCollectionToggled(tagId: collection.tag.id)),
              title: Text(collection.tag.name),
              subtitle: Text(
                _countLabel(context, collection.inLanguageCount, collection.totalCount),
              ),
            ),
        if (_state.coverage.untaggedCount > 0)
          CheckboxListTile(
            tristate: !_state.isAdding,
            value: _state.untagged,
            onChanged: (_) => bloc.add(const LanguageWordsUntaggedToggled()),
            title: Text(context.s.languageWordsUntaggedLabel),
            subtitle: Text(
              _countLabel(
                context,
                _state.coverage.untaggedInLanguageCount,
                _state.coverage.untaggedCount,
              ),
            ),
          ),
      ],
    );
  }

  String _countLabel(BuildContext context, int inLanguage, int total) {
    return _state.isAdding || inLanguage == 0 || inLanguage >= total
        ? context.s.languageWordsCount(total)
        : context.s.languageWordsPartialCount(inLanguage, total);
  }
}

class const _Hint({
  required final String _text,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
      child: Text(_text, style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant)),
    );
  }
}
