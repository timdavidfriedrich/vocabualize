// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vocabulary_filter.dart';

class VocabularyFilterMapper extends ClassMapperBase<VocabularyFilter> {
  VocabularyFilterMapper._();

  static VocabularyFilterMapper? _instance;
  static VocabularyFilterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VocabularyFilterMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VocabularyFilter';

  static String _$query(VocabularyFilter v) => v.query;
  static const Field<VocabularyFilter, String> _f$query = Field(
    'query',
    _$query,
  );
  static Set<VocabularyLevel> _$levels(VocabularyFilter v) => v.levels;
  static const Field<VocabularyFilter, Set<VocabularyLevel>> _f$levels = Field(
    'levels',
    _$levels,
  );
  static bool _$isDueOnly(VocabularyFilter v) => v.isDueOnly;
  static const Field<VocabularyFilter, bool> _f$isDueOnly = Field(
    'isDueOnly',
    _$isDueOnly,
  );

  @override
  final MappableFields<VocabularyFilter> fields = const {
    #query: _f$query,
    #levels: _f$levels,
    #isDueOnly: _f$isDueOnly,
  };

  static VocabularyFilter _instantiate(DecodingData data) {
    return VocabularyFilter(
      query: data.dec(_f$query),
      levels: data.dec(_f$levels),
      isDueOnly: data.dec(_f$isDueOnly),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VocabularyFilter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VocabularyFilter>(map);
  }

  static VocabularyFilter fromJson(String json) {
    return ensureInitialized().decodeJson<VocabularyFilter>(json);
  }
}

mixin VocabularyFilterMappable {
  String toJson() {
    return VocabularyFilterMapper.ensureInitialized()
        .encodeJson<VocabularyFilter>(this as VocabularyFilter);
  }

  Map<String, dynamic> toMap() {
    return VocabularyFilterMapper.ensureInitialized()
        .encodeMap<VocabularyFilter>(this as VocabularyFilter);
  }

  VocabularyFilterCopyWith<VocabularyFilter, VocabularyFilter, VocabularyFilter>
  get copyWith =>
      _VocabularyFilterCopyWithImpl<VocabularyFilter, VocabularyFilter>(
        this as VocabularyFilter,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VocabularyFilterMapper.ensureInitialized().stringifyValue(
      this as VocabularyFilter,
    );
  }

  @override
  bool operator ==(Object other) {
    return VocabularyFilterMapper.ensureInitialized().equalsValue(
      this as VocabularyFilter,
      other,
    );
  }

  @override
  int get hashCode {
    return VocabularyFilterMapper.ensureInitialized().hashValue(
      this as VocabularyFilter,
    );
  }
}

extension VocabularyFilterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VocabularyFilter, $Out> {
  VocabularyFilterCopyWith<$R, VocabularyFilter, $Out>
  get $asVocabularyFilter =>
      $base.as((v, t, t2) => _VocabularyFilterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class VocabularyFilterCopyWith<$R, $In extends VocabularyFilter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? query, Set<VocabularyLevel>? levels, bool? isDueOnly});
  VocabularyFilterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VocabularyFilterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VocabularyFilter, $Out>
    implements VocabularyFilterCopyWith<$R, VocabularyFilter, $Out> {
  _VocabularyFilterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VocabularyFilter> $mapper =
      VocabularyFilterMapper.ensureInitialized();
  @override
  $R call({String? query, Set<VocabularyLevel>? levels, bool? isDueOnly}) =>
      $apply(
        FieldCopyWithData({
          if (query != null) #query: query,
          if (levels != null) #levels: levels,
          if (isDueOnly != null) #isDueOnly: isDueOnly,
        }),
      );
  @override
  VocabularyFilter $make(CopyWithData data) => VocabularyFilter(
    query: data.get(#query, or: $value.query),
    levels: data.get(#levels, or: $value.levels),
    isDueOnly: data.get(#isDueOnly, or: $value.isDueOnly),
  );

  @override
  VocabularyFilterCopyWith<$R2, VocabularyFilter, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VocabularyFilterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

