import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

class const PillSegment({
  super.key,
  required final bool _isSelected,
  required final VoidCallback? _onTap,
  required final EdgeInsetsGeometry _padding,
  required final Widget _child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.primary : Colors.transparent,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(padding: _padding, child: _child),
      ),
    );
  }
}
