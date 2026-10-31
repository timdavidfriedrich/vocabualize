// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_words_change.dart';

class LanguageWordsChangeMapper extends ClassMapperBase<LanguageWordsChange> {
  LanguageWordsChangeMapper._();

  static LanguageWordsChangeMapper? _instance;
  static LanguageWordsChangeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsChangeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsChange';

  static bool _$addsAll(LanguageWordsChange v) => v.addsAll;
  static const Field<LanguageWordsChange, bool> _f$addsAll = Field(
    'addsAll',
    _$addsAll,
  );
  static Set<String> _$addedTagIds(LanguageWordsChange v) => v.addedTagIds;
  static const Field<LanguageWordsChange, Set<String>> _f$addedTagIds = Field(
    'addedTagIds',
    _$addedTagIds,
  );
  static Set<String> _$removedTagIds(LanguageWordsChange v) => v.removedTagIds;
  static const Field<LanguageWordsChange, Set<String>> _f$removedTagIds = Field(
    'removedTagIds',
    _$removedTagIds,
  );
  static bool _$addsUntagged(LanguageWordsChange v) => v.addsUntagged;
  static const Field<LanguageWordsChange, bool> _f$addsUntagged = Field(
    'addsUntagged',
    _$addsUntagged,
  );
  static bool _$removesUntagged(LanguageWordsChange v) => v.removesUntagged;
  static const Field<LanguageWordsChange, bool> _f$removesUntagged = Field(
    'removesUntagged',
    _$removesUntagged,
  );

  @override
  final MappableFields<LanguageWordsChange> fields = const {
    #addsAll: _f$addsAll,
    #addedTagIds: _f$addedTagIds,
    #removedTagIds: _f$removedTagIds,
    #addsUntagged: _f$addsUntagged,
    #removesUntagged: _f$removesUntagged,
  };

  static LanguageWordsChange _instantiate(DecodingData data) {
    return LanguageWordsChange(
      addsAll: data.dec(_f$addsAll),
      addedTagIds: data.dec(_f$addedTagIds),
      removedTagIds: data.dec(_f$removedTagIds),
      addsUntagged: data.dec(_f$addsUntagged),
      removesUntagged: data.dec(_f$removesUntagged),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsChange fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsChange>(map);
  }

  static LanguageWordsChange fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsChange>(json);
  }
}

mixin LanguageWordsChangeMappable {
  String toJson() {
    return LanguageWordsChangeMapper.ensureInitialized()
        .encodeJson<LanguageWordsChange>(this as LanguageWordsChange);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsChangeMapper.ensureInitialized()
        .encodeMap<LanguageWordsChange>(this as LanguageWordsChange);
  }

  LanguageWordsChangeCopyWith<
    LanguageWordsChange,
    LanguageWordsChange,
    LanguageWordsChange
  >
  get copyWith =>
      _LanguageWordsChangeCopyWithImpl<
        LanguageWordsChange,
        LanguageWordsChange
      >(this as LanguageWordsChange, $identity, $identity);
  @override
  String toString() {
    return LanguageWordsChangeMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsChange,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsChangeMapper.ensureInitialized().equalsValue(
      this as LanguageWordsChange,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsChangeMapper.ensureInitialized().hashValue(
      this as LanguageWordsChange,
    );
  }
}

extension LanguageWordsChangeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsChange, $Out> {
  LanguageWordsChangeCopyWith<$R, LanguageWordsChange, $Out>
  get $asLanguageWordsChange => $base.as(
    (v, t, t2) => _LanguageWordsChangeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsChangeCopyWith<
  $R,
  $In extends LanguageWordsChange,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    bool? addsAll,
    Set<String>? addedTagIds,
    Set<String>? removedTagIds,
    bool? addsUntagged,
    bool? removesUntagged,
  });
  LanguageWordsChangeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsChangeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsChange, $Out>
    implements LanguageWordsChangeCopyWith<$R, LanguageWordsChange, $Out> {
  _LanguageWordsChangeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsChange> $mapper =
      LanguageWordsChangeMapper.ensureInitialized();
  @override
  $R call({
    bool? addsAll,
    Set<String>? addedTagIds,
    Set<String>? removedTagIds,
    bool? addsUntagged,
    bool? removesUntagged,
  }) => $apply(
    FieldCopyWithData({
      if (addsAll != null) #addsAll: addsAll,
      if (addedTagIds != null) #addedTagIds: addedTagIds,
      if (removedTagIds != null) #removedTagIds: removedTagIds,
      if (addsUntagged != null) #addsUntagged: addsUntagged,
      if (removesUntagged != null) #removesUntagged: removesUntagged,
    }),
  );
  @override
  LanguageWordsChange $make(CopyWithData data) => LanguageWordsChange(
    addsAll: data.get(#addsAll, or: $value.addsAll),
    addedTagIds: data.get(#addedTagIds, or: $value.addedTagIds),
    removedTagIds: data.get(#removedTagIds, or: $value.removedTagIds),
    addsUntagged: data.get(#addsUntagged, or: $value.addsUntagged),
    removesUntagged: data.get(#removesUntagged, or: $value.removesUntagged),
  );

  @override
  LanguageWordsChangeCopyWith<$R2, LanguageWordsChange, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageWordsChangeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class LanguageWordsPreviewMapper extends ClassMapperBase<LanguageWordsPreview> {
  LanguageWordsPreviewMapper._();

  static LanguageWordsPreviewMapper? _instance;
  static LanguageWordsPreviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordsPreviewMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordsPreview';

  static int _$addedCount(LanguageWordsPreview v) => v.addedCount;
  static const Field<LanguageWordsPreview, int> _f$addedCount = Field(
    'addedCount',
    _$addedCount,
  );
  static int _$removedCount(LanguageWordsPreview v) => v.removedCount;
  static const Field<LanguageWordsPreview, int> _f$removedCount = Field(
    'removedCount',
    _$removedCount,
  );
  static int _$removedAlsoElsewhereCount(LanguageWordsPreview v) =>
      v.removedAlsoElsewhereCount;
  static const Field<LanguageWordsPreview, int> _f$removedAlsoElsewhereCount =
      Field('removedAlsoElsewhereCount', _$removedAlsoElsewhereCount);

  @override
  final MappableFields<LanguageWordsPreview> fields = const {
    #addedCount: _f$addedCount,
    #removedCount: _f$removedCount,
    #removedAlsoElsewhereCount: _f$removedAlsoElsewhereCount,
  };

  static LanguageWordsPreview _instantiate(DecodingData data) {
    return LanguageWordsPreview(
      addedCount: data.dec(_f$addedCount),
      removedCount: data.dec(_f$removedCount),
      removedAlsoElsewhereCount: data.dec(_f$removedAlsoElsewhereCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordsPreview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordsPreview>(map);
  }

  static LanguageWordsPreview fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordsPreview>(json);
  }
}

mixin LanguageWordsPreviewMappable {
  String toJson() {
    return LanguageWordsPreviewMapper.ensureInitialized()
        .encodeJson<LanguageWordsPreview>(this as LanguageWordsPreview);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordsPreviewMapper.ensureInitialized()
        .encodeMap<LanguageWordsPreview>(this as LanguageWordsPreview);
  }

  LanguageWordsPreviewCopyWith<
    LanguageWordsPreview,
    LanguageWordsPreview,
    LanguageWordsPreview
  >
  get copyWith =>
      _LanguageWordsPreviewCopyWithImpl<
        LanguageWordsPreview,
        LanguageWordsPreview
      >(this as LanguageWordsPreview, $identity, $identity);
  @override
  String toString() {
    return LanguageWordsPreviewMapper.ensureInitialized().stringifyValue(
      this as LanguageWordsPreview,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordsPreviewMapper.ensureInitialized().equalsValue(
      this as LanguageWordsPreview,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordsPreviewMapper.ensureInitialized().hashValue(
      this as LanguageWordsPreview,
    );
  }
}

extension LanguageWordsPreviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordsPreview, $Out> {
  LanguageWordsPreviewCopyWith<$R, LanguageWordsPreview, $Out>
  get $asLanguageWordsPreview => $base.as(
    (v, t, t2) => _LanguageWordsPreviewCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordsPreviewCopyWith<
  $R,
  $In extends LanguageWordsPreview,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? addedCount, int? removedCount, int? removedAlsoElsewhereCount});
  LanguageWordsPreviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordsPreviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordsPreview, $Out>
    implements LanguageWordsPreviewCopyWith<$R, LanguageWordsPreview, $Out> {
  _LanguageWordsPreviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordsPreview> $mapper =
      LanguageWordsPreviewMapper.ensureInitialized();
  @override
  $R call({
    int? addedCount,
    int? removedCount,
    int? removedAlsoElsewhereCount,
  }) => $apply(
    FieldCopyWithData({
      if (addedCount != null) #addedCount: addedCount,
      if (removedCount != null) #removedCount: removedCount,
      if (removedAlsoElsewhereCount != null)
        #removedAlsoElsewhereCount: removedAlsoElsewhereCount,
    }),
  );
  @override
  LanguageWordsPreview $make(CopyWithData data) => LanguageWordsPreview(
    addedCount: data.get(#addedCount, or: $value.addedCount),
    removedCount: data.get(#removedCount, or: $value.removedCount),
    removedAlsoElsewhereCount: data.get(
      #removedAlsoElsewhereCount,
      or: $value.removedAlsoElsewhereCount,
    ),
  );

  @override
  LanguageWordsPreviewCopyWith<$R2, LanguageWordsPreview, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LanguageWordsPreviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

