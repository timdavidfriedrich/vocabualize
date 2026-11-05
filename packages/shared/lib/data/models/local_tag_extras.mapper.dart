// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_tag_extras.dart';

class LocalTagExtrasMapper extends ClassMapperBase<LocalTagExtras> {
  LocalTagExtrasMapper._();

  static LocalTagExtrasMapper? _instance;
  static LocalTagExtrasMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocalTagExtrasMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocalTagExtras';

  static String? _$emoji(LocalTagExtras v) => v.emoji;
  static const Field<LocalTagExtras, String> _f$emoji = Field('emoji', _$emoji);

  @override
  final MappableFields<LocalTagExtras> fields = const {#emoji: _f$emoji};

  static LocalTagExtras _instantiate(DecodingData data) {
    return LocalTagExtras(emoji: data.dec(_f$emoji));
  }

  @override
  final Function instantiate = _instantiate;

  static LocalTagExtras fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalTagExtras>(map);
  }

  static LocalTagExtras fromJson(String json) {
    return ensureInitialized().decodeJson<LocalTagExtras>(json);
  }
}

mixin LocalTagExtrasMappable {
  String toJson() {
    return LocalTagExtrasMapper.ensureInitialized().encodeJson<LocalTagExtras>(
      this as LocalTagExtras,
    );
  }

  Map<String, dynamic> toMap() {
    return LocalTagExtrasMapper.ensureInitialized().encodeMap<LocalTagExtras>(
      this as LocalTagExtras,
    );
  }

  LocalTagExtrasCopyWith<LocalTagExtras, LocalTagExtras, LocalTagExtras>
  get copyWith => _LocalTagExtrasCopyWithImpl<LocalTagExtras, LocalTagExtras>(
    this as LocalTagExtras,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocalTagExtrasMapper.ensureInitialized().stringifyValue(
      this as LocalTagExtras,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalTagExtrasMapper.ensureInitialized().equalsValue(
      this as LocalTagExtras,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalTagExtrasMapper.ensureInitialized().hashValue(
      this as LocalTagExtras,
    );
  }
}

extension LocalTagExtrasValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalTagExtras, $Out> {
  LocalTagExtrasCopyWith<$R, LocalTagExtras, $Out> get $asLocalTagExtras =>
      $base.as((v, t, t2) => _LocalTagExtrasCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocalTagExtrasCopyWith<$R, $In extends LocalTagExtras, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? emoji});
  LocalTagExtrasCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalTagExtrasCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalTagExtras, $Out>
    implements LocalTagExtrasCopyWith<$R, LocalTagExtras, $Out> {
  _LocalTagExtrasCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalTagExtras> $mapper =
      LocalTagExtrasMapper.ensureInitialized();
  @override
  $R call({Object? emoji = $none}) =>
      $apply(FieldCopyWithData({if (emoji != $none) #emoji: emoji}));
  @override
  LocalTagExtras $make(CopyWithData data) =>
      LocalTagExtras(emoji: data.get(#emoji, or: $value.emoji));

  @override
  LocalTagExtrasCopyWith<$R2, LocalTagExtras, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocalTagExtrasCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

