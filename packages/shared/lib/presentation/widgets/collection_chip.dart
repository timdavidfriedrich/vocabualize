import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/tag.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const collectionChipHeight = Spacing.xxl + Spacing.xxxs;

class const CollectionChip({
  super.key,
  required final Tag _tag,
  required final bool _isSelected,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foreground = _isSelected ? context.c.onPrimary : context.c.onSurfaceVariant;
    return SizedBox(
      height: collectionChipHeight,
      child: Material(
        color: _isSelected ? context.c.primary : context.c.surfaceContainerLow,
        shape: const StadiumBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_isSelected) ...[
                  Icon(Icons.check_rounded, size: Spacing.iconS, color: foreground),
                  const SizedBox(width: Spacing.xs),
                ],
                if (_tag.emoji case final emoji?) ...[
                  Text(emoji, style: context.t.labelMedium),
                  const SizedBox(width: Spacing.xs),
                ],
                Text(_tag.name, style: context.t.labelMedium?.copyWith(color: foreground)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
