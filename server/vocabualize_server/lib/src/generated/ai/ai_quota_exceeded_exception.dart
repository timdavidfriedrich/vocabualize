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

abstract class AiQuotaExceededException
    implements _is.SerializableException, _is.SerializableModel, _is.ProtocolSerialization {
  AiQuotaExceededException._({
    required this.kind,
    required this.limit,
  });

  factory AiQuotaExceededException({
    required String kind,
    required int limit,
  }) = _AiQuotaExceededExceptionImpl;

  factory AiQuotaExceededException.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiQuotaExceededException(
      kind: jsonSerialization['kind'] as String,
      limit: jsonSerialization['limit'] as int,
    );
  }

  String kind;

  int limit;

  /// Returns a shallow copy of this [AiQuotaExceededException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiQuotaExceededException copyWith({
    String? kind,
    int? limit,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiQuotaExceededException',
      'kind': kind,
      'limit': limit,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AiQuotaExceededException',
      'kind': kind,
      'limit': limit,
    };
  }

  @override
  String toString() {
    return 'AiQuotaExceededException(kind: $kind, limit: $limit)';
  }
}

class _AiQuotaExceededExceptionImpl extends AiQuotaExceededException {
  _AiQuotaExceededExceptionImpl({
    required String kind,
    required int limit,
  }) : super._(
         kind: kind,
         limit: limit,
       );

  /// Returns a shallow copy of this [AiQuotaExceededException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiQuotaExceededException copyWith({
    String? kind,
    int? limit,
  }) {
    return AiQuotaExceededException(
      kind: kind ?? this.kind,
      limit: limit ?? this.limit,
    );
  }
}
