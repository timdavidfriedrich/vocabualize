import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/confirmation_dialog.dart';
import 'package:feature_languages/presentation/widgets/language_picker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

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
        appBar: AppBar(title: Text(context.s.languagesTitle)),
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
      padding: const EdgeInsets.symmetric(vertical: Spacing.m),
      children: [
        _SectionTitle(title: context.s.languagesSpeakTitle),
        ListTile(
          title: LanguageLabel(language: setup.main),
          trailing: TextButton(
            onPressed: _state.isBusy ? null : () => _changeMain(context, setup),
            child: Text(context.s.languagesChangeButton),
          ),
        ),
        const SizedBox(height: Spacing.m),
        _SectionTitle(title: context.s.languagesLearnTitle),
        for (final learned in setup.active)
          _LearnedTile(language: learned.language, wordCount: _state.wordCounts[learned.language]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _state.isBusy ? null : () => _addLanguage(context, setup),
              icon: const Icon(Icons.add_rounded),
              label: Text(context.s.languagesAddButton),
            ),
          ),
        ),
        if (setup.paused.isNotEmpty) ...[
          const SizedBox(height: Spacing.m),
          _SectionTitle(title: context.s.languagesPausedTitle),
          for (final learned in setup.paused)
            _LearnedTile(
              language: learned.language,
              wordCount: _state.wordCounts[learned.language],
            ),
        ],
      ],
    );
  }

  Future<void> _changeMain(BuildContext context, LanguageSetup setup) async {
    final bloc = context.read<LanguagesBloc>();
    final activeLanguages = [for (final learned in setup.active) learned.language];
    final language = await requestsLanguage(
      context,
      options: [
        for (final language in supportedLanguages)
          if (language != setup.main &&
              activeLanguages.any((active) => !active.isSameLanguageAs(language)))
            language,
      ],
    );
    if (language == null || !context.mounted) return;
    final clashing = activeLanguages.where((active) => active.isSameLanguageAs(language));
    if (clashing.isNotEmpty) {
      final label = clashing.first.toLabel(context);
      final isConfirmed = await confirms(
        context,
        title: context.s.languagesMainClashTitle(language.toLabel(context)),
        message: context.s.languagesMainClashMessage(label),
        confirmLabel: context.s.languagesMainClashButton,
      );
      if (!isConfirmed) return;
    }
    bloc.add(LanguagesMainLanguageChanged(language: language));
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

class const _LearnedTile({
  required final Language _language,
  required final int? _wordCount,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: LanguageLabel(language: _language),
      subtitle: switch (_wordCount) {
        final count? => Text(context.s.languagesWordCount(count)),
        null => null,
      },
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => context.pushLearnedLanguageDetails(language: _language),
    );
  }
}

class const _SectionTitle({
  required final String _title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xs, Spacing.m, Spacing.xxxs),
      child: Text(_title, style: context.t.titleSmall?.copyWith(color: context.c.primary)),
    );
  }
}
