import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _menuWidth = Spacing.xxxxl * 4 + Spacing.xxxl;
const _disabledOpacity = 0.38;

class const AppMenuAnchor({
  super.key,
  final String? _title,
  required final List<Widget> _items,
  required final Widget Function(BuildContext context, MenuController controller) _builder,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      clipBehavior: Clip.none,
      alignmentOffset: const Offset(0, Spacing.xxxs),
      menuChildren: [AppMenu(title: _title, items: _items)],
      builder: (context, controller, child) => _builder(context, controller),
    );
  }
}

class const AppMenu({
  super.key,
  final String? _title,
  required final List<Widget> _items,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      elevation: Spacing.elevationM,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: _menuWidth,
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_title case final title?)
                Padding(
                  padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.xs, Spacing.m, Spacing.xs),
                  child: Text(
                    title,
                    style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                  ),
                ),
              ..._items,
            ],
          ),
        ),
      ),
    );
  }
}

class const AppMenuItem({
  super.key,
  final Widget? _leading,
  required final String _title,
  final Widget? _tag,
  final String? _subtitle,
  final Widget? _trailing,
  final bool _isSelected = false,
  final bool _isDestructive = false,
  required final VoidCallback? _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final onTap = _onTap;
    final foreground = _isDestructive ? context.c.error : context.c.onSurface;
    return Opacity(
      opacity: onTap == null ? _disabledOpacity : 1,
      child: Material(
        type: _isSelected ? MaterialType.canvas : MaterialType.transparency,
        color: context.c.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(Spacing.radiusXl),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap == null
              ? null
              : () {
                  MenuController.maybeOf(context)?.close();
                  onTap();
                },
          child: Padding(
            padding: const EdgeInsets.all(Spacing.s),
            child: IconTheme.merge(
              data: IconThemeData(color: foreground),
              child: Row(
                children: [
                  if (_leading case final leading?) ...[
                    leading,
                    const SizedBox(width: Spacing.m),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_title, style: context.t.titleMedium?.copyWith(color: foreground)),
                        if (_subtitle != null || _tag != null)
                          Wrap(
                            spacing: Spacing.xs,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              if (_subtitle case final subtitle?)
                                Text(
                                  subtitle,
                                  style: context.t.bodyMedium?.copyWith(
                                    color: context.c.onSurfaceVariant,
                                  ),
                                ),
                              ?_tag,
                            ],
                          ),
                      ],
                    ),
                  ),
                  if (_trailing case final trailing?) ...[
                    const SizedBox(width: Spacing.xs),
                    trailing,
                  ],
                  if (_isSelected) ...[
                    const SizedBox(width: Spacing.xs),
                    Icon(Icons.check_rounded, color: context.c.primary),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
