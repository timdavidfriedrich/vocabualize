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

abstract class ImageStorageConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  ImageStorageConfig._({
    required this.provider,
    required this.bucket,
    required this.region,
    required this.endpoint,
  });

  factory ImageStorageConfig({
    required String provider,
    required String bucket,
    required String region,
    required String endpoint,
  }) = _ImageStorageConfigImpl;

  factory ImageStorageConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImageStorageConfig(
      provider: jsonSerialization['provider'] as String,
      bucket: jsonSerialization['bucket'] as String,
      region: jsonSerialization['region'] as String,
      endpoint: jsonSerialization['endpoint'] as String,
    );
  }

  String provider;

  String bucket;

  String region;

  String endpoint;

  /// Returns a shallow copy of this [ImageStorageConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ImageStorageConfig copyWith({
    String? provider,
    String? bucket,
    String? region,
    String? endpoint,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImageStorageConfig',
      'provider': provider,
      'bucket': bucket,
      'region': region,
      'endpoint': endpoint,
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

class _ImageStorageConfigImpl extends ImageStorageConfig {
  _ImageStorageConfigImpl({
    required String provider,
    required String bucket,
    required String region,
    required String endpoint,
  }) : super._(
         provider: provider,
         bucket: bucket,
         region: region,
         endpoint: endpoint,
       );

  /// Returns a shallow copy of this [ImageStorageConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ImageStorageConfig copyWith({
    String? provider,
    String? bucket,
    String? region,
    String? endpoint,
  }) {
    return ImageStorageConfig(
      provider: provider ?? this.provider,
      bucket: bucket ?? this.bucket,
      region: region ?? this.region,
      endpoint: endpoint ?? this.endpoint,
    );
  }
}
