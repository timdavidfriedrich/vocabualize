import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

import 'adapters/public_link_s3_client.dart';
import 'domain/config_source.dart';
import 'generated/protocol.dart';

const imageStorageId = "images";

const _garageProvider = "garage";
const _databaseProvider = "database";
const _garageServiceName = "Garage";

class const Composition() {
  CloudStorage imageStorage() {
    final images = const ConfigSource().read().images;
    return switch (images.provider) {
      _garageProvider => _garageStorage(images),
      _databaseProvider => DatabaseCloudStorage(imageStorageId),
      _ => throw StateError("Unknown images.provider \"${images.provider}\" in app_config.yaml"),
    };
  }

  CloudStorage _garageStorage(ImageStorageConfig images) {
    final accessKey = _password("garageAccessKey");
    final secretKey = _password("garageSecretKey");
    final publicEndpoints = CustomEndpointConfig(
      baseUri: Uri.parse(images.publicEndpoint),
      serviceName: _garageServiceName,
    );
    return S3CompatCloudStorage(
      storageId: imageStorageId,
      accessKey: accessKey,
      secretKey: secretKey,
      bucket: images.bucket,
      region: images.region,
      public: false,
      endpoints: publicEndpoints,
      uploadStrategy: MultipartPostUploadStrategy(),
      client: PublicLinkS3Client(
        accessKey: accessKey,
        secretKey: secretKey,
        bucket: images.bucket,
        region: images.region,
        endpoints: CustomEndpointConfig(
          baseUri: Uri.parse(images.endpoint),
          serviceName: _garageServiceName,
        ),
        linkClient: S3Client(
          accessKey: accessKey,
          secretKey: secretKey,
          bucket: images.bucket,
          region: images.region,
          endpoints: publicEndpoints,
        ),
      ),
    );
  }
}

String _password(String key) {
  final value = Serverpod.instance.getPassword(key);
  if (value == null) throw StateError("Missing \"$key\" in config/passwords.yaml");
  return value;
}
