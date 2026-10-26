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

abstract class QuotaExceededException
    implements _is.SerializableException, _is.SerializableModel, _is.ProtocolSerialization {
  QuotaExceededException._({
    required this.kind,
    required this.period,
    required this.limit,
    this.upgradeTier,
  });

  factory QuotaExceededException({
    required String kind,
    required String period,
    required int limit,
    String? upgradeTier,
  }) = _QuotaExceededExceptionImpl;

  factory QuotaExceededException.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuotaExceededException(
      kind: jsonSerialization['kind'] as String,
      period: jsonSerialization['period'] as String,
      limit: jsonSerialization['limit'] as int,
      upgradeTier: jsonSerialization['upgradeTier'] as String?,
    );
  }

  String kind;

  String period;

  int limit;

  String? upgradeTier;

  /// Returns a shallow copy of this [QuotaExceededException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuotaExceededException copyWith({
    String? kind,
    String? period,
    int? limit,
    String? upgradeTier,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuotaExceededException',
      'kind': kind,
      'period': period,
      'limit': limit,
      if (upgradeTier != null) 'upgradeTier': upgradeTier,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuotaExceededException',
      'kind': kind,
      'period': period,
      'limit': limit,
      if (upgradeTier != null) 'upgradeTier': upgradeTier,
    };
  }

  @override
  String toString() {
    return 'QuotaExceededException(kind: $kind, period: $period, limit: $limit, upgradeTier: $upgradeTier)';
  }
}

class _Undefined {}

class _QuotaExceededExceptionImpl extends QuotaExceededException {
  _QuotaExceededExceptionImpl({
    required String kind,
    required String period,
    required int limit,
    String? upgradeTier,
  }) : super._(
         kind: kind,
         period: period,
         limit: limit,
         upgradeTier: upgradeTier,
       );

  /// Returns a shallow copy of this [QuotaExceededException]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuotaExceededException copyWith({
    String? kind,
    String? period,
    int? limit,
    Object? upgradeTier = _Undefined,
  }) {
    return QuotaExceededException(
      kind: kind ?? this.kind,
      period: period ?? this.period,
      limit: limit ?? this.limit,
      upgradeTier: upgradeTier is String? ? upgradeTier : this.upgradeTier,
    );
  }
}
