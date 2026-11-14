import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/widgets/selection_indicators.dart';

class const LanguageWordsOptionCard({
  super.key,
  required final String _title,
  required final String _subtitle,
  required final bool _isSelected,
  required final VoidCallback _onTap,
  final List<Widget> _children = const [],
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: _isSelected ? context.c.primaryContainer : context.c.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _onTap,
            child: Padding(
              padding: const EdgeInsets.all(Spacing.m),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_title, style: context.t.titleMedium),
                        Text(
                          _subtitle,
                          style: context.t.bodyMedium?.copyWith(color: context.c.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  RadioIndicator(isSelected: _isSelected),
                ],
              ),
            ),
          ),
          if (_children.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(Spacing.m, 0, Spacing.m, Spacing.m),
              child: Column(children: _children),
            ),
        ],
      ),
    );
  }
}
