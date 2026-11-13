import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _size = Spacing.xxxl;

class const RoundIconButton({
  super.key,
  required final IconData _icon,
  required final String _tooltip,
  final Color? _color,
  final Color? _iconColor,
  required final VoidCallback? _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: _color ?? context.c.surfaceContainerHighest,
          foregroundColor: _iconColor ?? context.c.onSurface,
        ),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon),
      ),
    );
  }
}
