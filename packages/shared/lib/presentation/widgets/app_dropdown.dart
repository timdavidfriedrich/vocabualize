import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/app_menu.dart';

const _chipMinHeight = Spacing.xxl + Spacing.xs;

class const AppDropdown<T>({
  super.key,
  final String? _title,
  required final T _value,
  required final List<T> _options,
  required final String Function(T option) _labelOf,
  final IconData? Function(T option)? _iconOf,
  required final ValueChanged<T> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final hasIcons = _options.any((option) => _iconOf?.call(option) != null);
    return AppMenuAnchor(
      title: _title,
      items: [
        for (final option in _options)
          AppMenuItem(
            leading: switch (_iconOf?.call(option)) {
              final icon? => Icon(icon),
              null when hasIcons => const SizedBox.square(dimension: Spacing.iconM),
              null => null,
            },
            title: _labelOf(option),
            isSelected: option == _value,
            onTap: () => _onSelected(option),
          ),
      ],
      builder: (context, controller) => DropdownChip(
        leading: switch (_iconOf?.call(_value)) {
          final icon? => Icon(icon, size: Spacing.iconS),
          null => null,
        },
        label: _labelOf(_value),
        isOpen: controller.isOpen,
        onPressed: () => controller.isOpen ? controller.close() : controller.open(),
      ),
    );
  }
}

class const DropdownChip({
  super.key,
  final Widget? _leading,
  final String? _label,
  final String? _semanticsLabel,
  required final bool _isOpen,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final foreground = _isOpen ? context.c.onPrimary : context.c.onSurface;
    return Semantics(
      label: _semanticsLabel,
      button: true,
      child: Material(
        color: _isOpen ? context.c.primary : context.c.surfaceContainer,
        borderRadius: BorderRadius.circular(Spacing.radiusL),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onPressed,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _chipMinHeight),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.s, 0, Spacing.xs, 0),
              child: IconTheme.merge(
                data: IconThemeData(color: foreground),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_leading case final leading?) ...[
                      leading,
                      const SizedBox(width: Spacing.xxs),
                    ],
                    if (_label case final label?) ...[
                      Text(label, style: context.t.labelLarge?.copyWith(color: foreground)),
                      const SizedBox(width: Spacing.xxxs),
                    ],
                    Icon(
                      _isOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
