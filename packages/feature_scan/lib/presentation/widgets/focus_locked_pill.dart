import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _pillOpacity = 0.6;

class const FocusLockedPill({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.overlay.scrim.withValues(alpha: _pillOpacity),
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m, vertical: Spacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.lock_outline_rounded, size: Spacing.iconS, color: context.c.primary),
            const SizedBox(width: Spacing.xs),
            Text(
              context.s.scanFocusLockedLabel,
              style: context.t.labelLarge?.copyWith(color: context.c.primary),
            ),
          ],
        ),
      ),
    );
  }
}
