import 'package:flutter/widgets.dart';

const _package = "shared";
const _assetPath = "assets/fallback/fallback_default.webp";

class const VocabularyFallbackImage({
  super.key,
  required final double _displayWidth,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image(
      image: ResizeImage(
        const AssetImage(_assetPath, package: _package),
        width: (_displayWidth * MediaQuery.devicePixelRatioOf(context)).round(),
      ),
      fit: BoxFit.cover,
    );
  }
}
