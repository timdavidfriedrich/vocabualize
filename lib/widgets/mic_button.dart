import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabualize/utils/providers/active_provider.dart';
import 'package:vocabualize/utils/speech.dart';

class MicButton extends StatelessWidget {
  const MicButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Speech.record(),
      child: Container(
        height: Provider.of<ActiveProv>(context).typeIsActive ? 0 : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Provider.of<ActiveProv>(context).micIsActive ? Theme.of(context).colorScheme.onPrimary : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(width: 8, color: Theme.of(context).colorScheme.onPrimary)),
        child: AvatarGlow(
          animate: Provider.of<ActiveProv>(context).micIsActive,
          endRadius: MediaQuery.of(context).size.width / 2,
          repeat: true,
          repeatPauseDuration: Duration.zero,
          duration: const Duration(milliseconds: 2500),
          startDelay: Duration.zero,
          showTwoGlows: true,
          curve: Curves.fastOutSlowIn,
          glowColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Provider.of<ActiveProv>(context).micIsActive ? Icons.mic_rounded : Icons.mic_none_rounded,
            color: Provider.of<ActiveProv>(context).typeIsActive
                ? Colors.transparent
                : Provider.of<ActiveProv>(context).micIsActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
            size: 128,
          ),
        ),
      ),
    );
  }
}
