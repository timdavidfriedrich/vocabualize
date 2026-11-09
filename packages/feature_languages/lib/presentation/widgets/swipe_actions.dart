import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';

const _actionWidth = Spacing.xxxxl + Spacing.xxs;
const _swipeDuration = Duration(milliseconds: 200);
const _openThreshold = 0.5;

class const SwipeAction({
  required final IconData icon,
  required final String label,
  required final Color color,
  required final Color textColor,
  required final VoidCallback onPressed,
});

class const SwipeActions({
  super.key,
  required final List<SwipeAction> _actions,
  required final Color _color,
  required final Widget _child,
  final VoidCallback? _onTap,
  final VoidCallback? _onBlockedSwipe,
}) extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: _swipeDuration);
    final actionsWidth = (_actionWidth + Spacing.xxxs) * _actions.length;
    void settle() => controller.animateTo(controller.value > _openThreshold ? 1 : 0);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragStart: switch (_onBlockedSwipe) {
        final onBlockedSwipe? when _actions.isEmpty => (_) => onBlockedSwipe(),
        _ => null,
      },
      onHorizontalDragUpdate: _actions.isEmpty
          ? null
          : (details) => controller.value -= (details.primaryDelta ?? 0) / actionsWidth,
      onHorizontalDragEnd: _actions.isEmpty ? null : (_) => settle(),
      child: Stack(
        children: [
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: Spacing.xxxs,
              children: [
                for (final action in _actions)
                  _ActionButton(
                    action: action,
                    onPressed: () {
                      controller.animateTo(0);
                      action.onPressed();
                    },
                  ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Padding(
              padding: EdgeInsets.only(right: controller.value * actionsWidth),
              child: Material(
                color: _color,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(controller.value * Spacing.radiusXxl),
                ),
                clipBehavior: Clip.antiAlias,
                child: child,
              ),
            ),
            child: InkWell(
              onTap: () {
                if (controller.value > 0) {
                  controller.animateTo(0);
                } else {
                  _onTap?.call();
                }
              },
              child: _child,
            ),
          ),
        ],
      ),
    );
  }
}

class const _ActionButton({
  required final SwipeAction _action,
  required final VoidCallback _onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _actionWidth,
      child: Material(
        color: _action.color,
        child: InkWell(
          onTap: _onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: Spacing.xxxs,
            children: [
              Icon(_action.icon, color: _action.textColor),
              Text(_action.label, style: context.t.labelLarge?.copyWith(color: _action.textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
