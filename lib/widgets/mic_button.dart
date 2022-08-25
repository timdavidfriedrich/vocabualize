import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/visible_provider.dart';

class MicButton extends StatelessWidget {
  const MicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        Provider.of<VisibleProv>(context, listen: false).setMicIsActive(true);
      },
      onTapCancel: () {
        Provider.of<VisibleProv>(context, listen: false).setMicIsActive(false);
      },
      onTapUp: (e) {
        Provider.of<VisibleProv>(context, listen: false).setMicIsActive(false);
      },
      child: Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Provider.of<VisibleProv>(context).getMicIsActive()
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
                width: 8, color: Theme.of(context).colorScheme.secondary)),
        child: AvatarGlow(
          animate: Provider.of<VisibleProv>(context).getMicIsActive(),
          endRadius: MediaQuery.of(context).size.width / 2,
          repeat: true,
          repeatPauseDuration: Duration.zero,
          duration: const Duration(milliseconds: 2500),
          startDelay: Duration.zero,
          showTwoGlows: true,
          curve: Curves.fastOutSlowIn,
          glowColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Provider.of<VisibleProv>(context).getMicIsActive()
                ? Icons.mic_rounded
                : Icons.mic_none_rounded,
            color: Provider.of<VisibleProv>(context).getMicIsActive()
                ? Theme.of(context).colorScheme.onSecondary
                : Theme.of(context).colorScheme.secondary,
            size: 128,
          ),
        ),
      ),
    );
  }
}
