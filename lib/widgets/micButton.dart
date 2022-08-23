import 'package:flutter/material.dart';

class MicButton extends StatefulWidget {
  const MicButton({Key? key}) : super(key: key);

  @override
  State<MicButton> createState() => _MicButtonState();
}

class _MicButtonState extends State<MicButton> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 300,
      elevation: 0,
      onPressed: () => setState(() => isActive = !isActive),
      color:
          isActive ? Theme.of(context).colorScheme.primary : Colors.transparent,
      shape: const CircleBorder(
        side: BorderSide(
          width: 8,
          color: Colors.white,
        ),
      ),
      child: Icon(
        Icons.mic_none_rounded,
        color: isActive
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.primary,
        size: 128,
      ),
    );
  }
}
