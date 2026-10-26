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

abstract class InstallsConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  InstallsConfig._({
    required this.enabled,
    required this.perIpPerDay,
    required this.perDay,
  });

  factory InstallsConfig({
    required bool enabled,
    required int perIpPerDay,
    required int perDay,
  }) = _InstallsConfigImpl;

  factory InstallsConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return InstallsConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      perIpPerDay: jsonSerialization['perIpPerDay'] as int,
      perDay: jsonSerialization['perDay'] as int,
    );
  }

  bool enabled;

  int perIpPerDay;

  int perDay;

  /// Returns a shallow copy of this [InstallsConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InstallsConfig copyWith({
    bool? enabled,
    int? perIpPerDay,
    int? perDay,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstallsConfig',
      'enabled': enabled,
      'perIpPerDay': perIpPerDay,
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

class _InstallsConfigImpl extends InstallsConfig {
  _InstallsConfigImpl({
    required bool enabled,
    required int perIpPerDay,
    required int perDay,
  }) : super._(
         enabled: enabled,
         perIpPerDay: perIpPerDay,
         perDay: perDay,
       );

  /// Returns a shallow copy of this [InstallsConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InstallsConfig copyWith({
    bool? enabled,
    int? perIpPerDay,
    int? perDay,
  }) {
    return InstallsConfig(
      enabled: enabled ?? this.enabled,
      perIpPerDay: perIpPerDay ?? this.perIpPerDay,
      perDay: perDay ?? this.perDay,
    );
  }
}
