// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_language_pair_setting.dart';

class LocalLanguagePairSettingMapper
    extends ClassMapperBase<LocalLanguagePairSetting> {
  LocalLanguagePairSettingMapper._();

  static LocalLanguagePairSettingMapper? _instance;
  static LocalLanguagePairSettingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalLanguagePairSettingMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalLanguagePairSetting';

  static String _$source(LocalLanguagePairSetting v) => v.source;
  static const Field<LocalLanguagePairSetting, String> _f$source = Field(
    'source',
    _$source,
  );
  static String _$target(LocalLanguagePairSetting v) => v.target;
  static const Field<LocalLanguagePairSetting, String> _f$target = Field(
    'target',
    _$target,
  );

  @override
  final MappableFields<LocalLanguagePairSetting> fields = const {
    #source: _f$source,
    #target: _f$target,
  };

  static LocalLanguagePairSetting _instantiate(DecodingData data) {
    return LocalLanguagePairSetting(
      source: data.dec(_f$source),
      target: data.dec(_f$target),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalLanguagePairSetting fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalLanguagePairSetting>(map);
  }

  static LocalLanguagePairSetting fromJson(String json) {
    return ensureInitialized().decodeJson<LocalLanguagePairSetting>(json);
  }
}

mixin LocalLanguagePairSettingMappable {
  String toJson() {
    return LocalLanguagePairSettingMapper.ensureInitialized()
        .encodeJson<LocalLanguagePairSetting>(this as LocalLanguagePairSetting);
  }

  Map<String, dynamic> toMap() {
    return LocalLanguagePairSettingMapper.ensureInitialized()
        .encodeMap<LocalLanguagePairSetting>(this as LocalLanguagePairSetting);
  }

  LocalLanguagePairSettingCopyWith<
    LocalLanguagePairSetting,
    LocalLanguagePairSetting,
    LocalLanguagePairSetting
  >
  get copyWith =>
      _LocalLanguagePairSettingCopyWithImpl<
        LocalLanguagePairSetting,
        LocalLanguagePairSetting
      >(this as LocalLanguagePairSetting, $identity, $identity);
  @override
  String toString() {
    return LocalLanguagePairSettingMapper.ensureInitialized().stringifyValue(
      this as LocalLanguagePairSetting,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalLanguagePairSettingMapper.ensureInitialized().equalsValue(
      this as LocalLanguagePairSetting,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalLanguagePairSettingMapper.ensureInitialized().hashValue(
      this as LocalLanguagePairSetting,
    );
  }
}

extension LocalLanguagePairSettingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalLanguagePairSetting, $Out> {
  LocalLanguagePairSettingCopyWith<$R, LocalLanguagePairSetting, $Out>
  get $asLocalLanguagePairSetting => $base.as(
    (v, t, t2) => _LocalLanguagePairSettingCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalLanguagePairSettingCopyWith<
  $R,
  $In extends LocalLanguagePairSetting,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? source, String? target});
  LocalLanguagePairSettingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalLanguagePairSettingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalLanguagePairSetting, $Out>
    implements
        LocalLanguagePairSettingCopyWith<$R, LocalLanguagePairSetting, $Out> {
  _LocalLanguagePairSettingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalLanguagePairSetting> $mapper =
      LocalLanguagePairSettingMapper.ensureInitialized();
  @override
  $R call({String? source, String? target}) => $apply(
    FieldCopyWithData({
      if (source != null) #source: source,
      if (target != null) #target: target,
    }),
  );
  @override
  LocalLanguagePairSetting $make(CopyWithData data) => LocalLanguagePairSetting(
    source: data.get(#source, or: $value.source),
    target: data.get(#target, or: $value.target),
  );

  @override
  LocalLanguagePairSettingCopyWith<$R2, LocalLanguagePairSetting, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalLanguagePairSettingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

