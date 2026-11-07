import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';

const _maxLines = 4;

class const PracticeTextRow({
  super.key,
  required final String _text,
  required final TextStyle? _style,
  final Widget? _leading,
  final bool _isCentered = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_leading case final leading?) ...[
          SizedBox(
            width: Spacing.iconM,
            child: Center(child: leading),
          ),
          const SizedBox(width: Spacing.s),
        ],
        Flexible(
          child: Text(
            _text,
            style: _style,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: _isCentered ? TextAlign.center : TextAlign.start,
          ),
        ),
      ],
    );
  }
}
