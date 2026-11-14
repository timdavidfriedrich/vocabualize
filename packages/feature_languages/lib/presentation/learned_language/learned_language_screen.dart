import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/imported_words_card.dart';
import 'package:feature_languages/presentation/widgets/learned_language_actions.dart';
import 'package:feature_languages/presentation/widgets/learned_language_more_menu.dart';
import 'package:feature_languages/presentation/widgets/learned_language_path.dart';
import 'package:feature_languages/presentation/widgets/new_words_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/section_title.dart';

const _pausedOpacity = 0.5;

class const LearnedLanguageScreen({
  super.key,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LearnedLanguageBloc, LearnedLanguageState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (_, LearnedLanguageClosed()) => true,
            (LearnedLanguageLoaded(error: null), LearnedLanguageLoaded(error: _?)) => true,
            _ => false,
          },
          listener: (context, state) => switch (state) {
            LearnedLanguageClosed() => context.closeScreen(),
            LearnedLanguageLoaded(:final error?) => context.showToast(error.toMessage(context)),
            LearnedLanguageLoaded() || LearnedLanguageLoading() || LearnedLanguageFailure() => null,
          },
        ),
        BlocListener<LearnedLanguageBloc, LearnedLanguageState>(
          listenWhen: (previous, current) => switch ((previous, current)) {
            (
              LearnedLanguageLoaded(learned: LearnedLanguage(isPaused: false)),
              LearnedLanguageLoaded(learned: LearnedLanguage(isPaused: true)),
            ) =>
              true,
            _ => false,
          },
          listener: (context, state) {
            final bloc = context.read<LearnedLanguageBloc>();
            context.showToast(
              context.s.learnedLanguagePausedMessage(_language.toShortLabel(context)),
              action: SnackBarAction(
                label: context.s.undo,
                onPressed: () => bloc.add(const LearnedLanguageResumeRequested(startsOver: false)),
              ),
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: PageAppBar(
          title: LanguageLabel(language: _language, style: context.t.headlineSmall),
          actions: const [_PausedChip(), LearnedLanguageMoreMenu()],
        ),
        bottomNavigationBar: const LearnedLanguageActions(),
        body: BlocBuilder<LearnedLanguageBloc, LearnedLanguageState>(
          builder: (context, state) => switch (state) {
            LearnedLanguageLoaded() => _Content(state: state),
            LearnedLanguageFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            LearnedLanguageLoading() || LearnedLanguageClosed() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _PausedChip() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<LearnedLanguageBloc, LearnedLanguageState, bool>(
      selector: (state) => switch (state) {
        LearnedLanguageLoaded(:final learned) => learned.isPaused,
        LearnedLanguageLoading() || LearnedLanguageClosed() || LearnedLanguageFailure() => false,
      },
      builder: (context, isPaused) => !isPaused
          ? const SizedBox.shrink()
          : Container(
              margin: const EdgeInsets.only(right: Spacing.m),
              padding: const EdgeInsets.symmetric(horizontal: Spacing.s, vertical: Spacing.xxs),
              decoration: BoxDecoration(
                color: context.c.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(Spacing.radiusM),
              ),
              child: Text(
                context.s.languagesPausedTitle,
                style: context.t.labelLarge?.copyWith(color: context.c.onSurfaceVariant),
              ),
            ),
    );
  }
}

class const _Content({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final learned = _state.learned;
    final label = learned.language.toShortLabel(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, Spacing.xl),
      children: [
        Opacity(
          opacity: learned.isPaused ? _pausedOpacity : 1,
          child: LearnedLanguagePath(state: _state),
        ),
        const SizedBox(height: Spacing.xl),
        if (learned.isPaused)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
            child: Text(
              context.s.learnedLanguagePausedHint(label, _state.coverage?.inLanguageCount ?? 0),
              style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
            ),
          )
        else ...[
          _Section(title: context.s.learnedLanguageNewWordsTitle),
          NewWordsSelector(selected: learned.newWords, isBusy: _state.isBusy),
          const SizedBox(height: Spacing.xl),
          _Section(title: context.s.learnedLanguageImportedWordsTitle),
          ImportedWordsCard(state: _state),
        ],
      ],
    );
  }
}

class const _Section({
  required final String _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.xxxs, 0, Spacing.xxxs, Spacing.s),
      child: SectionTitle(title: _title),
    );
  }
}
