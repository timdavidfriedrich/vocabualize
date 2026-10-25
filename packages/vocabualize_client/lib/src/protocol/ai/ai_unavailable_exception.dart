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

abstract class AiUnavailableException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  AiUnavailableException._({required this.reason});

  factory AiUnavailableException({required String reason}) =
      _AiUnavailableExceptionImpl;

  factory AiUnavailableException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return AiUnavailableException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [AiUnavailableException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AiUnavailableException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiUnavailableException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiUnavailableException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'AiUnavailableException(reason: $reason)';
  }
}

class _AiUnavailableExceptionImpl extends AiUnavailableException {
  _AiUnavailableExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [AiUnavailableException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AiUnavailableException copyWith({String? reason}) {
    return AiUnavailableException(reason: reason ?? this.reason);
  }
}
