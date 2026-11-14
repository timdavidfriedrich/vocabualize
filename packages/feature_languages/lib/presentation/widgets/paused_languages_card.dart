import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/extensions/languages_context_extensions.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/tonal_button.dart';

const _dimmedOpacity = 0.6;
const _expandDuration = Duration(milliseconds: 200);

class const PausedLanguagesCard({
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
                      onPressed: _state.isBusy
                          ? null
                          : () => context.requestLanguageDelete(_state, _language),
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
