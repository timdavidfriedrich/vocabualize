// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_pair.dart';

class LanguagePairMapper extends ClassMapperBase<LanguagePair> {
  LanguagePairMapper._();

  static LanguagePairMapper? _instance;
  static LanguagePairMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguagePairMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguagePair';

  static Language _$source(LanguagePair v) => v.source;
  static const Field<LanguagePair, Language> _f$source = Field(
    'source',
    _$source,
  );
  static Language _$target(LanguagePair v) => v.target;
  static const Field<LanguagePair, Language> _f$target = Field(
    'target',
    _$target,
  );

  @override
  final MappableFields<LanguagePair> fields = const {
    #source: _f$source,
    #target: _f$target,
  };

  static LanguagePair _instantiate(DecodingData data) {
    return LanguagePair(
      source: data.dec(_f$source),
      target: data.dec(_f$target),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguagePair fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguagePair>(map);
  }

  static LanguagePair fromJson(String json) {
    return ensureInitialized().decodeJson<LanguagePair>(json);
  }
}

mixin LanguagePairMappable {
  String toJson() {
    return LanguagePairMapper.ensureInitialized().encodeJson<LanguagePair>(
      this as LanguagePair,
    );
  }

  Map<String, dynamic> toMap() {
    return LanguagePairMapper.ensureInitialized().encodeMap<LanguagePair>(
      this as LanguagePair,
    );
  }

  LanguagePairCopyWith<LanguagePair, LanguagePair, LanguagePair> get copyWith =>
      _LanguagePairCopyWithImpl<LanguagePair, LanguagePair>(
        this as LanguagePair,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguagePairMapper.ensureInitialized().stringifyValue(
      this as LanguagePair,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguagePairMapper.ensureInitialized().equalsValue(
      this as LanguagePair,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguagePairMapper.ensureInitialized().hashValue(
      this as LanguagePair,
    );
  }
}

extension LanguagePairValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguagePair, $Out> {
  LanguagePairCopyWith<$R, LanguagePair, $Out> get $asLanguagePair =>
      $base.as((v, t, t2) => _LanguagePairCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguagePairCopyWith<$R, $In extends LanguagePair, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Language? source, Language? target});
  LanguagePairCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LanguagePairCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguagePair, $Out>
    implements LanguagePairCopyWith<$R, LanguagePair, $Out> {
  _LanguagePairCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguagePair> $mapper =
      LanguagePairMapper.ensureInitialized();
  @override
  $R call({Language? source, Language? target}) => $apply(
    FieldCopyWithData({
      if (source != null) #source: source,
      if (target != null) #target: target,
    }),
  );
  @override
  LanguagePair $make(CopyWithData data) => LanguagePair(
    source: data.get(#source, or: $value.source),
    target: data.get(#target, or: $value.target),
  );

  @override
  LanguagePairCopyWith<$R2, LanguagePair, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguagePairCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

