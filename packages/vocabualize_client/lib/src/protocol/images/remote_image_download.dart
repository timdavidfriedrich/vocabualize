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

abstract class RemoteImageDownload
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RemoteImageDownload._({
    required this.imageId,
    required this.variant,
    required this.url,
  });

  factory RemoteImageDownload({
    required String imageId,
    required String variant,
    required String url,
  }) = _RemoteImageDownloadImpl;

  factory RemoteImageDownload.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteImageDownload(
      imageId: jsonSerialization['imageId'] as String,
      variant: jsonSerialization['variant'] as String,
      url: jsonSerialization['url'] as String,
    );
  }

  String imageId;

  String variant;

  String url;

  /// Returns a shallow copy of this [RemoteImageDownload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RemoteImageDownload copyWith({
    String? imageId,
    String? variant,
    String? url,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteImageDownload',
      'imageId': imageId,
      'variant': variant,
      'url': url,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteImageDownload',
      'imageId': imageId,
      'variant': variant,
      'url': url,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RemoteImageDownloadImpl extends RemoteImageDownload {
  _RemoteImageDownloadImpl({
    required String imageId,
    required String variant,
    required String url,
  }) : super._(
         imageId: imageId,
         variant: variant,
         url: url,
       );

  /// Returns a shallow copy of this [RemoteImageDownload]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RemoteImageDownload copyWith({
    String? imageId,
    String? variant,
    String? url,
  }) {
    return RemoteImageDownload(
      imageId: imageId ?? this.imageId,
      variant: variant ?? this.variant,
      url: url ?? this.url,
    );
  }
}
