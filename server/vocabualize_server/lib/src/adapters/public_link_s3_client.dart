import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

class PublicLinkS3Client({
  required super.accessKey,
  required super.secretKey,
  required super.bucket,
  required super.region,
  required super.endpoints,
  required final S3Client _linkClient,
}) extends S3Client {
  @override
  Uri buildPresignedUri({
    required String key,
    required String method,
    required Duration expiration,
    Map<String, String> queryParams = const {},
  }) {
    return _linkClient.buildPresignedUri(
      key: key,
      method: method,
      expiration: expiration,
      queryParams: queryParams,
    );
  }

  @override
  void close() {
    _linkClient.close();
    super.close();
  }
}
