import 'package:adaptive_actions/adaptive_actions.dart';
import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:feature_languages/presentation/widgets/confirmation_dialog.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/vocabulary_level.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/extensions/vocabulary_level_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

class const LearnedLanguageScreen({
  super.key,
  required final Language _language,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LearnedLanguageBloc, LearnedLanguageState>(
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
      child: Scaffold(
        appBar: AppBar(title: LanguageLabel(language: _language)),
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

class const _Content({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    final learned = _state.learned;
    final isLastActive = !learned.isPaused && _state.setup.active.length == 1;
    return ListView(
      padding: const EdgeInsets.all(Spacing.xl),
      children: [
        _Route(state: _state),
        const SizedBox(height: Spacing.xxl),
        _SectionTitle(title: context.s.learnedLanguageNewWordsTitle),
        Wrap(
          spacing: Spacing.xs,
          children: [
            for (final limit in newWordLimits)
              ChoiceChip(
                label: Text(switch (limit) {
                  NewWordsUpTo(:final count) => "$count",
                  AllNewWords() => context.s.learnedLanguageAllNewWords,
                }),
                selected: limit == learned.newWords,
                onSelected: _state.isBusy
                    ? null
                    : (_) => bloc.add(LearnedLanguageNewWordsChanged(newWords: limit)),
              ),
          ],
        ),
        const SizedBox(height: Spacing.xxl),
        _SectionTitle(title: context.s.learnedLanguageWordsTitle),
        Row(
          children: [
            Expanded(
              child: Text(switch (_state.coverage) {
                final coverage? => context.s.learnedLanguageWordsCount(
                  coverage.inLanguageCount,
                  coverage.totalCount,
                ),
                null => "",
              }, style: context.t.bodyLarge),
            ),
            OutlinedButton(
              onPressed: () =>
                  context.pushLanguageWords(language: learned.language, isAdding: false),
              child: Text(context.s.learnedLanguageChooseWordsButton),
            ),
          ],
        ),
        const SizedBox(height: Spacing.xxxl),
        if (learned.isPaused)
          FilledButton(
            onPressed: _state.isBusy ? null : () => _resume(context),
            child: Text(context.s.learnedLanguageResumeButton),
          )
        else ...[
          OutlinedButton(
            onPressed: _state.isBusy || isLastActive
                ? null
                : () => bloc.add(const LearnedLanguagePauseRequested()),
            child: Text(context.s.learnedLanguagePauseButton),
          ),
          if (isLastActive)
            Padding(
              padding: const EdgeInsets.only(top: Spacing.xs),
              child: Text(
                context.s.learnedLanguageLastActiveHint,
                style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ),
        ],
        const SizedBox(height: Spacing.s),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: context.c.error),
          onPressed: _state.isBusy || isLastActive ? null : () => _delete(context),
          child: Text(context.s.delete),
        ),
      ],
    );
  }

  Future<void> _resume(BuildContext context) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final label = _state.learned.language.toLabel(context);
    final startsOver = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(context.s.learnedLanguageResumeTitle(label)),
        content: Text(context.s.learnedLanguageResumeMessage),
        actionsPadding: const EdgeInsets.all(Spacing.xl),
        actions: [
          AdaptiveActions(
            spacing: Spacing.xs,
            stackedSpacing: Spacing.xxs,
            children: [
              OutlinedButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(context.s.learnedLanguageStartOverButton),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(context.s.languagesContinueButton),
              ),
            ],
          ),
        ],
      ),
    );
    if (startsOver != null) bloc.add(LearnedLanguageResumeRequested(startsOver: startsOver));
  }

  Future<void> _delete(BuildContext context) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final label = _state.learned.language.toLabel(context);
    final isConfirmed = await confirms(
      context,
      title: context.s.learnedLanguageDeleteTitle(label),
      message: context.s.learnedLanguageDeleteMessage(label),
      confirmLabel: context.s.delete,
      isDestructive: true,
    );
    if (isConfirmed) bloc.add(const LearnedLanguageDeleteRequested());
  }
}

class const _Route({
  required final LearnedLanguageLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final setup = _state.setup;
    final learned = _state.learned;
    final askMeIn = learned.askMeIn;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RouteStop(language: setup.main, role: context.s.languagesSpeakTitle),
        const _RouteLine(),
        switch (askMeIn) {
          final askMeIn? => _AskMeInStop(
            askMeIn: askMeIn,
            setup: setup,
            learned: learned,
            isBusy: _state.isBusy,
          ),
          null => Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _state.isBusy ? null : () => _chooseAskMeIn(context, setup, learned),
              icon: const Icon(Icons.add_rounded),
              label: Text(context.s.learnedLanguageAddAskMeInButton),
            ),
          ),
        },
        const _RouteLine(),
        _RouteStop(language: learned.language, role: context.s.languagesLearnTitle),
      ],
    );
  }

  Future<void> _chooseAskMeIn(
    BuildContext context,
    LanguageSetup setup,
    LearnedLanguage learned,
  ) async {
    final bloc = context.read<LearnedLanguageBloc>();
    final language = await requestsLanguage(
      context,
      options: [
        for (final language in supportedLanguages)
          if (!language.isSameLanguageAs(setup.main) &&
              !language.isSameLanguageAs(learned.language))
            language,
      ],
    );
    if (language != null) bloc.add(LearnedLanguageAskMeInChanged(language: language));
  }
}

class const _AskMeInStop({
  required final Language _askMeIn,
  required final LanguageSetup _setup,
  required final LearnedLanguage _learned,
  required final bool _isBusy,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LearnedLanguageBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _RouteStop(
          language: _askMeIn,
          role: context.s.learnedLanguageAskMeInLabel,
          actions: [
            IconButton(
              onPressed: () => _explain(context),
              tooltip: context.s.learnedLanguageAskMeInHelpTooltip,
              icon: const Icon(Icons.help_outline_rounded),
            ),
            IconButton(
              onPressed: _isBusy
                  ? null
                  : () => bloc.add(const LearnedLanguageAskMeInChanged(language: null)),
              tooltip: context.s.learnedLanguageRemoveAskMeInTooltip,
              icon: const Icon(Icons.close_rounded),
            ),
          ],
        ),
        if (_setup.isLearning(_askMeIn))
          _LevelSlider(level: _learned.askMeInFromLevel, isBusy: _isBusy),
      ],
    );
  }

  void _explain(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog.adaptive(
        title: Text(context.s.learnedLanguageAskMeInLabel),
        content: Text(
          _setup.isLearning(_askMeIn)
              ? context.s.learnedLanguageAskMeInHelpMessage(
                  _askMeIn.toLabel(context),
                  _setup.main.toLabel(context),
                  _learned.language.toLabel(context),
                )
              : context.s.learnedLanguageAskMeInAlwaysHelpMessage(
                  _askMeIn.toLabel(context),
                  _setup.main.toLabel(context),
                  _learned.language.toLabel(context),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(context.s.close),
          ),
        ],
      ),
    );
  }
}

class const _LevelSlider({
  required final VocabularyLevel _level,
  required final bool _isBusy,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final level = useState(_level);
    useEffect(() {
      level.value = _level;
      return null;
    }, [_level]);
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.xxl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.s.learnedLanguageFromLevelLabel(level.value.toLabel(context)),
            style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
          ),
          Slider(
            value: level.value.index.toDouble(),
            max: (VocabularyLevel.values.length - 1).toDouble(),
            divisions: VocabularyLevel.values.length - 1,
            label: level.value.toLabel(context),
            onChanged: _isBusy
                ? null
                : (value) => level.value = VocabularyLevel.values[value.round()],
            onChangeEnd: (value) => context.read<LearnedLanguageBloc>().add(
              LearnedLanguageAskMeInLevelChanged(level: VocabularyLevel.values[value.round()]),
            ),
          ),
        ],
      ),
    );
  }
}

class const _RouteStop({
  required final Language _language,
  required final String _role,
  final List<Widget> _actions = const [],
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LanguageLabel(language: _language, showsName: false, style: context.t.headlineSmall),
        const SizedBox(width: Spacing.m),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_language.toLabel(context), style: context.t.titleMedium),
              Text(_role, style: context.t.bodySmall?.copyWith(color: context.c.onSurfaceVariant)),
            ],
          ),
        ),
        ..._actions,
      ],
    );
  }
}

class const _RouteLine() extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: Spacing.s, top: Spacing.xxxs, bottom: Spacing.xxxs),
        width: Spacing.borderWidthMedium,
        height: Spacing.xl,
        color: context.c.outlineVariant,
      ),
    );
  }
}

class const _SectionTitle({
  required final String _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacing.xs),
      child: Text(_title, style: context.t.titleSmall?.copyWith(color: context.c.primary)),
    );
  }
}
