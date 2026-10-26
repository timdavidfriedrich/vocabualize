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

abstract class ReportsConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  ReportsConfig._({
    required this.enabled,
    required this.perIpPerHour,
    required this.perIpPerDay,
    required this.perDay,
    required this.maxMessageLength,
  });

  factory ReportsConfig({
    required bool enabled,
    required int perIpPerHour,
    required int perIpPerDay,
    required int perDay,
    required int maxMessageLength,
  }) = _ReportsConfigImpl;

  factory ReportsConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReportsConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      perIpPerHour: jsonSerialization['perIpPerHour'] as int,
      perIpPerDay: jsonSerialization['perIpPerDay'] as int,
      perDay: jsonSerialization['perDay'] as int,
      maxMessageLength: jsonSerialization['maxMessageLength'] as int,
    );
  }

  bool enabled;

  int perIpPerHour;

  int perIpPerDay;

  int perDay;

  int maxMessageLength;

  /// Returns a shallow copy of this [ReportsConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ReportsConfig copyWith({
    bool? enabled,
    int? perIpPerHour,
    int? perIpPerDay,
    int? perDay,
    int? maxMessageLength,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportsConfig',
      'enabled': enabled,
      'perIpPerHour': perIpPerHour,
      'perIpPerDay': perIpPerDay,
      'perDay': perDay,
      'maxMessageLength': maxMessageLength,
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

class _ReportsConfigImpl extends ReportsConfig {
  _ReportsConfigImpl({
    required bool enabled,
    required int perIpPerHour,
    required int perIpPerDay,
    required int perDay,
    required int maxMessageLength,
  }) : super._(
         enabled: enabled,
         perIpPerHour: perIpPerHour,
         perIpPerDay: perIpPerDay,
         perDay: perDay,
         maxMessageLength: maxMessageLength,
       );

  /// Returns a shallow copy of this [ReportsConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ReportsConfig copyWith({
    bool? enabled,
    int? perIpPerHour,
    int? perIpPerDay,
    int? perDay,
    int? maxMessageLength,
  }) {
    return ReportsConfig(
      enabled: enabled ?? this.enabled,
      perIpPerHour: perIpPerHour ?? this.perIpPerHour,
      perIpPerDay: perIpPerDay ?? this.perIpPerDay,
      perDay: perDay ?? this.perDay,
      maxMessageLength: maxMessageLength ?? this.maxMessageLength,
    );
  }
}
