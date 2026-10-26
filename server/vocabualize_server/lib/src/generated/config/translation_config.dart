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

abstract class TranslationConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  TranslationConfig._({
    required this.enabled,
    required this.provider,
    required this.maxTextLength,
    required this.englishTarget,
    required this.perDay,
  });

  factory TranslationConfig({
    required bool enabled,
    required String provider,
    required int maxTextLength,
    required String englishTarget,
    required int perDay,
  }) = _TranslationConfigImpl;

  factory TranslationConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return TranslationConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      provider: jsonSerialization['provider'] as String,
      maxTextLength: jsonSerialization['maxTextLength'] as int,
      englishTarget: jsonSerialization['englishTarget'] as String,
      perDay: jsonSerialization['perDay'] as int,
    );
  }

  bool enabled;

  String provider;

  int maxTextLength;

  String englishTarget;

  int perDay;

  /// Returns a shallow copy of this [TranslationConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TranslationConfig copyWith({
    bool? enabled,
    String? provider,
    int? maxTextLength,
    String? englishTarget,
    int? perDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TranslationConfig',
      'enabled': enabled,
      'provider': provider,
      'maxTextLength': maxTextLength,
      'englishTarget': englishTarget,
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

class _TranslationConfigImpl extends TranslationConfig {
  _TranslationConfigImpl({
    required bool enabled,
    required String provider,
    required int maxTextLength,
    required String englishTarget,
    required int perDay,
  }) : super._(
         enabled: enabled,
         provider: provider,
         maxTextLength: maxTextLength,
         englishTarget: englishTarget,
         perDay: perDay,
       );

  /// Returns a shallow copy of this [TranslationConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TranslationConfig copyWith({
    bool? enabled,
    String? provider,
    int? maxTextLength,
    String? englishTarget,
    int? perDay,
  }) {
    return TranslationConfig(
      enabled: enabled ?? this.enabled,
      provider: provider ?? this.provider,
      maxTextLength: maxTextLength ?? this.maxTextLength,
      englishTarget: englishTarget ?? this.englishTarget,
      perDay: perDay ?? this.perDay,
    );
  }
}
