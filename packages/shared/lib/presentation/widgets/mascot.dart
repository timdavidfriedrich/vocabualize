import 'package:flutter/widgets.dart';

const _package = "shared";

enum MascotPose { idle, waving, hanging, offline, practise, save, search }

class const Mascot({
  super.key,
  required final MascotPose _pose,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final image = AssetImage(_assetPath, package: _package);
        final width = constraints.hasBoundedWidth
            ? (constraints.maxWidth * pixelRatio).round()
            : null;
        final height = constraints.hasBoundedHeight
            ? (constraints.maxHeight * pixelRatio).round()
            : null;
        return Image(
          image: width == null && height == null
              ? image
              : ResizeImage(image, width: width, height: height, policy: ResizeImagePolicy.fit),
          fit: BoxFit.contain,
        );
      },
    );
  }

  String get _assetPath => switch (_pose) {
    MascotPose.idle => "assets/mascot/mascot_idle.webp",
    MascotPose.waving => "assets/mascot/mascot_waving.webp",
    MascotPose.hanging => "assets/mascot/mascot_hanging.webp",
    MascotPose.offline => "assets/mascot/mascot_offline.webp",
    MascotPose.practise => "assets/mascot/mascot_practise.webp",
    MascotPose.save => "assets/mascot/mascot_save.webp",
    MascotPose.search => "assets/mascot/mascot_search.webp",
  };
}
