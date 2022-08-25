import 'package:flutter/material.dart';
import 'package:vocabualize/utils/logging.dart';

class MicButton extends StatefulWidget {
  const MicButton({Key? key}) : super(key: key);

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (e) {
        printHint("hi");
        setState(() => isActive = true);
      },
      onTapUp: (e) => setState(() => isActive = false),
      child: Container(
        height: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(
                width: 8, color: Theme.of(context).colorScheme.secondary)),
        child: Icon(
          Icons.mic_none_rounded,
          color: isActive
              ? Theme.of(context).colorScheme.onSecondary
              : Theme.of(context).colorScheme.secondary,
          size: 128,
        ),
      ),
    );
  }
}
