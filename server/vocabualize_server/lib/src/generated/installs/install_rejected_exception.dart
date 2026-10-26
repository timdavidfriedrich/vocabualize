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

abstract class InstallRejectedException
    implements _is.SerializableException, _is.SerializableModel, _is.ProtocolSerialization {
  InstallRejectedException._({required this.reason});

  factory InstallRejectedException({required String reason}) = _InstallRejectedExceptionImpl;

  factory InstallRejectedException.fromJson(Map<String, dynamic> jsonSerialization) {
    return InstallRejectedException(reason: jsonSerialization['reason'] as String);
  }

  String reason;

  /// Returns a shallow copy of this [InstallRejectedException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InstallRejectedException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstallRejectedException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'InstallRejectedException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'InstallRejectedException(reason: $reason)';
  }
}

class _InstallRejectedExceptionImpl extends InstallRejectedException {
  _InstallRejectedExceptionImpl({required String reason}) : super._(reason: reason);

  /// Returns a shallow copy of this [InstallRejectedException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InstallRejectedException copyWith({String? reason}) {
    return InstallRejectedException(reason: reason ?? this.reason);
  }
}
