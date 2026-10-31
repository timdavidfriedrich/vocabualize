// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_coverage.dart';

class LanguageCoverageMapper extends ClassMapperBase<LanguageCoverage> {
  LanguageCoverageMapper._();

  static LanguageCoverageMapper? _instance;
  static LanguageCoverageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageCoverageMapper._());
      CollectionCoverageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageCoverage';

  static int _$totalCount(LanguageCoverage v) => v.totalCount;
  static const Field<LanguageCoverage, int> _f$totalCount = Field(
    'totalCount',
    _$totalCount,
  );
  static int _$inLanguageCount(LanguageCoverage v) => v.inLanguageCount;
  static const Field<LanguageCoverage, int> _f$inLanguageCount = Field(
    'inLanguageCount',
    _$inLanguageCount,
  );
  static List<CollectionCoverage> _$collections(LanguageCoverage v) =>
      v.collections;
  static const Field<LanguageCoverage, List<CollectionCoverage>>
  _f$collections = Field('collections', _$collections);
  static int _$untaggedCount(LanguageCoverage v) => v.untaggedCount;
  static const Field<LanguageCoverage, int> _f$untaggedCount = Field(
    'untaggedCount',
    _$untaggedCount,
  );
  static int _$untaggedInLanguageCount(LanguageCoverage v) =>
      v.untaggedInLanguageCount;
  static const Field<LanguageCoverage, int> _f$untaggedInLanguageCount = Field(
    'untaggedInLanguageCount',
    _$untaggedInLanguageCount,
  );

  @override
  final MappableFields<LanguageCoverage> fields = const {
    #totalCount: _f$totalCount,
    #inLanguageCount: _f$inLanguageCount,
    #collections: _f$collections,
    #untaggedCount: _f$untaggedCount,
    #untaggedInLanguageCount: _f$untaggedInLanguageCount,
  };

  static LanguageCoverage _instantiate(DecodingData data) {
    return LanguageCoverage(
      totalCount: data.dec(_f$totalCount),
      inLanguageCount: data.dec(_f$inLanguageCount),
      collections: data.dec(_f$collections),
      untaggedCount: data.dec(_f$untaggedCount),
      untaggedInLanguageCount: data.dec(_f$untaggedInLanguageCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageCoverage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageCoverage>(map);
  }

  static LanguageCoverage fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageCoverage>(json);
  }
}

mixin LanguageCoverageMappable {
  String toJson() {
    return LanguageCoverageMapper.ensureInitialized()
        .encodeJson<LanguageCoverage>(this as LanguageCoverage);
  }

  Map<String, dynamic> toMap() {
    return LanguageCoverageMapper.ensureInitialized()
        .encodeMap<LanguageCoverage>(this as LanguageCoverage);
  }

  LanguageCoverageCopyWith<LanguageCoverage, LanguageCoverage, LanguageCoverage>
  get copyWith =>
      _LanguageCoverageCopyWithImpl<LanguageCoverage, LanguageCoverage>(
        this as LanguageCoverage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguageCoverageMapper.ensureInitialized().stringifyValue(
      this as LanguageCoverage,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageCoverageMapper.ensureInitialized().equalsValue(
      this as LanguageCoverage,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageCoverageMapper.ensureInitialized().hashValue(
      this as LanguageCoverage,
    );
  }
}

extension LanguageCoverageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageCoverage, $Out> {
  LanguageCoverageCopyWith<$R, LanguageCoverage, $Out>
  get $asLanguageCoverage =>
      $base.as((v, t, t2) => _LanguageCoverageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LanguageCoverageCopyWith<$R, $In extends LanguageCoverage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    CollectionCoverage,
    CollectionCoverageCopyWith<$R, CollectionCoverage, CollectionCoverage>
  >
  get collections;
  $R call({
    int? totalCount,
    int? inLanguageCount,
    List<CollectionCoverage>? collections,
    int? untaggedCount,
    int? untaggedInLanguageCount,
  });
  LanguageCoverageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageCoverageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageCoverage, $Out>
    implements LanguageCoverageCopyWith<$R, LanguageCoverage, $Out> {
  _LanguageCoverageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageCoverage> $mapper =
      LanguageCoverageMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    CollectionCoverage,
    CollectionCoverageCopyWith<$R, CollectionCoverage, CollectionCoverage>
  >
  get collections => ListCopyWith(
    $value.collections,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(collections: v),
  );
  @override
  $R call({
    int? totalCount,
    int? inLanguageCount,
    List<CollectionCoverage>? collections,
    int? untaggedCount,
    int? untaggedInLanguageCount,
  }) => $apply(
    FieldCopyWithData({
      if (totalCount != null) #totalCount: totalCount,
      if (inLanguageCount != null) #inLanguageCount: inLanguageCount,
      if (collections != null) #collections: collections,
      if (untaggedCount != null) #untaggedCount: untaggedCount,
      if (untaggedInLanguageCount != null)
        #untaggedInLanguageCount: untaggedInLanguageCount,
    }),
  );
  @override
  LanguageCoverage $make(CopyWithData data) => LanguageCoverage(
    totalCount: data.get(#totalCount, or: $value.totalCount),
    inLanguageCount: data.get(#inLanguageCount, or: $value.inLanguageCount),
    collections: data.get(#collections, or: $value.collections),
    untaggedCount: data.get(#untaggedCount, or: $value.untaggedCount),
    untaggedInLanguageCount: data.get(
      #untaggedInLanguageCount,
      or: $value.untaggedInLanguageCount,
    ),
  );

  @override
  LanguageCoverageCopyWith<$R2, LanguageCoverage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageCoverageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CollectionCoverageMapper extends ClassMapperBase<CollectionCoverage> {
  CollectionCoverageMapper._();

  static CollectionCoverageMapper? _instance;
  static CollectionCoverageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CollectionCoverageMapper._());
      TagMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CollectionCoverage';

  static Tag _$tag(CollectionCoverage v) => v.tag;
  static const Field<CollectionCoverage, Tag> _f$tag = Field('tag', _$tag);
  static int _$totalCount(CollectionCoverage v) => v.totalCount;
  static const Field<CollectionCoverage, int> _f$totalCount = Field(
    'totalCount',
    _$totalCount,
  );
  static int _$inLanguageCount(CollectionCoverage v) => v.inLanguageCount;
  static const Field<CollectionCoverage, int> _f$inLanguageCount = Field(
    'inLanguageCount',
    _$inLanguageCount,
  );

  @override
  final MappableFields<CollectionCoverage> fields = const {
    #tag: _f$tag,
    #totalCount: _f$totalCount,
    #inLanguageCount: _f$inLanguageCount,
  };

  static CollectionCoverage _instantiate(DecodingData data) {
    return CollectionCoverage(
      tag: data.dec(_f$tag),
      totalCount: data.dec(_f$totalCount),
      inLanguageCount: data.dec(_f$inLanguageCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CollectionCoverage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CollectionCoverage>(map);
  }

  static CollectionCoverage fromJson(String json) {
    return ensureInitialized().decodeJson<CollectionCoverage>(json);
  }
}

mixin CollectionCoverageMappable {
  String toJson() {
    return CollectionCoverageMapper.ensureInitialized()
        .encodeJson<CollectionCoverage>(this as CollectionCoverage);
  }

  Map<String, dynamic> toMap() {
    return CollectionCoverageMapper.ensureInitialized()
        .encodeMap<CollectionCoverage>(this as CollectionCoverage);
  }

  CollectionCoverageCopyWith<
    CollectionCoverage,
    CollectionCoverage,
    CollectionCoverage
  >
  get copyWith =>
      _CollectionCoverageCopyWithImpl<CollectionCoverage, CollectionCoverage>(
        this as CollectionCoverage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CollectionCoverageMapper.ensureInitialized().stringifyValue(
      this as CollectionCoverage,
    );
  }

  @override
  bool operator ==(Object other) {
    return CollectionCoverageMapper.ensureInitialized().equalsValue(
      this as CollectionCoverage,
      other,
    );
  }

  @override
  int get hashCode {
    return CollectionCoverageMapper.ensureInitialized().hashValue(
      this as CollectionCoverage,
    );
  }
}

extension CollectionCoverageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CollectionCoverage, $Out> {
  CollectionCoverageCopyWith<$R, CollectionCoverage, $Out>
  get $asCollectionCoverage => $base.as(
    (v, t, t2) => _CollectionCoverageCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class CollectionCoverageCopyWith<
  $R,
  $In extends CollectionCoverage,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  TagCopyWith<$R, Tag, Tag> get tag;
  $R call({Tag? tag, int? totalCount, int? inLanguageCount});
  CollectionCoverageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _CollectionCoverageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CollectionCoverage, $Out>
    implements CollectionCoverageCopyWith<$R, CollectionCoverage, $Out> {
  _CollectionCoverageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CollectionCoverage> $mapper =
      CollectionCoverageMapper.ensureInitialized();
  @override
  TagCopyWith<$R, Tag, Tag> get tag =>
      $value.tag.copyWith.$chain((v) => call(tag: v));
  @override
  $R call({Tag? tag, int? totalCount, int? inLanguageCount}) => $apply(
    FieldCopyWithData({
      if (tag != null) #tag: tag,
      if (totalCount != null) #totalCount: totalCount,
      if (inLanguageCount != null) #inLanguageCount: inLanguageCount,
    }),
  );
  @override
  CollectionCoverage $make(CopyWithData data) => CollectionCoverage(
    tag: data.get(#tag, or: $value.tag),
    totalCount: data.get(#totalCount, or: $value.totalCount),
    inLanguageCount: data.get(#inLanguageCount, or: $value.inLanguageCount),
  );

  @override
  CollectionCoverageCopyWith<$R2, CollectionCoverage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CollectionCoverageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

