import 'package:flutter/material.dart';

class VisibilityButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool visible;
  final Color? background;
  final Color? foreground;

  const VisibilityButton({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.visible,
    this.background,
    this.foreground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: !visible ? null : onPressed,
      style: ElevatedButton.styleFrom(
          primary: !visible ? Colors.transparent : background ?? Theme.of(context).colorScheme.primary,
          onPrimary: !visible ? Colors.transparent : foreground ?? Theme.of(context).colorScheme.onPrimary),
      child: child,
    );
  }
}
