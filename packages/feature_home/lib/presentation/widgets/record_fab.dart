import 'package:core/theme/spacing.dart';
import 'package:feature_home/presentation/widgets/write_word_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/domain/entities/default_gather_option.dart';
import 'package:shared/domain/entities/language_setup.dart';
import 'package:shared/domain/entities/preferences.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/default_gather_option_extensions.dart';
import 'package:shared/presentation/language_setup/language_setup_cubit.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/preferences/preferences_cubit.dart';

const _animationDuration = Duration(milliseconds: 200);
const _overlayOpacity = 0.5;
const _openButtonOpacity = 0.25;
const _openIconTurns = 0.125;

class const RecordFab({
  super.key,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isOpen = useState(false);
    void toggle() => isOpen.value = !isOpen.value;
    final defaultOption = context.select<PreferencesCubit, DefaultGatherOption>(
      (cubit) => cubit.state.defaultGatherOption.withImagesHidden(cubit.state.areImagesHidden),
    );
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          right: -Spacing.xxxxl,
          bottom: -Spacing.xxxxl,
          child: AnimatedScale(
            duration: Duration.zero,
            alignment: Alignment.bottomRight,
            scale: isOpen.value ? 1 : 0,
            child: AnimatedOpacity(
              duration: _animationDuration,
              curve: Curves.easeOut,
              opacity: isOpen.value ? 1 : 0,
              child: GestureDetector(
                onTap: toggle,
                child: ColoredBox(color: context.c.scrim.withValues(alpha: _overlayOpacity)),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: context.c.surfaceContainerLow,
              borderRadius: BorderRadius.circular(Spacing.radiusL),
            ),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedSize(
                    duration: _animationDuration,
                    curve: Curves.easeOut,
                    child: SizedBox(
                      height: isOpen.value ? null : 0,
                      width: isOpen.value ? null : 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          BlocSelector<PreferencesCubit, Preferences, bool>(
                            selector: (preferences) => preferences.areImagesHidden,
                            builder: (context, areImagesHidden) => switch (areImagesHidden) {
                              true => const SizedBox.shrink(),
                              false => _RecordFabItem(
                                onPressed: () {
                                  toggle();
                                  context.pushScan();
                                },
                                icon: Icons.camera_alt_rounded,
                                label: context.s.homeScanButton,
                              ),
                            },
                          ),
                          _RecordFabItem(
                            onPressed: () {
                              toggle();
                              _write(context);
                            },
                            icon: Icons.edit_rounded,
                            label: context.s.homeWriteButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPress: isOpen.value
                        ? null
                        : () {
                            Feedback.forLongPress(context);
                            toggle();
                          },
                    child: FloatingActionButton.extended(
                      heroTag: null,
                      onPressed: switch ((isOpen.value, defaultOption)) {
                        (true, _) || (false, DefaultGatherOption.none) => toggle,
                        (false, DefaultGatherOption.scan) => context.pushScan,
                        (false, DefaultGatherOption.write) => () => _write(context),
                      },
                      isExtended: isOpen.value,
                      foregroundColor: context.c.onPrimary,
                      backgroundColor: isOpen.value
                          ? context.c.primary.withValues(alpha: _openButtonOpacity)
                          : context.c.primary,
                      icon: AnimatedRotation(
                        turns: isOpen.value ? _openIconTurns : 0,
                        duration: _animationDuration,
                        curve: Curves.easeOut,
                        child: Icon(switch ((isOpen.value, defaultOption)) {
                          (false, DefaultGatherOption.scan) => Icons.camera_alt_rounded,
                          (false, DefaultGatherOption.write) => Icons.edit_rounded,
                          _ => Icons.add_rounded,
                        }),
                      ),
                      label: Text(context.s.cancel),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class const _RecordFabItem({
  required final VoidCallback _onPressed,
  required final IconData _icon,
  required final String _label,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      backgroundColor: context.c.surfaceContainerLow,
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      highlightElevation: 0,
      onPressed: _onPressed,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: Spacing.m),
            Icon(_icon),
            const SizedBox(width: Spacing.xs),
            Text(_label),
            const SizedBox(width: Spacing.m),
          ],
        ),
      ),
    );
  }
}

Future<void> _write(BuildContext context) async {
  final setup = context.read<LanguageSetupCubit>().state;
  if (setup == null) return;
  final word = await requestsWrittenWord(
    context,
    languages: [setup.main, for (final learned in setup.active) learned.language],
  );
  if (word != null && context.mounted) {
    await context.pushNewVocabularyDetails(text: word.text, language: word.language);
  }
}
