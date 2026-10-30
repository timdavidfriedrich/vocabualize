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

abstract class RemoteImageLabel
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  RemoteImageLabel._({
    required this.term,
    required this.context,
  });

  factory RemoteImageLabel({
    required String term,
    required String context,
  }) = _RemoteImageLabelImpl;

  factory RemoteImageLabel.fromJson(Map<String, dynamic> jsonSerialization) {
    return RemoteImageLabel(
      term: jsonSerialization['term'] as String,
      context: jsonSerialization['context'] as String,
    );
  }

  String term;

  String context;

  /// Returns a shallow copy of this [RemoteImageLabel]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  RemoteImageLabel copyWith({
    String? term,
    String? context,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RemoteImageLabel',
      'term': term,
      'context': context,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'RemoteImageLabel',
      'term': term,
      'context': context,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _RemoteImageLabelImpl extends RemoteImageLabel {
  _RemoteImageLabelImpl({
    required String term,
    required String context,
  }) : super._(
         term: term,
         context: context,
       );

  /// Returns a shallow copy of this [RemoteImageLabel]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  RemoteImageLabel copyWith({
    String? term,
    String? context,
  }) {
    return RemoteImageLabel(
      term: term ?? this.term,
      context: context ?? this.context,
    );
  }
}
