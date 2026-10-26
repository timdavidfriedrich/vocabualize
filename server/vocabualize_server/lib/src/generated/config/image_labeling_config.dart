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

abstract class ImageLabelingConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  ImageLabelingConfig._({
    required this.enabled,
    required this.provider,
    required this.model,
    required this.maxImageBytes,
    required this.perDay,
  });

  factory ImageLabelingConfig({
    required bool enabled,
    required String provider,
    required String model,
    required int maxImageBytes,
    required int perDay,
  }) = _ImageLabelingConfigImpl;

  factory ImageLabelingConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ImageLabelingConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      provider: jsonSerialization['provider'] as String,
      model: jsonSerialization['model'] as String,
      maxImageBytes: jsonSerialization['maxImageBytes'] as int,
      perDay: jsonSerialization['perDay'] as int,
    );
  }

  bool enabled;

  String provider;

  String model;

  int maxImageBytes;

  int perDay;

  /// Returns a shallow copy of this [ImageLabelingConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ImageLabelingConfig copyWith({
    bool? enabled,
    String? provider,
    String? model,
    int? maxImageBytes,
    int? perDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ImageLabelingConfig',
      'enabled': enabled,
      'provider': provider,
      'model': model,
      'maxImageBytes': maxImageBytes,
      'perDay': perDay,
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

class _ImageLabelingConfigImpl extends ImageLabelingConfig {
  _ImageLabelingConfigImpl({
    required bool enabled,
    required String provider,
    required String model,
    required int maxImageBytes,
    required int perDay,
  }) : super._(
         enabled: enabled,
         provider: provider,
         model: model,
         maxImageBytes: maxImageBytes,
         perDay: perDay,
       );

  /// Returns a shallow copy of this [ImageLabelingConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ImageLabelingConfig copyWith({
    bool? enabled,
    String? provider,
    String? model,
    int? maxImageBytes,
    int? perDay,
  }) {
    return ImageLabelingConfig(
      enabled: enabled ?? this.enabled,
      provider: provider ?? this.provider,
      model: model ?? this.model,
      maxImageBytes: maxImageBytes ?? this.maxImageBytes,
      perDay: perDay ?? this.perDay,
    );
  }
}
