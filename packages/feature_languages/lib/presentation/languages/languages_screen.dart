import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/delete_language_dialog.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:feature_languages/presentation/widgets/swipe_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/section_title.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _pausedActionAlpha = 0.2;
const _dimmedOpacity = 0.6;
const _expandDuration = Duration(milliseconds: 200);
const _addIconSize = Spacing.xxl;

class const LanguagesScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguagesBloc, LanguagesState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (LanguagesLoaded(error: null), LanguagesLoaded(error: _?)) => true,
        _ => false,
      },
      listener: (context, state) {
        if (state case LanguagesLoaded(:final error?)) context.showToast(error.toMessage(context));
      },
      child: Scaffold(
        appBar: PageAppBar(title: Text(context.s.languagesTitle)),
        body: BlocBuilder<LanguagesBloc, LanguagesState>(
          builder: (context, state) => switch (state) {
            LanguagesLoading() => const Center(child: CircularProgressIndicator()),
            LanguagesFailure(:final error) => Center(
              child: Padding(
                padding: const EdgeInsets.all(Spacing.xl),
                child: Text(error.toMessage(context), textAlign: TextAlign.center),
              ),
            ),
            LanguagesLoaded() => _Content(state: state),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final LanguagesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setup = _state.setup;
    return ListView(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xl, Spacing.m, Spacing.xxxl),
      children: [
        _Section(title: SectionTitle(title: context.s.languagesSpeakTitle)),
        _MainCard(language: setup.main),
        const SizedBox(height: Spacing.xl),
        _Section(title: SectionTitle(title: context.s.languagesLearnTitle)),
        ClipRRect(
          borderRadius: BorderRadius.circular(Spacing.radiusXxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: Spacing.borderWidthMedium,
            children: [
              for (final learned in setup.active)
                _LearnedRow(
                  key: ValueKey(learned.language),
                  learned: learned,
                  wordCount: _state.wordCounts[learned.language],
                  state: _state,
                ),
              _AddRow(state: _state),
            ],
          ),
        ),
        if (setup.paused.isNotEmpty) ...[
          const SizedBox(height: Spacing.xl),
          _Section(title: SectionTitle(title: context.s.languagesPausedTitle, isMuted: true)),
          for (final learned in setup.paused)
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.xs),
              child: _PausedCard(
                key: ValueKey(learned.language),
                language: learned.language,
                state: _state,
              ),
            ),
        ],
      ],
    );
  }
}

class const _Section({
  required final Widget _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.xxxs, 0, Spacing.xxxs, Spacing.s),
      child: _title,
    );
  }
}

class const _MainCard({
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.s, Spacing.s),
      decoration: BoxDecoration(
        color: context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      ),
      child: Row(
        children: [
          Text(_language.toFlag(), style: context.t.titleLarge),
          const SizedBox(width: Spacing.m),
          Expanded(
            child: Text(
              _language.toLabel(context),
              style: context.t.titleMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TonalButton(
            isCompact: true,
            onPressed: context.pushMainLanguage,
            child: Text(context.s.languagesChangeButton),
          ),
        ],
      ),
    );
  }
}

class const _LearnedRow({
  super.key,
  required final LearnedLanguage _learned,
  required final int? _wordCount,
  required final LanguagesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguagesBloc>();
    final language = _learned.language;
    final canLeave = _state.setup.active.length > 1 && !_state.isBusy;
    return SwipeActions(
      color: context.c.surfaceContainerLowest,
      onTap: () => context.pushLearnedLanguageDetails(language: language),
      actions: [
        if (canLeave) ...[
          SwipeAction(
            icon: Icons.pause_rounded,
            label: context.s.languagesPauseAction,
            color: context.status.warning.withValues(alpha: _pausedActionAlpha),
            textColor: context.status.warning,
            onPressed: () => bloc.add(LanguagesPauseRequested(language: language)),
          ),
          SwipeAction(
            icon: Icons.delete_outline_rounded,
            label: context.s.delete,
            color: context.c.error,
            textColor: context.c.onError,
            onPressed: () => _delete(context, _state, language),
          ),
        ],
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.m),
        child: Row(
          children: [
            Text(language.toFlag(), style: context.t.titleLarge),
            const SizedBox(width: Spacing.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          language.toLabel(context),
                          style: context.t.titleMedium,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (_learned.askMeIn case final askMeIn?) ...[
                        const SizedBox(width: Spacing.xs),
                        _AsksInChip(language: askMeIn),
                      ],
                    ],
                  ),
                  if (_wordCount case final count?)
                    Text(
                      context.s.languagesWordCount(count),
                      style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                    ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: context.c.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class const _AsksInChip({
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.xxxs),
      decoration: BoxDecoration(
        color: context.c.primaryContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusS),
      ),
      child: Text(
        context.s.languagesAsksInLabel(_language.toFlag()),
        style: context.t.labelMedium?.copyWith(color: context.c.primary),
      ),
    );
  }
}

class const _AddRow({
  required final LanguagesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLowest,
      child: InkWell(
        onTap: _state.isBusy ? null : () => _addLanguage(context, _state.setup),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.m),
          child: Row(
            children: [
              Container(
                width: _addIconSize,
                height: _addIconSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.c.primaryContainer,
                ),
                child: Icon(Icons.add_rounded, color: context.c.primary),
              ),
              const SizedBox(width: Spacing.m),
              Text(
                context.s.languagesAddButton,
                style: context.t.titleMedium?.copyWith(color: context.c.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addLanguage(BuildContext context, LanguageSetup setup) async {
    final pausedLanguages = {for (final learned in setup.paused) learned.language};
    final language = await requestsLanguage(
      context,
      options: [
        for (final language in supportedLanguages)
          if (!language.isSameLanguageAs(setup.main) &&
              !setup.active.any((learned) => learned.language == language))
            language,
      ],
      paused: pausedLanguages,
    );
    if (language == null || !context.mounted) return;
    if (pausedLanguages.contains(language)) {
      await context.pushLearnedLanguageDetails(language: language);
    } else {
      await context.pushLanguageWords(language: language, isAdding: true);
    }
  }
}

class const _PausedCard({
  super.key,
  required final Language _language,
  required final LanguagesLoaded _state,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    final bloc = context.read<LanguagesBloc>();
    final label = _language.toShortLabel(context);
    final wordCount = _state.wordCounts[_language];
    return Material(
      color: context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: AnimatedSize(
        duration: _expandDuration,
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () => isOpen.value = !isOpen.value,
              child: Padding(
                padding: const EdgeInsets.all(Spacing.m),
                child: Row(
                  children: [
                    Opacity(
                      opacity: isOpen.value ? 1 : _dimmedOpacity,
                      child: Text(_language.toFlag(), style: context.t.titleLarge),
                    ),
                    const SizedBox(width: Spacing.m),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _language.toLabel(context),
                            style: context.t.titleMedium?.copyWith(
                              color: isOpen.value ? null : context.c.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            context.s.languagesPausedWordCount(wordCount ?? 0),
                            style: context.t.bodyMedium?.copyWith(
                              color: context.c.onSurfaceVariant,
                            ),
                          ),
                        ],
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
              Padding(
                padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: Spacing.xs,
                  children: [
                    ElevatedButton(
                      onPressed: _state.isBusy
                          ? null
                          : () => bloc.add(
                              LanguagesResumeRequested(language: _language, startsOver: false),
                            ),
                      child: Text(context.s.languagesContinueWhereLeftOffButton),
                    ),
                    TonalButton(
                      onPressed: _state.isBusy
                          ? null
                          : () => bloc.add(
                              LanguagesResumeRequested(language: _language, startsOver: true),
                            ),
                      child: Text(context.s.learnedLanguageStartOverButton),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: context.c.error,
                        textStyle: context.t.labelLarge,
                      ),
                      onPressed: _state.isBusy ? null : () => _delete(context, _state, _language),
                      child: Text(context.s.languageDeleteButton(label)),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> _delete(BuildContext context, LanguagesLoaded state, Language language) async {
  final bloc = context.read<LanguagesBloc>();
  final isConfirmed = await confirmsLanguageDelete(
    context,
    language: language,
    wordCount: state.wordCounts[language],
    keptLanguages: [
      for (final learned in state.setup.learned)
        if (learned.language != language) learned.language,
    ],
  );
  if (isConfirmed) bloc.add(LanguagesDeleteRequested(language: language));
}
