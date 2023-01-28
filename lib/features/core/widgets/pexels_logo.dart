import 'package:flutter/material.dart';

class PexelsLogo extends StatelessWidget {
  const PexelsLogo({super.key, Alignment? alignment, EdgeInsets? padding})
      : alignment = alignment ?? Alignment.bottomRight,
        padding = padding ?? const EdgeInsets.all(12);

  final Alignment alignment;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;

    return Container(
      alignment: alignment,
      padding: padding,
      child: Image.network(
        brightness == Brightness.dark
            ? "https://images.pexels.com/lib/api/pexels-white.png"
            : "https://images.pexels.com/lib/api/pexels.png",
        height: 24,
      ),
    );
  }
}
