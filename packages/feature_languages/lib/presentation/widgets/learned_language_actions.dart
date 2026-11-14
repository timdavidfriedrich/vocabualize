import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_bloc.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_event.dart';
import 'package:feature_languages/presentation/learned_language/learned_language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const LearnedLanguageActions({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnedLanguageBloc, LearnedLanguageState>(
      builder: (context, state) => switch (state) {
        final LearnedLanguageLoaded loaded => _ActionButtons(state: loaded),
        LearnedLanguageLoading() ||
        LearnedLanguageClosed() ||
        LearnedLanguageFailure() => const SizedBox.shrink(),
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
