import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const IconActionButton({
  super.key,
  required final Widget _icon,
  required final String _tooltip,
  required final VoidCallback? _onPressed,
  final bool _isDestructive = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final (backgroundColor, foregroundColor) = switch (_isDestructive) {
      true => (context.c.errorContainer, context.c.onErrorContainer),
      false => (context.c.primaryContainer, context.c.onPrimaryContainer),
    };
    return Tooltip(
      message: _tooltip,
      child: SizedBox(
        width: Spacing.xxxxl,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
          ),
          onPressed: _onPressed,
          child: _icon,
        ),
      ),
    );
  }
}
