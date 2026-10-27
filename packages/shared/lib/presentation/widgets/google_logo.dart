import 'package:core/theme/spacing.dart';
import 'package:flutter/widgets.dart';

const _package = "shared";
const _assetPath = "assets/logos/google_logo.webp";

class const GoogleLogo({
  super.key,
  final double _size = Spacing.iconM,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(_assetPath, package: _package, width: _size, height: _size);
  }
}
