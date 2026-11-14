import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/extensions/language_words_editing_extensions.dart';
import 'package:feature_languages/presentation/language_words/language_words_bloc.dart';
import 'package:feature_languages/presentation/language_words/language_words_event.dart';
import 'package:feature_languages/presentation/language_words/language_words_state.dart';
import 'package:feature_languages/presentation/widgets/language_words_collections.dart';
import 'package:feature_languages/presentation/widgets/language_words_option_card.dart';
import 'package:feature_languages/presentation/widgets/language_words_summary_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';

class const LanguageWordsScreen({
  super.key,
  required final Language _language,
  required final bool _isAdding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageWordsBloc, LanguageWordsState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (_, LanguageWordsSaved()) => true,
        (LanguageWordsEditing(error: null), LanguageWordsEditing(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) => switch (state) {
        LanguageWordsSaved() => context.closeScreen(),
        LanguageWordsEditing(:final error?) => context.showToast(error.toMessage(context)),
        LanguageWordsEditing() || LanguageWordsLoading() || LanguageWordsFailure() => null,
      },
      child: Scaffold(
        appBar: PageAppBar(
          title: _isAdding ? null : Text(context.s.languageWordsManageTitle),
          actions: [
            if (!_isAdding)
              Padding(
                padding: const EdgeInsets.only(right: Spacing.m),
                child: Text(_language.toFlag(), style: context.t.titleLarge),
              ),
          ],
        ),
        body: BlocBuilder<LanguageWordsBloc, LanguageWordsState>(
          builder: (context, state) => switch (state) {
            LanguageWordsEditing(isAdding: true) => _ImportContent(state: state),
            LanguageWordsEditing() => _ManageContent(state: state),
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
}

class const _ImportContent({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    final language = _state.language;
    final hasWords = _state.coverage.totalCount > 0;
    return _Layout(
      button: ElevatedButton(
        onPressed: _state.isSaving ? null : () => bloc.add(const LanguageWordsSaveRequested()),
        child: _state.isSaving
            ? const ButtonProgress()
            : Text(context.s.languageWordsImportButton(hasWords ? _state.importCount : 0)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
          child: Text(
            context.s.languageWordsImportTitle(
              "${language.toFlag()} ${language.toShortLabel(context)}",
            ),
            style: context.t.headlineMedium,
          ),
        ),
        const SizedBox(height: Spacing.xxs),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
          child: Text(
            hasWords
                ? context.s.languageWordsImportHint
                : context.s.languageWordsNoWordsHint(language.toShortLabel(context)),
            style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: Spacing.l),
        if (hasWords) ...[
          LanguageWordsOptionCard(
            title: context.s.languageWordsAllOption,
            subtitle: context.s.languagesWordCount(_state.coverage.totalCount),
            isSelected: _state.option == LanguageWordsOption.all,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.all)),
          ),
          const SizedBox(height: Spacing.xs),
          LanguageWordsOptionCard(
            title: context.s.languageWordsSomeCollectionsOption,
            subtitle: context.s.languagesWordCount(_state.preview?.addedCount ?? 0),
            isSelected: _state.option == LanguageWordsOption.choose,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.choose)),
            children: [
              if (_state.option == LanguageWordsOption.choose)
                LanguageWordsCollections(state: _state),
            ],
          ),
          const SizedBox(height: Spacing.xs),
          LanguageWordsOptionCard(
            title: context.s.languageWordsNoneOption,
            subtitle: context.s.languageWordsNoneHint,
            isSelected: _state.option == LanguageWordsOption.none,
            onTap: () =>
                bloc.add(const LanguageWordsOptionChanged(option: LanguageWordsOption.none)),
          ),
        ],
      ],
    );
  }
}

class const _ManageContent({
  required final LanguageWordsEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageWordsBloc>();
    return _Layout(
      button: ElevatedButton(
        onPressed: _state.isSaving || !_state.hasChanges
            ? null
            : () => bloc.add(const LanguageWordsSaveRequested()),
        child: _state.isSaving ? const ButtonProgress() : Text(context.s.languageWordsSaveButton),
      ),
      children: [
        LanguageWordsSummaryCard(state: _state),
        const SizedBox(height: Spacing.l),
        LanguageWordsCollections(state: _state),
      ],
    );
  }
}

class const _Layout({
  required final List<Widget> _children,
  required final Widget _button,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(bottom: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xs, Spacing.m, Spacing.xl),
              children: _children,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
            child: _button,
          ),
        ],
      ),
    );
  }
}
