import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const focusRingSize = Spacing.xxxxl + Spacing.s;

class const FocusRing({
  super.key,
  required final bool _isLocked,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: focusRingSize,
      height: focusRingSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: _isLocked ? context.c.primary : context.overlay.onScrim,
          width: Spacing.borderWidthMedium,
        ),
      ),
    );
  }
}
