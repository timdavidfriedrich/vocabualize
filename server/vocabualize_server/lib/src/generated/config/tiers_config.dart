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
import '../config/tier_config.dart' as _iawbefo9;

abstract class TiersConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  TiersConfig._({
    required this.anonymous,
    required this.free,
    required this.premium,
  });

  factory TiersConfig({
    required _iawbefo9.TierConfig anonymous,
    required _iawbefo9.TierConfig free,
    required _iawbefo9.TierConfig premium,
  }) = _TiersConfigImpl;

  factory TiersConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return TiersConfig(
      anonymous: _i935iz7n.Protocol().deserialize<_iawbefo9.TierConfig>(
        jsonSerialization['anonymous'],
      ),
      free: _i935iz7n.Protocol().deserialize<_iawbefo9.TierConfig>(jsonSerialization['free']),
      premium: _i935iz7n.Protocol().deserialize<_iawbefo9.TierConfig>(jsonSerialization['premium']),
    );
  }

  _iawbefo9.TierConfig anonymous;

  _iawbefo9.TierConfig free;

  _iawbefo9.TierConfig premium;

  /// Returns a shallow copy of this [TiersConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TiersConfig copyWith({
    _iawbefo9.TierConfig? anonymous,
    _iawbefo9.TierConfig? free,
    _iawbefo9.TierConfig? premium,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TiersConfig',
      'anonymous': anonymous.toJson(),
      'free': free.toJson(),
      'premium': premium.toJson(),
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

class _TiersConfigImpl extends TiersConfig {
  _TiersConfigImpl({
    required _iawbefo9.TierConfig anonymous,
    required _iawbefo9.TierConfig free,
    required _iawbefo9.TierConfig premium,
  }) : super._(
         anonymous: anonymous,
         free: free,
         premium: premium,
       );

  /// Returns a shallow copy of this [TiersConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TiersConfig copyWith({
    _iawbefo9.TierConfig? anonymous,
    _iawbefo9.TierConfig? free,
    _iawbefo9.TierConfig? premium,
  }) {
    return TiersConfig(
      anonymous: anonymous ?? this.anonymous.copyWith(),
      free: free ?? this.free.copyWith(),
      premium: premium ?? this.premium.copyWith(),
    );
  }
}
