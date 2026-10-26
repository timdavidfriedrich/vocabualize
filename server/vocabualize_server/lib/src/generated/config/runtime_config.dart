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
import '../config/ai_config.dart' as _i6mey862;
import '../config/image_storage_config.dart' as _iillbwio;
import '../config/remote_app_config.dart' as _ig8hny3m;
import '../config/reports_config.dart' as _icpywvfb;

abstract class RuntimeConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  RuntimeConfig._({
    required this.version,
    required this.client,
    required this.images,
    required this.ai,
    required this.reports,
  });

  factory RuntimeConfig({
    required int version,
    required _ig8hny3m.RemoteAppConfig client,
    required _iillbwio.ImageStorageConfig images,
    required _i6mey862.AiConfig ai,
    required _icpywvfb.ReportsConfig reports,
  }) = _RuntimeConfigImpl;

  factory RuntimeConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return RuntimeConfig(
      version: jsonSerialization['version'] as int,
      client: _i935iz7n.Protocol().deserialize<_ig8hny3m.RemoteAppConfig>(
        jsonSerialization['client'],
      ),
      images: _i935iz7n.Protocol().deserialize<_iillbwio.ImageStorageConfig>(
        jsonSerialization['images'],
      ),
      ai: _i935iz7n.Protocol().deserialize<_i6mey862.AiConfig>(jsonSerialization['ai']),
      reports: _i935iz7n.Protocol().deserialize<_icpywvfb.ReportsConfig>(
        jsonSerialization['reports'],
      ),
    );
  }

  int version;

  _ig8hny3m.RemoteAppConfig client;

  _iillbwio.ImageStorageConfig images;

  _i6mey862.AiConfig ai;

  _icpywvfb.ReportsConfig reports;

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  RuntimeConfig copyWith({
    int? version,
    _ig8hny3m.RemoteAppConfig? client,
    _iillbwio.ImageStorageConfig? images,
    _i6mey862.AiConfig? ai,
    _icpywvfb.ReportsConfig? reports,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RuntimeConfig',
      'version': version,
      'client': client.toJson(),
      'images': images.toJson(),
      'ai': ai.toJson(),
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
    required _iillbwio.ImageStorageConfig images,
    required _i6mey862.AiConfig ai,
    required _icpywvfb.ReportsConfig reports,
  }) : super._(
         version: version,
         client: client,
         images: images,
         ai: ai,
         reports: reports,
       );

  /// Returns a shallow copy of this [RuntimeConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  RuntimeConfig copyWith({
    int? version,
    _ig8hny3m.RemoteAppConfig? client,
    _iillbwio.ImageStorageConfig? images,
    _i6mey862.AiConfig? ai,
    _icpywvfb.ReportsConfig? reports,
  }) {
    return RuntimeConfig(
      version: version ?? this.version,
      client: client ?? this.client.copyWith(),
      images: images ?? this.images.copyWith(),
      ai: ai ?? this.ai.copyWith(),
      reports: reports ?? this.reports.copyWith(),
    );
  }
}
