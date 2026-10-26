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

abstract class StockImagesConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  StockImagesConfig._({
    required this.enabled,
    required this.provider,
    required this.maxQueryLength,
    required this.perDay,
  });

  factory StockImagesConfig({
    required bool enabled,
    required String provider,
    required int maxQueryLength,
    required int perDay,
  }) = _StockImagesConfigImpl;

  factory StockImagesConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return StockImagesConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      provider: jsonSerialization['provider'] as String,
      maxQueryLength: jsonSerialization['maxQueryLength'] as int,
      perDay: jsonSerialization['perDay'] as int,
    );
  }

  bool enabled;

  String provider;

  int maxQueryLength;

  int perDay;

  /// Returns a shallow copy of this [StockImagesConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StockImagesConfig copyWith({
    bool? enabled,
    String? provider,
    int? maxQueryLength,
    int? perDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StockImagesConfig',
      'enabled': enabled,
      'provider': provider,
      'maxQueryLength': maxQueryLength,
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

class _StockImagesConfigImpl extends StockImagesConfig {
  _StockImagesConfigImpl({
    required bool enabled,
    required String provider,
    required int maxQueryLength,
    required int perDay,
  }) : super._(
         enabled: enabled,
         provider: provider,
         maxQueryLength: maxQueryLength,
         perDay: perDay,
       );

  /// Returns a shallow copy of this [StockImagesConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StockImagesConfig copyWith({
    bool? enabled,
    String? provider,
    int? maxQueryLength,
    int? perDay,
  }) {
    return StockImagesConfig(
      enabled: enabled ?? this.enabled,
      provider: provider ?? this.provider,
      maxQueryLength: maxQueryLength ?? this.maxQueryLength,
      perDay: perDay ?? this.perDay,
    );
  }
}
