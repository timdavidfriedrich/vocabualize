import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

class const LanguageSegments({
  super.key,
  required final List<Language> _languages,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.c.surfaceContainerLow,
        shape: const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: Row(
          children: [
            for (final (index, language) in _languages.indexed) ...[
              if (index > 0)
                Icon(
                  Icons.chevron_right_rounded,
                  size: Spacing.iconS,
                  color: context.c.onSurfaceVariant,
                ),
              Expanded(
                child: _Segment(
                  language: language,
                  isSelected: language == _selected,
                  onTap: () => _onSelected(language),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class const _Segment({
  required final Language _language,
  required final bool _isSelected,
  required final VoidCallback _onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final style = context.t.labelLarge?.copyWith(
      color: _isSelected ? context.c.onPrimary : context.c.onSurface,
    );
    return Material(
      color: _isSelected ? context.c.primary : Colors.transparent,
      shape: const StadiumBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Spacing.xs, vertical: Spacing.s),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_language.toFlag(), style: style),
              const SizedBox(width: Spacing.xs),
              Flexible(
                child: Text(
                  _language.toShortLabel(context),
                  style: style,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
