// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'vocabulary_overview.dart';

class VocabularyOverviewMapper extends ClassMapperBase<VocabularyOverview> {
  VocabularyOverviewMapper._();

  static VocabularyOverviewMapper? _instance;
  static VocabularyOverviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = VocabularyOverviewMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'VocabularyOverview';

  static int _$totalCount(VocabularyOverview v) => v.totalCount;
  static const Field<VocabularyOverview, int> _f$totalCount = Field(
    'totalCount',
    _$totalCount,
  );
  static int _$dueCount(VocabularyOverview v) => v.dueCount;
  static const Field<VocabularyOverview, int> _f$dueCount = Field(
    'dueCount',
    _$dueCount,
  );
  static int _$addedTodayCount(VocabularyOverview v) => v.addedTodayCount;
  static const Field<VocabularyOverview, int> _f$addedTodayCount = Field(
    'addedTodayCount',
    _$addedTodayCount,
  );
  static DateTime? _$nextDueAt(VocabularyOverview v) => v.nextDueAt;
  static const Field<VocabularyOverview, DateTime> _f$nextDueAt = Field(
    'nextDueAt',
    _$nextDueAt,
  );
  static int _$noviceCount(VocabularyOverview v) => v.noviceCount;
  static const Field<VocabularyOverview, int> _f$noviceCount = Field(
    'noviceCount',
    _$noviceCount,
  );
  static int _$beginnerCount(VocabularyOverview v) => v.beginnerCount;
  static const Field<VocabularyOverview, int> _f$beginnerCount = Field(
    'beginnerCount',
    _$beginnerCount,
  );
  static int _$advancedCount(VocabularyOverview v) => v.advancedCount;
  static const Field<VocabularyOverview, int> _f$advancedCount = Field(
    'advancedCount',
    _$advancedCount,
  );
  static int _$expertCount(VocabularyOverview v) => v.expertCount;
  static const Field<VocabularyOverview, int> _f$expertCount = Field(
    'expertCount',
    _$expertCount,
  );

  @override
  final MappableFields<VocabularyOverview> fields = const {
    #totalCount: _f$totalCount,
    #dueCount: _f$dueCount,
    #addedTodayCount: _f$addedTodayCount,
    #nextDueAt: _f$nextDueAt,
    #noviceCount: _f$noviceCount,
    #beginnerCount: _f$beginnerCount,
    #advancedCount: _f$advancedCount,
    #expertCount: _f$expertCount,
  };

  static VocabularyOverview _instantiate(DecodingData data) {
    return VocabularyOverview(
      totalCount: data.dec(_f$totalCount),
      dueCount: data.dec(_f$dueCount),
      addedTodayCount: data.dec(_f$addedTodayCount),
      nextDueAt: data.dec(_f$nextDueAt),
      noviceCount: data.dec(_f$noviceCount),
      beginnerCount: data.dec(_f$beginnerCount),
      advancedCount: data.dec(_f$advancedCount),
      expertCount: data.dec(_f$expertCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static VocabularyOverview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<VocabularyOverview>(map);
  }

  static VocabularyOverview fromJson(String json) {
    return ensureInitialized().decodeJson<VocabularyOverview>(json);
  }
}

mixin VocabularyOverviewMappable {
  String toJson() {
    return VocabularyOverviewMapper.ensureInitialized()
        .encodeJson<VocabularyOverview>(this as VocabularyOverview);
  }

  Map<String, dynamic> toMap() {
    return VocabularyOverviewMapper.ensureInitialized()
        .encodeMap<VocabularyOverview>(this as VocabularyOverview);
  }

  VocabularyOverviewCopyWith<
    VocabularyOverview,
    VocabularyOverview,
    VocabularyOverview
  >
  get copyWith =>
      _VocabularyOverviewCopyWithImpl<VocabularyOverview, VocabularyOverview>(
        this as VocabularyOverview,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return VocabularyOverviewMapper.ensureInitialized().stringifyValue(
      this as VocabularyOverview,
    );
  }

  @override
  bool operator ==(Object other) {
    return VocabularyOverviewMapper.ensureInitialized().equalsValue(
      this as VocabularyOverview,
      other,
    );
  }

  @override
  int get hashCode {
    return VocabularyOverviewMapper.ensureInitialized().hashValue(
      this as VocabularyOverview,
    );
  }
}

extension VocabularyOverviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, VocabularyOverview, $Out> {
  VocabularyOverviewCopyWith<$R, VocabularyOverview, $Out>
  get $asVocabularyOverview => $base.as(
    (v, t, t2) => _VocabularyOverviewCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class VocabularyOverviewCopyWith<
  $R,
  $In extends VocabularyOverview,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? totalCount,
    int? dueCount,
    int? addedTodayCount,
    DateTime? nextDueAt,
    int? noviceCount,
    int? beginnerCount,
    int? advancedCount,
    int? expertCount,
  });
  VocabularyOverviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _VocabularyOverviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, VocabularyOverview, $Out>
    implements VocabularyOverviewCopyWith<$R, VocabularyOverview, $Out> {
  _VocabularyOverviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<VocabularyOverview> $mapper =
      VocabularyOverviewMapper.ensureInitialized();
  @override
  $R call({
    int? totalCount,
    int? dueCount,
    int? addedTodayCount,
    Object? nextDueAt = $none,
    int? noviceCount,
    int? beginnerCount,
    int? advancedCount,
    int? expertCount,
  }) => $apply(
    FieldCopyWithData({
      if (totalCount != null) #totalCount: totalCount,
      if (dueCount != null) #dueCount: dueCount,
      if (addedTodayCount != null) #addedTodayCount: addedTodayCount,
      if (nextDueAt != $none) #nextDueAt: nextDueAt,
      if (noviceCount != null) #noviceCount: noviceCount,
      if (beginnerCount != null) #beginnerCount: beginnerCount,
      if (advancedCount != null) #advancedCount: advancedCount,
      if (expertCount != null) #expertCount: expertCount,
    }),
  );
  @override
  VocabularyOverview $make(CopyWithData data) => VocabularyOverview(
    totalCount: data.get(#totalCount, or: $value.totalCount),
    dueCount: data.get(#dueCount, or: $value.dueCount),
    addedTodayCount: data.get(#addedTodayCount, or: $value.addedTodayCount),
    nextDueAt: data.get(#nextDueAt, or: $value.nextDueAt),
    noviceCount: data.get(#noviceCount, or: $value.noviceCount),
    beginnerCount: data.get(#beginnerCount, or: $value.beginnerCount),
    advancedCount: data.get(#advancedCount, or: $value.advancedCount),
    expertCount: data.get(#expertCount, or: $value.expertCount),
  );

  @override
  VocabularyOverviewCopyWith<$R2, VocabularyOverview, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _VocabularyOverviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

