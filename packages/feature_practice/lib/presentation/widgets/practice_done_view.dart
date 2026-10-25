import 'package:core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/extensions/context_extensions.dart';
import 'package:shared/presentation/navigation/navigation_extensions.dart';
import 'package:shared/presentation/widgets/mascot.dart';

const _slideDuration = Duration(milliseconds: 500);
const _hiddenOffset = Offset(0, -1);

class const PracticeDoneView({
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TweenAnimationBuilder(
              tween: Tween(begin: _hiddenOffset, end: Offset.zero),
              duration: _slideDuration,
              curve: Curves.fastEaseInToSlowEaseOut,
              builder: (context, offset, child) =>
                  FractionalTranslation(translation: offset, child: child),
              child: const Mascot(pose: MascotPose.hanging),
            ),
            const Spacer(),
            Text(
              context.s.practiceDoneTitle,
              style: context.t.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.m),
            Text(
              context.s.practiceDoneMessage,
              style: context.t.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.xxxxl * 2),
            ElevatedButton(
              onPressed: context.closeScreen,
              child: Text(context.s.practiceDoneButton),
            ),
            const SizedBox(height: Spacing.xxxxl),
          ],
        ),
      ),
    );
  }
}
