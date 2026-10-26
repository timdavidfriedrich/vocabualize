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

abstract class RemoteInstallKey
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RemoteInstallKey._({
    required this.installId,
    required this.secret,
  });

  factory RemoteInstallKey({
    required String installId,
    required String secret,
  }) = _RemoteInstallKeyImpl;

  factory RemoteInstallKey.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteInstallKey(
      installId: jsonSerialization['installId'] as String,
      secret: jsonSerialization['secret'] as String,
    );
  }

  String installId;

  String secret;

  /// Returns a shallow copy of this [RemoteInstallKey]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RemoteInstallKey copyWith({
    String? installId,
    String? secret,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteInstallKey',
      'installId': installId,
      'secret': secret,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteInstallKey',
      'installId': installId,
      'secret': secret,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RemoteInstallKeyImpl extends RemoteInstallKey {
  _RemoteInstallKeyImpl({
    required String installId,
    required String secret,
  }) : super._(
         installId: installId,
         secret: secret,
       );

  /// Returns a shallow copy of this [RemoteInstallKey]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RemoteInstallKey copyWith({
    String? installId,
    String? secret,
  }) {
    return RemoteInstallKey(
      installId: installId ?? this.installId,
      secret: secret ?? this.secret,
    );
  }
}
