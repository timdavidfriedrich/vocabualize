import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_bloc.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_event.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/language_label.dart';

class const LanguageOnboardingScreen({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageOnboardingBloc, LanguageOnboardingState>(
      listenWhen: (previous, current) => switch ((previous, current)) {
        (
          LanguageOnboardingEditing(error: null),
          LanguageOnboardingEditing(error: _?),
        ) =>
          true,
        _ => false,
      },
      listener: (context, state) {
        if (state case LanguageOnboardingEditing(:final error?)) {
          context.showToast(error.toMessage(context));
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(context.s.languagesTitle)),
        body: BlocBuilder<LanguageOnboardingBloc, LanguageOnboardingState>(
          builder: (context, state) => switch (state) {
            LanguageOnboardingEditing() => _Content(state: state),
            LanguageOnboardingLoading() || LanguageOnboardingSaved() => const Center(
              child: CircularProgressIndicator(),
            ),
          },
        ),
      ),
    );
  }
}

class const _Content({
  required final LanguageOnboardingEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageOnboardingBloc>();
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
                  title: context.s.languagesSpeakTitle,
                  hint: context.s.languagesSpeakHint,
                  children: [
                    for (final language in supportedLanguages)
                      ChoiceChip(
                        label: LanguageLabel(language: language),
                        selected: language == _state.main,
                        onSelected: (_) =>
                            bloc.add(LanguageOnboardingMainChanged(language: language)),
                      ),
                  ],
                ),
                const SizedBox(height: Spacing.xl),
                _Section(
                  title: context.s.languagesLearnTitle,
                  hint: context.s.languagesLearnHint,
                  children: [
                    for (final language in supportedLanguages)
                      FilterChip(
                        label: LanguageLabel(language: language),
                        selected: _state.learned.contains(language),
                        onSelected: language.isSameLanguageAs(_state.main)
                            ? null
                            : (_) => bloc.add(LanguageOnboardingLearnedToggled(language: language)),
                      ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.xl),
            child: FilledButton(
              onPressed: _state.isSaving || _state.learned.isEmpty
                  ? null
                  : () => bloc.add(const LanguageOnboardingSaveRequested()),
              child: Text(context.s.languagesContinueButton),
            ),
          ),
        ],
      ),
    );
  }
}

class const _Section({
  required final String _title,
  required final String _hint,
  required final List<Widget> _children,
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
        Wrap(spacing: Spacing.xs, runSpacing: Spacing.xs, children: _children),
      ],
    );
  }
}
