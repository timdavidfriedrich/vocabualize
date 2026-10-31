import 'package:core/theme/spacing.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_bloc.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_event.dart';
import 'package:feature_practice/presentation/custom_practice/custom_practice_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/practice_session.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

class const CustomPracticeScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomPracticeBloc, CustomPracticeState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, CustomPracticeLaunched()) => true,
        (CustomPracticeEditing(error: null), CustomPracticeEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        CustomPracticeLaunched() => context.startCustomPractice(),
        CustomPracticeEditing(:final error?) => context.showToast(error.toMessage(context)),
        CustomPracticeEditing() || CustomPracticeLoading() || CustomPracticeFailure() => null,
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: context.closeScreen,
            tooltip: context.s.close,
            icon: const Icon(Icons.close_rounded),
          ),
          title: Text(context.s.customPracticeTitle),
        ),
        body: BlocBuilder<CustomPracticeBloc, CustomPracticeState>(
          builder: (context, state) => switch (state) {
            CustomPracticeEditing() => _Content(state: state),
            CustomPracticeFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            CustomPracticeLoading() || CustomPracticeLaunched() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final CustomPracticeEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CustomPracticeBloc>();
    final filter = _state.filter;
    final activeLanguages = [for (final learned in _state.setup.active) learned.language];
    final isAllLanguages = activeLanguages.every(filter.languages.contains);
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
                _Section(
                  title: context.s.customPracticeLanguagesTitle,
                  children: [
                    for (final language in activeLanguages)
                      FilterChip(
                        label: LanguageLabel(language: language),
                        selected: filter.languages.contains(language),
                        onSelected: (_) =>
                            bloc.add(CustomPracticeLanguageToggled(language: language)),
                      ),
                    if (activeLanguages.length > 1)
                      ChoiceChip(
                        label: Text(context.s.customPracticeAllOption),
                        selected: isAllLanguages,
                        onSelected: (_) => bloc.add(const CustomPracticeAllLanguagesSelected()),
                      ),
                  ],
                ),
                if (_state.tags.isNotEmpty)
                  _Section(
                    title: context.s.customPracticeCollectionsTitle,
                    children: [
                      ChoiceChip(
                        label: Text(context.s.customPracticeAllOption),
                        selected: !_state.isChoosingCollections,
                        onSelected: (_) => bloc.add(
                          const CustomPracticeCollectionsModeChanged(isChoosing: false),
                        ),
                      ),
                      ChoiceChip(
                        label: Text(context.s.customPracticeChooseOption),
                        selected: _state.isChoosingCollections,
                        onSelected: (_) => bloc.add(
                          const CustomPracticeCollectionsModeChanged(isChoosing: true),
                        ),
                      ),
                      if (_state.isChoosingCollections)
                        for (final tag in _state.tags)
                          FilterChip(
                            label: Text(tag.name),
                            selected: filter.tagIds.contains(tag.id),
                            onSelected: (_) =>
                                bloc.add(CustomPracticeCollectionToggled(tagId: tag.id)),
                          ),
                    ],
                  ),
                _Section(
                  title: context.s.customPracticeWordsTitle,
                  children: [
                    for (final words in PracticeWords.values)
                      ChoiceChip(
                        label: Text(switch (words) {
                          PracticeWords.due => context.s.customPracticeDueOption,
                          PracticeWords.all => context.s.customPracticeAllWordsOption,
                        }),
                        selected: filter.words == words,
                        onSelected: (_) => bloc.add(CustomPracticeWordsChanged(words: words)),
                      ),
                  ],
                ),
                _Section(
                  title: context.s.customPracticeNewWordsTitle,
                  children: [
                    for (final newWords in PracticeNewWords.values)
                      ChoiceChip(
                        label: Text(switch (newWords) {
                          PracticeNewWords.none => context.s.customPracticeNoNewWordsOption,
                          PracticeNewWords.upToCap => context.s.customPracticeUpToLimitOption,
                          PracticeNewWords.allWaiting => context.s.customPracticeAllWaitingOption,
                        }),
                        selected: filter.newWords == newWords,
                        onSelected: (_) =>
                            bloc.add(CustomPracticeNewWordsChanged(newWords: newWords)),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            child: FilledButton(
              onPressed: switch (_state) {
                CustomPracticeEditing(count: final count?, isStarting: false) when count > 0 =>
                  () => _start(context),
                _ => null,
              },
              child: Text(context.s.customPracticeStartButton(_state.count ?? 0)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _start(BuildContext context) async {
    final bloc = context.read<CustomPracticeBloc>();
    if (_state.hasUnfinishedSession) {
      final isConfirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog.adaptive(
          title: Text(context.s.customPracticeReplaceTitle),
          content: Text(context.s.customPracticeReplaceMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(context.s.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(context.s.customPracticeReplaceButton),
            ),
          ],
        ),
      );
      if (isConfirmed != true) return;
    }
    bloc.add(const CustomPracticeStartRequested());
  }
}

class const _Section({
  required final String _title,
  required final List<Widget> _children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_title, style: context.t.titleMedium),
          const SizedBox(height: Spacing.s),
          Wrap(spacing: Spacing.xs, runSpacing: Spacing.xs, children: _children),
        ],
      ),
    );
  }
}
