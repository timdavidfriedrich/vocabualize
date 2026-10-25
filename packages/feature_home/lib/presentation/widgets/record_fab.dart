import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

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
                          _RecordFabItem(
                            onPressed: () {
                              context.pushVocabularyDetails();
                              toggle();
                            },
                            icon: Icons.edit_rounded,
                            label: context.s.homeWriteButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: toggle,
                    isExtended: isOpen.value,
                    backgroundColor: isOpen.value
                        ? context.c.primary.withValues(alpha: _openButtonOpacity)
                        : context.c.primary,
                    icon: AnimatedRotation(
                      turns: isOpen.value ? _openIconTurns : 0,
                      duration: _animationDuration,
                      curve: Curves.easeOut,
                      child: const Icon(Icons.add_rounded),
                    ),
                    label: Text(context.s.cancel),
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
