import 'dart:async';

import 'package:flutter/widgets.dart';

extension ImageProviderExtensions on ImageProvider {
  Future<Size> resolveSize() {
    final completer = Completer<Size>();
    final stream = resolve(ImageConfiguration.empty);
    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        completer.complete(Size(info.image.width.toDouble(), info.image.height.toDouble()));
        stream.removeListener(listener);
      },
      onError: (error, stackTrace) {
        completer.completeError(error, stackTrace);
        stream.removeListener(listener);
      },
    );
    stream.addListener(listener);
    return completer.future;
  }
}
