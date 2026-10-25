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

abstract class AiConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  AiConfig._({
    required this.enabled,
    required this.translationProvider,
    required this.stockImageProvider,
    required this.translationsPerDay,
    required this.stockSearchesPerDay,
    required this.maxTextLength,
    required this.englishTarget,
  });

  factory AiConfig({
    required bool enabled,
    required String translationProvider,
    required String stockImageProvider,
    required int translationsPerDay,
    required int stockSearchesPerDay,
    required int maxTextLength,
    required String englishTarget,
  }) = _AiConfigImpl;

  factory AiConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      translationProvider: jsonSerialization['translationProvider'] as String,
      stockImageProvider: jsonSerialization['stockImageProvider'] as String,
      translationsPerDay: jsonSerialization['translationsPerDay'] as int,
      stockSearchesPerDay: jsonSerialization['stockSearchesPerDay'] as int,
      maxTextLength: jsonSerialization['maxTextLength'] as int,
      englishTarget: jsonSerialization['englishTarget'] as String,
    );
  }

  bool enabled;

  String translationProvider;

  String stockImageProvider;

  int translationsPerDay;

  int stockSearchesPerDay;

  int maxTextLength;

  String englishTarget;

  /// Returns a shallow copy of this [AiConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiConfig copyWith({
    bool? enabled,
    String? translationProvider,
    String? stockImageProvider,
    int? translationsPerDay,
    int? stockSearchesPerDay,
    int? maxTextLength,
    String? englishTarget,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiConfig',
      'enabled': enabled,
      'translationProvider': translationProvider,
      'stockImageProvider': stockImageProvider,
      'translationsPerDay': translationsPerDay,
      'stockSearchesPerDay': stockSearchesPerDay,
      'maxTextLength': maxTextLength,
      'englishTarget': englishTarget,
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

class _AiConfigImpl extends AiConfig {
  _AiConfigImpl({
    required bool enabled,
    required String translationProvider,
    required String stockImageProvider,
    required int translationsPerDay,
    required int stockSearchesPerDay,
    required int maxTextLength,
    required String englishTarget,
  }) : super._(
         enabled: enabled,
         translationProvider: translationProvider,
         stockImageProvider: stockImageProvider,
         translationsPerDay: translationsPerDay,
         stockSearchesPerDay: stockSearchesPerDay,
         maxTextLength: maxTextLength,
         englishTarget: englishTarget,
       );

  /// Returns a shallow copy of this [AiConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiConfig copyWith({
    bool? enabled,
    String? translationProvider,
    String? stockImageProvider,
    int? translationsPerDay,
    int? stockSearchesPerDay,
    int? maxTextLength,
    String? englishTarget,
  }) {
    return AiConfig(
      enabled: enabled ?? this.enabled,
      translationProvider: translationProvider ?? this.translationProvider,
      stockImageProvider: stockImageProvider ?? this.stockImageProvider,
      translationsPerDay: translationsPerDay ?? this.translationsPerDay,
      stockSearchesPerDay: stockSearchesPerDay ?? this.stockSearchesPerDay,
      maxTextLength: maxTextLength ?? this.maxTextLength,
      englishTarget: englishTarget ?? this.englishTarget,
    );
  }
}
