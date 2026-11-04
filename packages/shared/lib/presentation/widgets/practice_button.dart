import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/count_badge.dart';
import 'package:shared/presentation/widgets/icon_action_button.dart';

const _buttonHeight = Spacing.xxxl + Spacing.xxxs;
const _badgeOffset = -Spacing.xs;

class const PracticeButton({
  super.key,
  required final int _count,
  final String? _tagId,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Spacing.radiusXxl),
                    ),
                  ),
                  onPressed: () => context.pushPractice(tagId: _tagId),
                  child: Text(context.s.homePracticeButton),
                ),
                if (_count > 0)
                  Positioned(
                    top: _badgeOffset,
                    right: _badgeOffset,
                    child: CountBadge(
                      count: _count,
                      color: context.c.onPrimary,
                      textColor: context.c.primary,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: Spacing.s),
          IconActionButton(
            icon: const Icon(Icons.playlist_play_rounded, size: Spacing.iconM),
            tooltip: context.s.practiceCustomTooltip,
            onPressed: () => context.pushCustomPractice(tagId: _tagId),
          ),
        ],
      ),
    );
  }
}
