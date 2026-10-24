import 'package:serverpod/serverpod.dart';

import '../domain/image_storage.dart';
import '../generated/protocol.dart';

const _images = ImageStorage();

class ImageEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<String?> createUpload(
    Session session,
    String imageId,
    String variant,
    int byteSize,
  ) async {
    final (owner, image) = _parse(session, imageId);
    if (owner == null || image == null || !_images.isKnownVariant(variant) || byteSize <= 0) {
      return null;
    }
    return _images.createUpload(session, owner, image, variant, byteSize);
  }

  Future<bool> verifyUpload(Session session, String imageId, String variant) async {
    final (owner, image) = _parse(session, imageId);
    if (owner == null || image == null || !_images.isKnownVariant(variant)) return false;
    return _images.verifyUpload(session, owner, image, variant);
  }

  Future<List<String>> findMissing(Session session, List<String> imageIds, String variant) async {
    final owner = _owner(session);
    if (owner == null || !_images.isKnownVariant(variant)) return const [];
    final missing = await _images.findMissing(session, owner, _parseIds(imageIds), variant);
    return missing.map((id) => id.uuid).toList();
  }

  Future<List<RemoteImageDownload>> createDownloads(
    Session session,
    List<String> imageIds,
    String variant,
  ) async {
    final owner = _owner(session);
    if (owner == null || !_images.isKnownVariant(variant)) return const [];
    return _images.createDownloads(session, owner, _parseIds(imageIds), variant);
  }

  UuidValue? _owner(Session session) {
    final authenticated = session.authenticated;
    if (authenticated == null) return null;
    return _parseUuid(authenticated.userIdentifier);
  }

  (UuidValue?, UuidValue?) _parse(Session session, String imageId) =>
      (_owner(session), _parseUuid(imageId));

  List<UuidValue> _parseIds(List<String> imageIds) => [
    for (final imageId in imageIds) ?_parseUuid(imageId),
  ];

  UuidValue? _parseUuid(String value) {
    try {
      return UuidValue.withValidation(value);
    } on FormatException {
      return null;
    }
  }
}
