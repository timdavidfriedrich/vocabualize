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

abstract class RemoteAppConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  RemoteAppConfig._({
    required this.version,
    required this.minSupportedBuild,
    required this.maintenanceMode,
    this.maintenanceMessage,
  });

  factory RemoteAppConfig({
    required int version,
    required int minSupportedBuild,
    required bool maintenanceMode,
    String? maintenanceMessage,
  }) = _RemoteAppConfigImpl;

  factory RemoteAppConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteAppConfig(
      version: jsonSerialization['version'] as int,
      minSupportedBuild: jsonSerialization['minSupportedBuild'] as int,
      maintenanceMode: _is.BoolJsonExtension.fromJson(jsonSerialization['maintenanceMode']),
      maintenanceMessage: jsonSerialization['maintenanceMessage'] as String?,
    );
  }

  int version;

  int minSupportedBuild;

  bool maintenanceMode;

  String? maintenanceMessage;

  /// Returns a shallow copy of this [RemoteAppConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RemoteAppConfig copyWith({
    int? version,
    int? minSupportedBuild,
    bool? maintenanceMode,
    String? maintenanceMessage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteAppConfig',
      'version': version,
      'minSupportedBuild': minSupportedBuild,
      'maintenanceMode': maintenanceMode,
      if (maintenanceMessage != null) 'maintenanceMessage': maintenanceMessage,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteAppConfig',
      'version': version,
      'minSupportedBuild': minSupportedBuild,
      'maintenanceMode': maintenanceMode,
      if (maintenanceMessage != null) 'maintenanceMessage': maintenanceMessage,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RemoteAppConfigImpl extends RemoteAppConfig {
  _RemoteAppConfigImpl({
    required int version,
    required int minSupportedBuild,
    required bool maintenanceMode,
    String? maintenanceMessage,
  }) : super._(
         version: version,
         minSupportedBuild: minSupportedBuild,
         maintenanceMode: maintenanceMode,
         maintenanceMessage: maintenanceMessage,
       );

  /// Returns a shallow copy of this [RemoteAppConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RemoteAppConfig copyWith({
    int? version,
    int? minSupportedBuild,
    bool? maintenanceMode,
    Object? maintenanceMessage = _Undefined,
  }) {
    return RemoteAppConfig(
      version: version ?? this.version,
      minSupportedBuild: minSupportedBuild ?? this.minSupportedBuild,
      maintenanceMode: maintenanceMode ?? this.maintenanceMode,
      maintenanceMessage: maintenanceMessage is String?
          ? maintenanceMessage
          : this.maintenanceMessage,
    );
  }
}
