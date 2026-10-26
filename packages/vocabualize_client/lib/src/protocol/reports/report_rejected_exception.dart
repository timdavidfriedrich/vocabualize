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

abstract class ReportRejectedException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  ReportRejectedException._({required this.reason});

  factory ReportRejectedException({required String reason}) =
      _ReportRejectedExceptionImpl;

  factory ReportRejectedException.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ReportRejectedException(
      reason: jsonSerialization['reason'] as String,
    );
  }

  String reason;

  /// Returns a shallow copy of this [ReportRejectedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReportRejectedException copyWith({String? reason});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReportRejectedException',
      'reason': reason,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReportRejectedException',
      'reason': reason,
    };
  }

  @override
  String toString() {
    return 'ReportRejectedException(reason: $reason)';
  }
}

class _ReportRejectedExceptionImpl extends ReportRejectedException {
  _ReportRejectedExceptionImpl({required String reason})
    : super._(reason: reason);

  /// Returns a shallow copy of this [ReportRejectedException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReportRejectedException copyWith({String? reason}) {
    return ReportRejectedException(reason: reason ?? this.reason);
  }
}
