import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/flag_circle.dart';
import 'package:feature_languages/presentation/widgets/language_option_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/presentation/extensions/app_error_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/page_app_bar.dart';

class const MainLanguageScreen({
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
        appBar: PageAppBar(title: Text(context.s.languagesSpeakTitle)),
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
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, Spacing.xxxl),
      itemCount: supportedLanguages.length,
      separatorBuilder: (_, _) => const SizedBox(height: Spacing.xs),
      itemBuilder: (context, index) {
        final language = supportedLanguages[index];
        final keepsActive = setup.active.any(
          (learned) => !learned.language.isSameLanguageAs(language),
        );
        return LanguageOptionRow(
          language: language,
          isSelected: language == setup.main,
          onTap: language == setup.main || !keepsActive || _state.isBusy
              ? null
              : () => _change(context, language),
        );
      },
    );
  }

  Future<void> _change(BuildContext context, Language language) async {
    final bloc = context.read<LanguagesBloc>();
    final clashing = _state.setup.active
        .where((learned) => learned.language.isSameLanguageAs(language))
        .firstOrNull;
    if (clashing != null) {
      final switches = await _confirmsSwitch(
        context,
        setup: _state.setup,
        learned: clashing.language,
        wordCount: _state.wordCounts[clashing.language] ?? 0,
      );
      if (!switches) return;
    }
    bloc.add(LanguagesMainLanguageChanged(language: language));
  }

  Future<bool> _confirmsSwitch(
    BuildContext context, {
    required LanguageSetup setup,
    required Language learned,
    required int wordCount,
  }) async {
    final label = learned.toShortLabel(context);
    final mainLabel = setup.main.toShortLabel(context);
    final emphasis = context.s.mainLanguageClashEmphasis;
    final title = context.s.mainLanguageClashTitle(emphasis, label);
    final emphasisStart = title.indexOf(emphasis);
    final switches = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.c.surfaceContainerLowest,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: Spacing.m,
                children: [
                  FlagCircle(
                    language: setup.main,
                    color: context.c.primaryContainer,
                    size: largeFlagCircleSize,
                  ),
                  Icon(Icons.arrow_forward_rounded, color: context.c.primary),
                  FlagCircle(
                    language: learned,
                    color: context.c.secondaryContainer,
                    size: largeFlagCircleSize,
                  ),
                ],
              ),
              const SizedBox(height: Spacing.l),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
                child: Text.rich(
                  emphasisStart < 0
                      ? TextSpan(text: title)
                      : TextSpan(
                          children: [
                            TextSpan(text: title.substring(0, emphasisStart)),
                            TextSpan(
                              text: emphasis,
                              style: const TextStyle(fontStyle: FontStyle.italic),
                            ),
                            TextSpan(text: title.substring(emphasisStart + emphasis.length)),
                          ],
                        ),
                  style: context.t.headlineSmall,
                ),
              ),
              const SizedBox(height: Spacing.s),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.xxxs),
                child: Text(
                  context.s.mainLanguageClashMessage(label, wordCount),
                  style: context.t.bodyLarge?.copyWith(color: context.c.onSurfaceVariant),
                ),
              ),
              const SizedBox(height: Spacing.l),
              ElevatedButton(
                onPressed: () => Navigator.of(sheetContext).pop(true),
                child: Text(context.s.mainLanguageClashSwitchButton(label)),
              ),
              const SizedBox(height: Spacing.s),
              TextButton(
                style: TextButton.styleFrom(textStyle: context.t.labelLarge),
                onPressed: () => Navigator.of(sheetContext).pop(false),
                child: Text(context.s.mainLanguageClashKeepButton(mainLabel)),
              ),
            ],
          ),
        ),
      ),
    );
    return switches ?? false;
  }
}
