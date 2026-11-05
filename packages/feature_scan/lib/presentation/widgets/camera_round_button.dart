import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _controlOpacity = 0.12;
const _disabledOpacity = 0.5;

class const CameraRoundButton({
  super.key,
  required final IconData _icon,
  required final String _tooltip,
  required final VoidCallback? _onPressed,
  final bool _isActive = false,
  final double _size = Spacing.xxxl,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: IconButton.filled(
        style: IconButton.styleFrom(
          backgroundColor: _isActive
              ? context.c.primary
              : context.overlay.onScrim.withValues(alpha: _controlOpacity),
          foregroundColor: context.overlay.onScrim,
          disabledBackgroundColor: context.overlay.onScrim.withValues(alpha: _controlOpacity),
          disabledForegroundColor: context.overlay.onScrim.withValues(alpha: _disabledOpacity),
        ),
        onPressed: _onPressed,
        tooltip: _tooltip,
        icon: Icon(_icon),
      ),
    );
  }
}
