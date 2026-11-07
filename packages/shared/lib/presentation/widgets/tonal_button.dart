import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const TonalButton({
  super.key,
  required final VoidCallback? _onPressed,
  required final Widget _child,
  final bool _isDestructive = false,
  final bool _isCompact = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final (backgroundColor, foregroundColor) = switch (_isDestructive) {
      true => (context.c.errorContainer, context.c.onErrorContainer),
      false => (context.c.primaryContainer, context.c.onPrimaryContainer),
    };
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        padding: _isCompact ? const EdgeInsets.symmetric(horizontal: Spacing.m) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusL)),
      ),
      onPressed: _onPressed,
      child: _child,
    );
  }
}
