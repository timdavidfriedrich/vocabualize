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

abstract class AiConfig implements _is.SerializableModel, _is.ProtocolSerialization {
  AiConfig._({
    required this.enabled,
    required this.translationProvider,
    required this.stockImageProvider,
    required this.imageLabelingProvider,
    required this.imageLabelingModel,
    required this.translationsPerDay,
    required this.stockSearchesPerDay,
    required this.imageLabelingsPerDay,
    required this.maxTextLength,
    required this.maxLabelingImageBytes,
    required this.englishTarget,
  });

  factory AiConfig({
    required bool enabled,
    required String translationProvider,
    required String stockImageProvider,
    required String imageLabelingProvider,
    required String imageLabelingModel,
    required int translationsPerDay,
    required int stockSearchesPerDay,
    required int imageLabelingsPerDay,
    required int maxTextLength,
    required int maxLabelingImageBytes,
    required String englishTarget,
  }) = _AiConfigImpl;

  factory AiConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return AiConfig(
      enabled: _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      translationProvider: jsonSerialization['translationProvider'] as String,
      stockImageProvider: jsonSerialization['stockImageProvider'] as String,
      imageLabelingProvider: jsonSerialization['imageLabelingProvider'] as String,
      imageLabelingModel: jsonSerialization['imageLabelingModel'] as String,
      translationsPerDay: jsonSerialization['translationsPerDay'] as int,
      stockSearchesPerDay: jsonSerialization['stockSearchesPerDay'] as int,
      imageLabelingsPerDay: jsonSerialization['imageLabelingsPerDay'] as int,
      maxTextLength: jsonSerialization['maxTextLength'] as int,
      maxLabelingImageBytes: jsonSerialization['maxLabelingImageBytes'] as int,
      englishTarget: jsonSerialization['englishTarget'] as String,
    );
  }

  bool enabled;

  String translationProvider;

  String stockImageProvider;

  String imageLabelingProvider;

  String imageLabelingModel;

  int translationsPerDay;

  int stockSearchesPerDay;

  int imageLabelingsPerDay;

  int maxTextLength;

  int maxLabelingImageBytes;

  String englishTarget;

  /// Returns a shallow copy of this [AiConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AiConfig copyWith({
    bool? enabled,
    String? translationProvider,
    String? stockImageProvider,
    String? imageLabelingProvider,
    String? imageLabelingModel,
    int? translationsPerDay,
    int? stockSearchesPerDay,
    int? imageLabelingsPerDay,
    int? maxTextLength,
    int? maxLabelingImageBytes,
    String? englishTarget,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AiConfig',
      'enabled': enabled,
      'translationProvider': translationProvider,
      'stockImageProvider': stockImageProvider,
      'imageLabelingProvider': imageLabelingProvider,
      'imageLabelingModel': imageLabelingModel,
      'translationsPerDay': translationsPerDay,
      'stockSearchesPerDay': stockSearchesPerDay,
      'imageLabelingsPerDay': imageLabelingsPerDay,
      'maxTextLength': maxTextLength,
      'maxLabelingImageBytes': maxLabelingImageBytes,
      'englishTarget': englishTarget,
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

class _AiConfigImpl extends AiConfig {
  _AiConfigImpl({
    required bool enabled,
    required String translationProvider,
    required String stockImageProvider,
    required String imageLabelingProvider,
    required String imageLabelingModel,
    required int translationsPerDay,
    required int stockSearchesPerDay,
    required int imageLabelingsPerDay,
    required int maxTextLength,
    required int maxLabelingImageBytes,
    required String englishTarget,
  }) : super._(
         enabled: enabled,
         translationProvider: translationProvider,
         stockImageProvider: stockImageProvider,
         imageLabelingProvider: imageLabelingProvider,
         imageLabelingModel: imageLabelingModel,
         translationsPerDay: translationsPerDay,
         stockSearchesPerDay: stockSearchesPerDay,
         imageLabelingsPerDay: imageLabelingsPerDay,
         maxTextLength: maxTextLength,
         maxLabelingImageBytes: maxLabelingImageBytes,
         englishTarget: englishTarget,
       );

  /// Returns a shallow copy of this [AiConfig]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AiConfig copyWith({
    bool? enabled,
    String? translationProvider,
    String? stockImageProvider,
    String? imageLabelingProvider,
    String? imageLabelingModel,
    int? translationsPerDay,
    int? stockSearchesPerDay,
    int? imageLabelingsPerDay,
    int? maxTextLength,
    int? maxLabelingImageBytes,
    String? englishTarget,
  }) {
    return AiConfig(
      enabled: enabled ?? this.enabled,
      translationProvider: translationProvider ?? this.translationProvider,
      stockImageProvider: stockImageProvider ?? this.stockImageProvider,
      imageLabelingProvider: imageLabelingProvider ?? this.imageLabelingProvider,
      imageLabelingModel: imageLabelingModel ?? this.imageLabelingModel,
      translationsPerDay: translationsPerDay ?? this.translationsPerDay,
      stockSearchesPerDay: stockSearchesPerDay ?? this.stockSearchesPerDay,
      imageLabelingsPerDay: imageLabelingsPerDay ?? this.imageLabelingsPerDay,
      maxTextLength: maxTextLength ?? this.maxTextLength,
      maxLabelingImageBytes: maxLabelingImageBytes ?? this.maxLabelingImageBytes,
      englishTarget: englishTarget ?? this.englishTarget,
    );
  }
}
