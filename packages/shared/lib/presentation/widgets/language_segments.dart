import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/domain/entities/language.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/language_extensions.dart';

const _inactiveOpacity = 0.45;

class const LanguageSegments({
  super.key,
  required final List<Language> _languages,
  required final Language _selected,
  required final ValueChanged<Language> _onSelected,
  final Set<Language> _inactiveLanguages = const {},
  final bool _isVertical = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _Segment segment(Language language) => _Segment(
      language: language,
      isSelected: language == _selected,
      isInactive: _inactiveLanguages.contains(language),
      isVertical: _isVertical,
      onTap: () => _onSelected(language),
    );
    return DecoratedBox(
      decoration: ShapeDecoration(
        color: context.c.surfaceContainerLow,
        shape: _isVertical
            ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(Spacing.radiusXxl))
            : const StadiumBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.xxxs),
        child: switch (_isVertical) {
          true => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [for (final language in _languages) segment(language)],
          ),
          false => Row(
            children: [
              for (final (index, language) in _languages.indexed) ...[
                if (index > 0)
                  Icon(
                    Icons.chevron_right_rounded,
                    size: Spacing.iconS,
                    color: context.c.onSurfaceVariant,
                  ),
                Expanded(child: segment(language)),
              ],
            ],
          ),
        },
      ),
    );
  }
}

class const _Segment({
  required final Language _language,
  required final bool _isSelected,
  required final bool _isInactive,
  required final bool _isVertical,
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
          padding: EdgeInsets.symmetric(
            horizontal: _isVertical ? Spacing.m : Spacing.xs,
            vertical: Spacing.s,
          ),
          child: Opacity(
            opacity: _isInactive ? _inactiveOpacity : 1,
            child: Row(
              mainAxisAlignment: _isVertical ? MainAxisAlignment.start : MainAxisAlignment.center,
              children: [
                Text(_language.toFlag(), style: style),
                SizedBox(width: _isVertical ? Spacing.s : Spacing.xs),
                Flexible(
                  child: Text(
                    _isVertical ? _language.toLabel(context) : _language.toShortLabel(context),
                    style: style,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
