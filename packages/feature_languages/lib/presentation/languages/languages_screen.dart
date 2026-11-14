import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/add_language_row.dart';
import 'package:feature_languages/presentation/widgets/learned_language_row.dart';
import 'package:feature_languages/presentation/widgets/paused_languages_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';
import 'package:shared/presentation/widgets/section_title.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

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
            spacing: Spacing.tileGap,
            children: [
              for (final learned in setup.active)
                LearnedLanguageRow(
                  key: ValueKey(learned.language),
                  learned: learned,
                  wordCount: _state.wordCounts[learned.language],
                  state: _state,
                ),
              AddLanguageRow(state: _state),
            ],
          ),
        ),
        if (setup.paused.isNotEmpty) ...[
          const SizedBox(height: Spacing.xl),
          _Section(title: SectionTitle(title: context.s.languagesPausedTitle, isMuted: true)),
          for (final learned in setup.paused)
            Padding(
              padding: const EdgeInsets.only(bottom: Spacing.xs),
              child: PausedLanguagesCard(
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
