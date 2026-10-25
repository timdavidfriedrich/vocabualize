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

abstract class RemoteStockImage
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RemoteStockImage._({
    required this.id,
    required this.url,
    required this.thumbUrl,
    this.photographer,
    this.photographerUrl,
  });

  factory RemoteStockImage({
    required String id,
    required String url,
    required String thumbUrl,
    String? photographer,
    String? photographerUrl,
  }) = _RemoteStockImageImpl;

  factory RemoteStockImage.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteStockImage(
      id: jsonSerialization['id'] as String,
      url: jsonSerialization['url'] as String,
      thumbUrl: jsonSerialization['thumbUrl'] as String,
      photographer: jsonSerialization['photographer'] as String?,
      photographerUrl: jsonSerialization['photographerUrl'] as String?,
    );
  }

  String id;

  String url;

  String thumbUrl;

  String? photographer;

  String? photographerUrl;

  /// Returns a shallow copy of this [RemoteStockImage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RemoteStockImage copyWith({
    String? id,
    String? url,
    String? thumbUrl,
    String? photographer,
    String? photographerUrl,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteStockImage',
      'id': id,
      'url': url,
      'thumbUrl': thumbUrl,
      if (photographer != null) 'photographer': photographer,
      if (photographerUrl != null) 'photographerUrl': photographerUrl,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteStockImage',
      'id': id,
      'url': url,
      'thumbUrl': thumbUrl,
      if (photographer != null) 'photographer': photographer,
      if (photographerUrl != null) 'photographerUrl': photographerUrl,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RemoteStockImageImpl extends RemoteStockImage {
  _RemoteStockImageImpl({
    required String id,
    required String url,
    required String thumbUrl,
    String? photographer,
    String? photographerUrl,
  }) : super._(
         id: id,
         url: url,
         thumbUrl: thumbUrl,
         photographer: photographer,
         photographerUrl: photographerUrl,
       );

  /// Returns a shallow copy of this [RemoteStockImage]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RemoteStockImage copyWith({
    String? id,
    String? url,
    String? thumbUrl,
    Object? photographer = _Undefined,
    Object? photographerUrl = _Undefined,
  }) {
    return RemoteStockImage(
      id: id ?? this.id,
      url: url ?? this.url,
      thumbUrl: thumbUrl ?? this.thumbUrl,
      photographer: photographer is String? ? photographer : this.photographer,
      photographerUrl: photographerUrl is String?
          ? photographerUrl
          : this.photographerUrl,
    );
  }
}
