import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

const _rowHeight = Spacing.xxxl + Spacing.s;
const _disabledOpacity = 0.5;

class const LanguageOptionRow({
  super.key,
  required final Language _language,
  required final bool _isSelected,
  required final VoidCallback? _onTap,
  final Widget? _trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final (background, foreground) = _isSelected
        ? (context.c.secondaryContainer, context.c.onSecondaryContainer)
        : (context.c.surfaceContainerLowest, context.c.onSurface);
    return Opacity(
      opacity: _onTap == null && !_isSelected ? _disabledOpacity : 1,
      child: Material(
        color: background,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onTap,
          child: SizedBox(
            height: _rowHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
              child: Row(
                children: [
                  Text(_language.toFlag(), style: context.t.titleLarge),
                  const SizedBox(width: Spacing.m),
                  Expanded(
                    child: Text(
                      _language.toLabel(context),
                      style: context.t.titleMedium?.copyWith(color: foreground),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ?_trailing,
                  if (_isSelected) Icon(Icons.check_rounded, color: context.c.primary),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
