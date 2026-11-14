import 'package:core/theme/spacing.dart';
import 'package:feature_languages/presentation/extensions/languages_context_extensions.dart';
import 'package:feature_languages/presentation/languages/languages_bloc.dart';
import 'package:feature_languages/presentation/languages/languages_event.dart';
import 'package:feature_languages/presentation/languages/languages_state.dart';
import 'package:feature_languages/presentation/widgets/swipe_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/language_setup_extensions.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/asks_in_tag.dart';

const _pausedActionAlpha = 0.2;

class const LearnedLanguageRow({
  super.key,
  required final LearnedLanguage _learned,
  required final int? _wordCount,
  required final LanguagesLoaded _state,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LanguagesBloc>();
    final language = _learned.language;
    final isLastActive = _state.setup.active.length == 1;
    final canLeave = !isLastActive && !_state.isBusy;
    return SwipeActions(
      color: context.c.surfaceContainerLowest,
      onTap: () => context.pushLearnedLanguageDetails(language: language),
      onBlockedSwipe: isLastActive
          ? () => context.showToast(context.s.learnedLanguageLastActiveHint)
          : null,
      actions: [
        if (canLeave) ...[
          SwipeAction(
            icon: Icons.pause_rounded,
            label: context.s.languagesPauseButton,
            color: context.status.warning.withValues(alpha: _pausedActionAlpha),
            textColor: context.status.warning,
            onPressed: () => bloc.add(LanguagesPauseRequested(language: language)),
          ),
          SwipeAction(
            icon: Icons.delete_outline_rounded,
            label: context.s.delete,
            color: context.c.error,
            textColor: context.c.onError,
            onPressed: () => context.requestLanguageDelete(_state, language),
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
                        AsksInTag(language: askMeIn),
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
