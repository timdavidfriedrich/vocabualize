import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/icon_action_button.dart';

class const PracticeButton({
  super.key,
  required final int _count,
  final String? _tagId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.passthrough,
            children: [
              ElevatedButton(
                onPressed: () => context.pushPractice(tagId: _tagId),
                child: Text(context.s.homePracticeButton),
              ),
              if (_count > 0)
                Positioned(
                  top: -Spacing.xxxs,
                  right: -Spacing.xxxs,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.c.onPrimary,
                      borderRadius: BorderRadius.circular(Spacing.radiusL),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
                      child: Text(
                        _count.toCountLabel(context),
                        style: context.t.labelSmall?.copyWith(color: context.c.primary),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: Spacing.xs),
        IconActionButton(
          icon: const Icon(Icons.playlist_play_rounded),
          tooltip: context.s.practiceCustomTooltip,
          onPressed: () => context.pushCustomPractice(tagId: _tagId),
        ),
      ],
    );
  }
}
