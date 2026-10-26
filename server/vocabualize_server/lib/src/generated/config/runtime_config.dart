/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;
import 'package:vocabualize_server/src/generated/protocol.dart' as _i935iz7n;
import '../config/image_labeling_config.dart' as _iio7eier;
import '../config/image_storage_config.dart' as _iillbwio;
import '../config/installs_config.dart' as _ilrwrlkh;
import '../config/remote_app_config.dart' as _ig8hny3m;
import '../config/reports_config.dart' as _icpywvfb;
import '../config/stock_images_config.dart' as _i1k1w2wj;
import '../config/tiers_config.dart' as _iajahbyi;
import '../config/translation_config.dart' as _ifwelo8b;

abstract class RuntimeConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  RuntimeConfig._({
    required this.version,
    required this.client,
    required this.tiers,
    required this.translation,
    required this.stockImages,
    required this.imageLabeling,
    required this.installs,
    required this.imageStorage,
    required this.reports,
  });

  factory RuntimeConfig({
    required int version,
    required _ig8hny3m.RemoteAppConfig client,
    required _iajahbyi.TiersConfig tiers,
    required _ifwelo8b.TranslationConfig translation,
    required _i1k1w2wj.StockImagesConfig stockImages,
    required _iio7eier.ImageLabelingConfig imageLabeling,
    required _ilrwrlkh.InstallsConfig installs,
    required _iillbwio.ImageStorageConfig imageStorage,
    required _icpywvfb.ReportsConfig reports,
  }) = _RuntimeConfigImpl;

  factory RuntimeConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return RuntimeConfig(
      version: jsonSerialization['version'] as int,
      client: _i935iz7n.Protocol().deserialize<_ig8hny3m.RemoteAppConfig>(
        jsonSerialization['client'],
      ),
      tiers: _i935iz7n.Protocol().deserialize<_iajahbyi.TiersConfig>(jsonSerialization['tiers']),
      translation: _i935iz7n.Protocol().deserialize<_ifwelo8b.TranslationConfig>(
        jsonSerialization['translation'],
      ),
      stockImages: _i935iz7n.Protocol().deserialize<_i1k1w2wj.StockImagesConfig>(
        jsonSerialization['stockImages'],
      ),
      imageLabeling: _i935iz7n.Protocol().deserialize<_iio7eier.ImageLabelingConfig>(
        jsonSerialization['imageLabeling'],
      ),
      installs: _i935iz7n.Protocol().deserialize<_ilrwrlkh.InstallsConfig>(
        jsonSerialization['installs'],
      ),
      imageStorage: _i935iz7n.Protocol().deserialize<_iillbwio.ImageStorageConfig>(
        jsonSerialization['imageStorage'],
      ),
      reports: _i935iz7n.Protocol().deserialize<_icpywvfb.ReportsConfig>(
        jsonSerialization['reports'],
      ),
    );
  }

  int version;

  _ig8hny3m.RemoteAppConfig client;

  _iajahbyi.TiersConfig tiers;

  _ifwelo8b.TranslationConfig translation;

  _i1k1w2wj.StockImagesConfig stockImages;

  _iio7eier.ImageLabelingConfig imageLabeling;

  _ilrwrlkh.InstallsConfig installs;

  _iillbwio.ImageStorageConfig imageStorage;

  _icpywvfb.ReportsConfig reports;

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RuntimeConfig copyWith({
    int? version,
    _ig8hny3m.RemoteAppConfig? client,
    _iajahbyi.TiersConfig? tiers,
    _ifwelo8b.TranslationConfig? translation,
    _i1k1w2wj.StockImagesConfig? stockImages,
    _iio7eier.ImageLabelingConfig? imageLabeling,
    _ilrwrlkh.InstallsConfig? installs,
    _iillbwio.ImageStorageConfig? imageStorage,
    _icpywvfb.ReportsConfig? reports,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RuntimeConfig',
      'version': version,
      'client': client.toJson(),
      'tiers': tiers.toJson(),
      'translation': translation.toJson(),
      'stockImages': stockImages.toJson(),
      'imageLabeling': imageLabeling.toJson(),
      'installs': installs.toJson(),
      'imageStorage': imageStorage.toJson(),
      'reports': reports.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _RuntimeConfigImpl extends RuntimeConfig {
  _RuntimeConfigImpl({
    required int version,
    required _ig8hny3m.RemoteAppConfig client,
    required _iajahbyi.TiersConfig tiers,
    required _ifwelo8b.TranslationConfig translation,
    required _i1k1w2wj.StockImagesConfig stockImages,
    required _iio7eier.ImageLabelingConfig imageLabeling,
    required _ilrwrlkh.InstallsConfig installs,
    required _iillbwio.ImageStorageConfig imageStorage,
    required _icpywvfb.ReportsConfig reports,
  }) : super._(
         version: version,
         client: client,
         tiers: tiers,
         translation: translation,
         stockImages: stockImages,
         imageLabeling: imageLabeling,
         installs: installs,
         imageStorage: imageStorage,
         reports: reports,
       );

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RuntimeConfig copyWith({
    int? version,
    _ig8hny3m.RemoteAppConfig? client,
    _iajahbyi.TiersConfig? tiers,
    _ifwelo8b.TranslationConfig? translation,
    _i1k1w2wj.StockImagesConfig? stockImages,
    _iio7eier.ImageLabelingConfig? imageLabeling,
    _ilrwrlkh.InstallsConfig? installs,
    _iillbwio.ImageStorageConfig? imageStorage,
    _icpywvfb.ReportsConfig? reports,
  }) {
    return RuntimeConfig(
      version: version ?? this.version,
      client: client ?? this.client.copyWith(),
      tiers: tiers ?? this.tiers.copyWith(),
      translation: translation ?? this.translation.copyWith(),
      stockImages: stockImages ?? this.stockImages.copyWith(),
      imageLabeling: imageLabeling ?? this.imageLabeling.copyWith(),
      installs: installs ?? this.installs.copyWith(),
      imageStorage: imageStorage ?? this.imageStorage.copyWith(),
      reports: reports ?? this.reports.copyWith(),
    );
  }
}
