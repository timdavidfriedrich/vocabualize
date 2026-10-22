import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

import 'domain/config_source.dart';

const imageStorageId = "images";

const _garageProvider = "garage";
const _databaseProvider = "database";
const _garageServiceName = "Garage";

class const Composition() {
  CloudStorage imageStorage() {
    final images = const ConfigSource().read().images;
    return switch (images.provider) {
      _garageProvider => S3CompatCloudStorage(
        storageId: imageStorageId,
        accessKey: _password("garageAccessKey"),
        secretKey: _password("garageSecretKey"),
        bucket: images.bucket,
        region: images.region,
        public: false,
        endpoints: CustomEndpointConfig(
          baseUri: Uri.parse(images.endpoint),
          serviceName: _garageServiceName,
        ),
        uploadStrategy: MultipartPostUploadStrategy(),
      ),
      _databaseProvider => DatabaseCloudStorage(imageStorageId),
      _ => throw StateError("Unknown images.provider \"${images.provider}\" in app_config.yaml"),
    };
  }
}

String _password(String key) {
  final value = Serverpod.instance.getPassword(key);
  if (value == null) throw StateError("Missing \"$key\" in config/passwords.yaml");
  return value;
}
