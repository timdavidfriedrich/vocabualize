import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_cloud_storage_s3_compat/serverpod_cloud_storage_s3_compat.dart';

import 'adapters/image_labeling/echo_image_labeling_provider.dart';
import 'adapters/image_labeling/gemini_image_labeling_provider.dart';
import 'adapters/image_labeling/image_labeling_provider.dart';
import 'adapters/public_link_s3_client.dart';
import 'adapters/stock_images/echo_stock_image_provider.dart';
import 'adapters/stock_images/pexels_stock_image_provider.dart';
import 'adapters/stock_images/stock_image_provider.dart';
import 'adapters/translation/deepl_translation_provider.dart';
import 'adapters/translation/echo_translation_provider.dart';
import 'adapters/translation/translation_provider.dart';
import 'domain/config_source.dart';
import 'generated/protocol.dart';

const imageStorageId = "images";

const _deeplProvider = "deepl";
const _pexelsProvider = "pexels";
const _geminiProvider = "gemini";
const _echoProvider = "echo";

final _httpClient = http.Client();

const _garageProvider = "garage";
const _databaseProvider = "database";
const _garageServiceName = "Garage";

class const Composition() {
  TranslationProvider translationProvider() {
    final translation = const ConfigSource().read().translation;
    return switch (translation.provider) {
      _deeplProvider => DeeplTranslationProvider(
        _httpClient,
        _password("deeplApiKey"),
        translation.englishTarget,
      ),
      _echoProvider => const EchoTranslationProvider(),
      final name => throw StateError("Unknown translation.provider \"$name\" in app_config.yaml"),
    };
  }

  StockImageProvider stockImageProvider() {
    final stockImages = const ConfigSource().read().stockImages;
    return switch (stockImages.provider) {
      _pexelsProvider => PexelsStockImageProvider(_httpClient, _password("pexelsApiKey")),
      _echoProvider => const EchoStockImageProvider(),
      final name => throw StateError("Unknown stockImages.provider \"$name\" in app_config.yaml"),
    };
  }

  ImageLabelingProvider imageLabelingProvider() {
    final imageLabeling = const ConfigSource().read().imageLabeling;
    return switch (imageLabeling.provider) {
      _geminiProvider => GeminiImageLabelingProvider(
        _httpClient,
        _password("geminiApiKey"),
        imageLabeling.model,
      ),
      _echoProvider => const EchoImageLabelingProvider(),
      final name => throw StateError(
        "Unknown imageLabeling.provider \"$name\" in app_config.yaml",
      ),
    };
  }

  CloudStorage imageStorage() {
    final images = const ConfigSource().read().imageStorage;
    return switch (images.provider) {
      _garageProvider => _garageStorage(images),
      _databaseProvider => DatabaseCloudStorage(imageStorageId),
      final name => throw StateError("Unknown imageStorage.provider \"$name\" in app_config.yaml"),
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
