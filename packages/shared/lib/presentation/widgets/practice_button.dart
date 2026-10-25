import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/extensions/int_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';

class const PracticeButton({
  super.key,
  required final int _dueCount,
  final String? _tagId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.passthrough,
      children: [
        ElevatedButton(
          onPressed: () => context.pushPractice(tagId: _tagId),
          child: Text(context.s.homePracticeButton),
        ),
        if (_dueCount > 0)
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
                  _dueCount.toCountLabel(context),
                  style: context.t.labelSmall?.copyWith(color: context.c.primary),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
