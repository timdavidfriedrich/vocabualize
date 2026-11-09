import 'package:core/theme/spacing.dart';
import 'package:feature_details/presentation/details_bloc.dart';
import 'package:feature_details/presentation/details_event.dart';
import 'package:feature_details/presentation/details_state.dart';
import 'package:feature_details/presentation/extensions/details_editing_extensions.dart';
import 'package:feature_details/presentation/widgets/edit_words_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';
import 'package:shared/presentation/widgets/button_progress.dart';

const _wordMaxLines = 2;

class const DetailsHeader({
  super.key,
  required final Language? _picked,
  required final ValueChanged<Language> _onPicked,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        if (state is! DetailsEditing) return const SizedBox.shrink();
        final shown = state.shownLanguage(_picked);
        final mainText = state.textOf(state.setup.main);
        final shownText = state.textOf(shown);
        Future<void> open() async {
          isOpen.value = true;
          await editWords(context, state, shown: shown, onShown: _onPicked);
          if (context.mounted) isOpen.value = false;
        }

        return Row(
          children: [
            const BackButton(),
            Expanded(
              child: Center(
                child: Material(
                  type: MaterialType.transparency,
                  borderRadius: BorderRadius.circular(Spacing.radiusXxl),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: state.runningAction == null ? open : null,
                    highlightColor: context.c.surfaceContainerHigh,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.m,
                        vertical: Spacing.xxs,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (shown != state.setup.main && mainText.isNotEmpty)
                            Text(
                              mainText,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.t.bodySmall?.copyWith(
                                color: context.c.onSurfaceVariant,
                              ),
                            ),
                          if (shown != state.setup.main && mainText.isNotEmpty)
                            const SizedBox(height: Spacing.xxxs),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child:
                                    shownText.isEmpty && state.translatingLanguages.contains(shown)
                                    ? const ButtonProgress()
                                    : Text(
                                        shownText.isEmpty
                                            ? context.s.detailsMissingTextLabel(
                                                shown.toLabel(context),
                                              )
                                            : shownText,
                                        textAlign: TextAlign.center,
                                        maxLines: _wordMaxLines,
                                        overflow: TextOverflow.ellipsis,
                                        style: context.t.bodyLarge?.copyWith(
                                          color: shownText.isEmpty
                                              ? context.c.onSurfaceVariant
                                              : context.c.onSurface,
                                          fontWeight: shownText.isEmpty ? null : FontWeight.bold,
                                        ),
                                      ),
                              ),
                              if (state.hasSeveralLanguages) ...[
                                const SizedBox(width: Spacing.xs),
                                _FlagChip(language: shown, isOpen: isOpen.value),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: shownText.isEmpty
                  ? null
                  : () => context.read<DetailsBloc>().add(DetailsSpeakRequested(language: shown)),
              tooltip: context.s.vocabularySpeakTooltip,
              icon: const Icon(Icons.volume_up_outlined),
            ),
          ],
        );
      },
    );
  }
}

class const _FlagChip({
  required final Language _language,
  required final bool _isOpen,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(Spacing.s, Spacing.xxxs, Spacing.xs, Spacing.xxxs),
      decoration: ShapeDecoration(
        color: context.c.primaryContainer,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_language.toFlag(), style: context.t.titleSmall),
          const SizedBox(width: Spacing.xxxs),
          Icon(
            _isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
            color: context.c.onPrimaryContainer,
          ),
        ],
      ),
    );
  }
}
