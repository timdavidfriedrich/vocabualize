import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../composition.dart';
import '../domain/caller.dart';
import '../domain/image_labeling_service.dart';
import '../domain/languages.dart';
import '../generated/protocol.dart';

const _invalidRequest = "invalidRequest";

final _imageLabeling = ImageLabelingService(const Composition().imageLabelingProvider);

class ImageLabelingEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<List<RemoteImageLabel>> label(
    Session session,
    ByteData image,
    String language,
    RemoteInstallKey? installKey,
  ) async {
    if (image.lengthInBytes == 0 || !supportedLanguages.containsKey(language)) {
      throw ServiceUnavailableException(reason: _invalidRequest);
    }
    return _imageLabeling.label(
      session,
      await const CallerResolver().resolve(session, installKey),
      image: image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes),
      language: language,
    );
  }
}
