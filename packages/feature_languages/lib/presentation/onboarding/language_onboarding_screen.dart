import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_bloc.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_event.dart';
import 'package:feature_languages/presentation/onboarding/language_onboarding_state.dart';
import 'package:feature_languages/presentation/widgets/language_option_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _gridColumns = 3;
const _tileHeight = Spacing.xxxxl + Spacing.xxxl + Spacing.xxxs;
const _disabledOpacity = 0.5;
const _stepBarHeight = Spacing.xxs;
const _fadeStart = 0.9;
const _nameMaxLines = 3;

enum _Step { speak, learn }

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
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final step = useState(_Step.speak);
    final bloc = context.read<LanguageOnboardingBloc>();
    return PopScope(
      canPop: step.value == _Step.speak,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) step.value = _Step.speak;
      },
      child: SafeArea(
        minimum: const EdgeInsets.only(bottom: Spacing.xxl),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: Spacing.xl),
              _StepBar(step: step.value),
              const SizedBox(height: Spacing.xxl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
                child: Text(
                  switch (step.value) {
                    _Step.speak => context.s.languageOnboardingSpeakTitle,
                    _Step.learn => context.s.languageOnboardingLearnTitle,
                  },
                  style: context.t.headlineMedium,
                ),
              ),
              if (step.value == _Step.learn) ...[
                const SizedBox(height: Spacing.xl),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
                  child: Text(
                    context.s.languagesLearnHint,
                    style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              ],
              const SizedBox(height: Spacing.l),
              Expanded(
                child: switch (step.value) {
                  _Step.speak => _SpeakList(main: _state.main),
                  _Step.learn => _LearnGrid(state: _state),
                },
              ),
              const SizedBox(height: Spacing.m),
              switch (step.value) {
                _Step.speak => ElevatedButton(
                  onPressed: () => step.value = _Step.learn,
                  child: Text(context.s.languagesContinueButton),
                ),
                _Step.learn => ElevatedButton(
                  onPressed: _state.isSaving || _state.learned.isEmpty
                      ? null
                      : () => bloc.add(const LanguageOnboardingSaveRequested()),
                  child: _state.isSaving
                      ? const ButtonProgress()
                      : Text(
                          _state.learned.isEmpty
                              ? context.s.languagesContinueButton
                              : context.s.languageOnboardingContinueWithButton(
                                  _state.learned.length,
                                ),
                        ),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}

class const _StepBar({
  required final _Step _step,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: Spacing.xs,
      children: [
        for (final step in _Step.values)
          Expanded(
            child: Container(
              height: _stepBarHeight,
              decoration: BoxDecoration(
                color: step.index <= _step.index ? context.c.primary : context.c.surfaceContainer,
                borderRadius: BorderRadius.circular(Spacing.radiusFull),
              ),
            ),
          ),
      ],
    );
  }
}

class const _SpeakList({
  required final Language _main,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageOnboardingBloc>();
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0, _fadeStart, 1],
        colors: [
          context.overlay.scrim,
          context.overlay.scrim,
          context.overlay.scrim.withValues(alpha: 0),
        ],
      ).createShader(bounds),
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: Spacing.xxxl),
        itemCount: supportedLanguages.length,
        separatorBuilder: (_, _) => const SizedBox(height: Spacing.xs),
        itemBuilder: (context, index) {
          final language = supportedLanguages[index];
          return LanguageOptionRow(
            language: language,
            isSelected: language == _main,
            onTap: () => bloc.add(LanguageOnboardingMainChanged(language: language)),
          );
        },
      ),
    );
  }
}

class const _LearnGrid({
  required final LanguageOnboardingEditing _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _gridColumns,
        mainAxisSpacing: Spacing.xs,
        crossAxisSpacing: Spacing.xs,
        mainAxisExtent: _tileHeight,
      ),
      padding: const EdgeInsets.only(bottom: Spacing.m),
      itemCount: supportedLanguages.length,
      itemBuilder: (context, index) {
        final language = supportedLanguages[index];
        return _LearnTile(
          language: language,
          isSelected: _state.learned.contains(language),
          isEnabled: !language.isSameLanguageAs(_state.main),
        );
      },
    );
  }
}

class const _LearnTile({
  required final Language _language,
  required final bool _isSelected,
  required final bool _isEnabled,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguageOnboardingBloc>();
    final foreground = _isSelected ? context.c.onPrimary : context.c.onSurface;
    return Opacity(
      opacity: _isEnabled ? 1 : _disabledOpacity,
      child: Material(
        color: _isSelected ? context.c.primary : context.c.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _isEnabled
              ? () => bloc.add(LanguageOnboardingLearnedToggled(language: _language))
              : null,
          child: Padding(
            padding: const EdgeInsets.all(Spacing.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(_language.toFlag(), style: context.t.headlineSmall)),
                    if (_isSelected) Icon(Icons.check_rounded, color: foreground),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      _language.toLabel(context),
                      maxLines: _nameMaxLines,
                      overflow: TextOverflow.ellipsis,
                      style: context.t.titleSmall?.copyWith(color: foreground),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
