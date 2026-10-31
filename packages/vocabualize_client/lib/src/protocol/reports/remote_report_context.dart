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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class RemoteReportContext
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RemoteReportContext._({
    required this.appVersion,
    required this.platform,
    required this.appLanguage,
    required this.languages,
  });

  factory RemoteReportContext({
    required String appVersion,
    required String platform,
    required String appLanguage,
    required String languages,
  }) = _RemoteReportContextImpl;

  factory RemoteReportContext.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteReportContext(
      appVersion: jsonSerialization['appVersion'] as String,
      platform: jsonSerialization['platform'] as String,
      appLanguage: jsonSerialization['appLanguage'] as String,
      languages: jsonSerialization['languages'] as String,
    );
  }

  String appVersion;

  String platform;

  String appLanguage;

  String languages;

  /// Returns a shallow copy of this [RemoteReportContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RemoteReportContext copyWith({
    String? appVersion,
    String? platform,
    String? appLanguage,
    String? languages,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteReportContext',
      'appVersion': appVersion,
      'platform': platform,
      'appLanguage': appLanguage,
      'languages': languages,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteReportContext',
      'appVersion': appVersion,
      'platform': platform,
      'appLanguage': appLanguage,
      'languages': languages,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RemoteReportContextImpl extends RemoteReportContext {
  _RemoteReportContextImpl({
    required String appVersion,
    required String platform,
    required String appLanguage,
    required String languages,
  }) : super._(
         appVersion: appVersion,
         platform: platform,
         appLanguage: appLanguage,
         languages: languages,
       );

  /// Returns a shallow copy of this [RemoteReportContext]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RemoteReportContext copyWith({
    String? appVersion,
    String? platform,
    String? appLanguage,
    String? languages,
  }) {
    return RemoteReportContext(
      appVersion: appVersion ?? this.appVersion,
      platform: platform ?? this.platform,
      appLanguage: appLanguage ?? this.appLanguage,
      languages: languages ?? this.languages,
    );
  }
}
