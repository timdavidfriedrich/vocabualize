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

abstract class TierConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  TierConfig._({
    required this.translationsPerDay,
    required this.stockImageSearchesPerDay,
    required this.imageLabelingsPerDay,
    required this.imageLabelingsPerMonth,
  });

  factory TierConfig({
    required int translationsPerDay,
    required int stockImageSearchesPerDay,
    required int imageLabelingsPerDay,
    required int imageLabelingsPerMonth,
  }) = _TierConfigImpl;

  factory TierConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return TierConfig(
      translationsPerDay: jsonSerialization['translationsPerDay'] as int,
      stockImageSearchesPerDay: jsonSerialization['stockImageSearchesPerDay'] as int,
      imageLabelingsPerDay: jsonSerialization['imageLabelingsPerDay'] as int,
      imageLabelingsPerMonth: jsonSerialization['imageLabelingsPerMonth'] as int,
    );
  }

  int translationsPerDay;

  int stockImageSearchesPerDay;

  int imageLabelingsPerDay;

  int imageLabelingsPerMonth;

  /// Returns a shallow copy of this [TierConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TierConfig copyWith({
    int? translationsPerDay,
    int? stockImageSearchesPerDay,
    int? imageLabelingsPerDay,
    int? imageLabelingsPerMonth,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TierConfig',
      'translationsPerDay': translationsPerDay,
      'stockImageSearchesPerDay': stockImageSearchesPerDay,
      'imageLabelingsPerDay': imageLabelingsPerDay,
      'imageLabelingsPerMonth': imageLabelingsPerMonth,
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

class _TierConfigImpl extends TierConfig {
  _TierConfigImpl({
    required int translationsPerDay,
    required int stockImageSearchesPerDay,
    required int imageLabelingsPerDay,
    required int imageLabelingsPerMonth,
  }) : super._(
         translationsPerDay: translationsPerDay,
         stockImageSearchesPerDay: stockImageSearchesPerDay,
         imageLabelingsPerDay: imageLabelingsPerDay,
         imageLabelingsPerMonth: imageLabelingsPerMonth,
       );

  /// Returns a shallow copy of this [TierConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TierConfig copyWith({
    int? translationsPerDay,
    int? stockImageSearchesPerDay,
    int? imageLabelingsPerDay,
    int? imageLabelingsPerMonth,
  }) {
    return TierConfig(
      translationsPerDay: translationsPerDay ?? this.translationsPerDay,
      stockImageSearchesPerDay: stockImageSearchesPerDay ?? this.stockImageSearchesPerDay,
      imageLabelingsPerDay: imageLabelingsPerDay ?? this.imageLabelingsPerDay,
      imageLabelingsPerMonth: imageLabelingsPerMonth ?? this.imageLabelingsPerMonth,
    );
  }
}
