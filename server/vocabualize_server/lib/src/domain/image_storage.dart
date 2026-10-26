import 'package:serverpod/serverpod.dart';

import '../composition.dart';
import '../generated/protocol.dart';
import 'config_source.dart';

const imageVariantFull = "full";
const imageVariantThumbnail = "thumbnail";

const _variantSuffixes = {imageVariantFull: "", imageVariantThumbnail: "_thumbnail"};
const _imageExtension = ".webp";
const _userPrefix = "u";

class const ImageStorage() {
  Future<String?> createUpload(
    Session session,
    UuidValue authUserId,
    UuidValue imageId,
    String variant,
    int byteSize,
  ) async {
    if (!await _hasRoomFor(session, authUserId, imageId)) return null;
    return session.storage.createUploadDescription(
      storageId: imageStorageId,
      path: _key(authUserId, imageId, variant),
      options: UploadOptions(contentLength: byteSize),
    );
  }

  Future<bool> verifyUpload(
    Session session,
    UuidValue authUserId,
    UuidValue imageId,
    String variant,
  ) async {
    final key = _key(authUserId, imageId, variant);
    final isUploaded = await session.storage.verifyUpload(storageId: imageStorageId, path: key);
    if (!isUploaded) return false;
    final stat = await session.storage.statFile(storageId: imageStorageId, path: key);
    final existing = await StoredImage.db.findFirstRow(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) & t.imageId.equals(imageId) & t.variant.equals(variant),
    );
    final now = DateTime.now().toUtc();
    if (existing == null) {
      await StoredImage.db.insertRow(
        session,
        StoredImage(
          authUserId: authUserId,
          imageId: imageId,
          variant: variant,
          byteSize: stat.size,
          uploadedAt: now,
        ),
      );
    } else {
      await StoredImage.db.updateRow(
        session,
        existing.copyWith(byteSize: stat.size, uploadedAt: now),
      );
    }
    return true;
  }

  Future<List<UuidValue>> findMissing(
    Session session,
    UuidValue authUserId,
    List<UuidValue> imageIds,
    String variant,
  ) async {
    if (imageIds.isEmpty) return const [];
    final stored = await StoredImage.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.variant.equals(variant) &
          t.imageId.inSet(imageIds.toSet()),
    );
    final storedIds = stored.map((image) => image.imageId).toSet();
    return imageIds.where((id) => !storedIds.contains(id)).toList();
  }

  Future<List<RemoteImageDownload>> createDownloads(
    Session session,
    UuidValue authUserId,
    List<UuidValue> imageIds,
    String variant,
  ) async {
    if (imageIds.isEmpty) return const [];
    final stored = await StoredImage.db.find(
      session,
      where: (t) =>
          t.authUserId.equals(authUserId) &
          t.variant.equals(variant) &
          t.imageId.inSet(imageIds.toSet()),
    );
    return [
      for (final image in stored)
        RemoteImageDownload(
          imageId: image.imageId.uuid,
          variant: variant,
          url: (await session.storage.temporaryDownloadUrl(
            storageId: imageStorageId,
            path: _key(authUserId, image.imageId, variant),
          )).toString(),
        ),
    ];
  }

  bool isKnownVariant(String variant) => _variantSuffixes.containsKey(variant);

  Future<void> deleteFiles(Session session, List<StoredImage> images) async {
    for (final image in images) {
      final key = _key(image.authUserId, image.imageId, image.variant);
      try {
        await session.storage.deleteFile(storageId: imageStorageId, path: key);
      } on Object catch (error) {
        session.log("Deleting image $key failed: $error", level: LogLevel.warning);
      }
    }
  }

  Future<bool> _hasRoomFor(Session session, UuidValue authUserId, UuidValue imageId) async {
    final storedVariants = await StoredImage.db.count(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.imageId.equals(imageId),
    );
    if (storedVariants > 0) return true;
    final storedPhotos = await StoredImage.db.count(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.variant.equals(imageVariantFull),
    );
    return storedPhotos < const ConfigSource().read().imageStorage.maxPhotosPerAccount;
  }

  String _key(UuidValue authUserId, UuidValue imageId, String variant) =>
      "$_userPrefix/${authUserId.uuid}/${imageId.uuid}${_variantSuffixes[variant]}$_imageExtension";
}
