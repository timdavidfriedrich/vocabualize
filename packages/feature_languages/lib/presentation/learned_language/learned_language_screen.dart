import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/delete_language_dialog.dart';
import 'package:feature_languages/presentation/widgets/learned_language_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/app_menu.dart';
import 'package:shared/presentation/widgets/language_label.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/section_title.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

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
          actions: const [_PausedChip(), _MoreMenu()],
        ),
        bottomNavigationBar: const _Actions(),
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
        _ => false,
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
          child: LearnedLanguageRoute(state: _state),
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
          _NewWordsSelector(selected: learned.newWords, isBusy: _state.isBusy),
          const SizedBox(height: Spacing.xl),
          _Section(title: context.s.learnedLanguageImportedWordsTitle),
          _ImportedWordsCard(state: _state),
        ],
      ],
    );
  }
}

class const _Actions() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnedLanguageBloc, LearnedLanguageState>(
      builder: (context, state) => switch (state) {
        final LearnedLanguageLoaded loaded => _ActionButtons(state: loaded),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _ActionButtons({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final learned = _state.learned;
    if (!learned.isPaused) return const SizedBox.shrink();
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: Spacing.m),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        child: ElevatedButton(
          onPressed: _state.isBusy
              ? null
              : () => context.read<LearnedLanguageBloc>().add(
                  const LearnedLanguageResumeRequested(startsOver: false),
                ),
          child: Text(
            context.s.learnedLanguageResumeButton(learned.language.toShortLabel(context)),
          ),
        ),
      ),
    );
  }
}

class const _MoreMenu() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnedLanguageBloc, LearnedLanguageState>(
      builder: (context, state) => switch (state) {
        final LearnedLanguageLoaded loaded => _MoreMenuButton(state: loaded),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class const _MoreMenuButton({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    final learned = _state.learned;
    final label = learned.language.toShortLabel(context);
    final isLastActive = !learned.isPaused && _state.setup.active.length == 1;
    final canChange = !_state.isBusy && !isLastActive;
    return AppMenuAnchor(
      items: [
        if (!learned.isPaused)
          AppMenuItem(
            leading: const Icon(Icons.pause_rounded),
            title: context.s.learnedLanguagePauseButton(label),
            subtitle: isLastActive ? context.s.learnedLanguageLastActiveHint : null,
            onTap: canChange ? () => bloc.add(const LearnedLanguagePauseRequested()) : null,
          ),
        AppMenuItem(
          leading: const Icon(Icons.delete_outline_rounded),
          title: context.s.delete,
          isDestructive: true,
          onTap: canChange ? () => _delete(context) : null,
        ),
      ],
      builder: (context, controller) => IconButton(
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
        tooltip: MaterialLocalizations.of(context).showMenuTooltip,
        icon: const Icon(Icons.more_vert_rounded),
      ),
    );
  }

  Future<void> _delete(BuildContext context) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final language = _state.learned.language;
    final isConfirmed = await confirmsLanguageDelete(
      context,
      language: language,
      wordCount: _state.coverage?.inLanguageCount,
      keptLanguages: [
        for (final learned in _state.setup.learned)
          if (learned.language != language) learned.language,
      ],
    );
    if (isConfirmed) bloc.add(const LearnedLanguageDeleteRequested());
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

class const _NewWordsSelector({
  required final NewWordLimit _selected,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    return Container(
      padding: const EdgeInsets.all(Spacing.xxs),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          for (final limit in newWordLimits)
            Expanded(
              child: Material(
                color: limit == _selected
                    ? context.c.secondaryContainer
                    : context.c.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(Spacing.radiusXl),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: _isBusy || limit == _selected
                      ? null
                      : () => bloc.add(LearnedLanguageNewWordsChanged(newWords: limit)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Spacing.s),
                    child: Text(
                      switch (limit) {
                        NewWordsUpTo(:final count) => "$count",
                        AllNewWords() => context.s.learnedLanguageAllNewWords,
                      },
                      textAlign: TextAlign.center,
                      style: context.t.titleMedium?.copyWith(
                        color: limit == _selected
                            ? context.c.onSecondaryContainer
                            : context.c.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class const _ImportedWordsCard({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final coverage = _state.coverage;
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.s, Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.s.languagesWordCount(coverage?.inLanguageCount ?? 0),
                  style: context.t.titleMedium,
                ),
                Text(
                  context.s.learnedLanguageTotalWordsHint(coverage?.totalCount ?? 0),
                  style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ],
            ),
          ),
          TonalButton(
            isCompact: true,
            onPressed: () =>
                context.pushLanguageWords(language: _state.learned.language, isAdding: false),
            child: Text(context.s.languageWordsManageTitle),
          ),
        ],
      ),
    );
  }
}
