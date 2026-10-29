import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _overlayOpacity = 0.5;
const _overlayFadeEnd = Alignment(0, -1 / 12);

class const PhotoOverlay({
  super.key,
  required final Widget _child,
  final BorderRadius _borderRadius = BorderRadius.zero,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: _borderRadius,
        backgroundBlendMode: BlendMode.darken,
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: _overlayFadeEnd,
          colors: [
            context.overlay.scrim.withValues(alpha: _overlayOpacity),
            context.overlay.scrim.withValues(alpha: 0),
          ],
        ),
      ),
      child: Align(alignment: Alignment.bottomCenter, child: _child),
    );
  }
}

class const PhotoCreditButton({
  super.key,
  required final String? _photographer,
  required final VoidCallback _onPressed,
  final BorderRadius _borderRadius = BorderRadius.zero,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PhotoOverlay(
      borderRadius: _borderRadius,
      child: TextButton(
        onPressed: _onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: Spacing.xs),
            Flexible(
              child: Text(
                context.s.vocabularyPhotoByLabel(_photographer ?? context.s.unknown),
                style: context.t.bodySmall?.copyWith(color: context.overlay.onScrim),
              ),
            ),
            const SizedBox(width: Spacing.xs),
            Icon(Icons.launch_rounded, size: Spacing.iconS, color: context.overlay.onScrim),
            const SizedBox(width: Spacing.xs),
          ],
        ),
      ),
    );
  }
}
