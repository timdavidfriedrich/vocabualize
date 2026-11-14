// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'local_vocabulary_overview.dart';

class LocalVocabularyOverviewMapper
    extends ClassMapperBase<LocalVocabularyOverview> {
  LocalVocabularyOverviewMapper._();

  static LocalVocabularyOverviewMapper? _instance;
  static LocalVocabularyOverviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = LocalVocabularyOverviewMapper._(),
      );
    }
    return _instance!;
  }

  @override
  final String id = 'LocalVocabularyOverview';

  static int _$totalCount(LocalVocabularyOverview v) => v.totalCount;
  static const Field<LocalVocabularyOverview, int> _f$totalCount = Field(
    'totalCount',
    _$totalCount,
  );
  static int _$dueCount(LocalVocabularyOverview v) => v.dueCount;
  static const Field<LocalVocabularyOverview, int> _f$dueCount = Field(
    'dueCount',
    _$dueCount,
  );
  static int _$waitingCount(LocalVocabularyOverview v) => v.waitingCount;
  static const Field<LocalVocabularyOverview, int> _f$waitingCount = Field(
    'waitingCount',
    _$waitingCount,
  );
  static int _$addedTodayCount(LocalVocabularyOverview v) => v.addedTodayCount;
  static const Field<LocalVocabularyOverview, int> _f$addedTodayCount = Field(
    'addedTodayCount',
    _$addedTodayCount,
  );
  static DateTime? _$nextDueAt(LocalVocabularyOverview v) => v.nextDueAt;
  static const Field<LocalVocabularyOverview, DateTime> _f$nextDueAt = Field(
    'nextDueAt',
    _$nextDueAt,
  );
  static Map<double, int> _$countsByLevelFloor(LocalVocabularyOverview v) =>
      v.countsByLevelFloor;
  static const Field<LocalVocabularyOverview, Map<double, int>>
  _f$countsByLevelFloor = Field('countsByLevelFloor', _$countsByLevelFloor);

  @override
  final MappableFields<LocalVocabularyOverview> fields = const {
    #totalCount: _f$totalCount,
    #dueCount: _f$dueCount,
    #waitingCount: _f$waitingCount,
    #addedTodayCount: _f$addedTodayCount,
    #nextDueAt: _f$nextDueAt,
    #countsByLevelFloor: _f$countsByLevelFloor,
  };

  static LocalVocabularyOverview _instantiate(DecodingData data) {
    return LocalVocabularyOverview(
      totalCount: data.dec(_f$totalCount),
      dueCount: data.dec(_f$dueCount),
      waitingCount: data.dec(_f$waitingCount),
      addedTodayCount: data.dec(_f$addedTodayCount),
      nextDueAt: data.dec(_f$nextDueAt),
      countsByLevelFloor: data.dec(_f$countsByLevelFloor),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocalVocabularyOverview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocalVocabularyOverview>(map);
  }

  static LocalVocabularyOverview fromJson(String json) {
    return ensureInitialized().decodeJson<LocalVocabularyOverview>(json);
  }
}

mixin LocalVocabularyOverviewMappable {
  String toJson() {
    return LocalVocabularyOverviewMapper.ensureInitialized()
        .encodeJson<LocalVocabularyOverview>(this as LocalVocabularyOverview);
  }

  Map<String, dynamic> toMap() {
    return LocalVocabularyOverviewMapper.ensureInitialized()
        .encodeMap<LocalVocabularyOverview>(this as LocalVocabularyOverview);
  }

  LocalVocabularyOverviewCopyWith<
    LocalVocabularyOverview,
    LocalVocabularyOverview,
    LocalVocabularyOverview
  >
  get copyWith =>
      _LocalVocabularyOverviewCopyWithImpl<
        LocalVocabularyOverview,
        LocalVocabularyOverview
      >(this as LocalVocabularyOverview, $identity, $identity);
  @override
  String toString() {
    return LocalVocabularyOverviewMapper.ensureInitialized().stringifyValue(
      this as LocalVocabularyOverview,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocalVocabularyOverviewMapper.ensureInitialized().equalsValue(
      this as LocalVocabularyOverview,
      other,
    );
  }

  @override
  int get hashCode {
    return LocalVocabularyOverviewMapper.ensureInitialized().hashValue(
      this as LocalVocabularyOverview,
    );
  }
}

extension LocalVocabularyOverviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocalVocabularyOverview, $Out> {
  LocalVocabularyOverviewCopyWith<$R, LocalVocabularyOverview, $Out>
  get $asLocalVocabularyOverview => $base.as(
    (v, t, t2) => _LocalVocabularyOverviewCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LocalVocabularyOverviewCopyWith<
  $R,
  $In extends LocalVocabularyOverview,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, double, int, ObjectCopyWith<$R, int, int>>
  get countsByLevelFloor;
  $R call({
    int? totalCount,
    int? dueCount,
    int? waitingCount,
    int? addedTodayCount,
    DateTime? nextDueAt,
    Map<double, int>? countsByLevelFloor,
  });
  LocalVocabularyOverviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LocalVocabularyOverviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocalVocabularyOverview, $Out>
    implements
        LocalVocabularyOverviewCopyWith<$R, LocalVocabularyOverview, $Out> {
  _LocalVocabularyOverviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocalVocabularyOverview> $mapper =
      LocalVocabularyOverviewMapper.ensureInitialized();
  @override
  MapCopyWith<$R, double, int, ObjectCopyWith<$R, int, int>>
  get countsByLevelFloor => MapCopyWith(
    $value.countsByLevelFloor,
    (v, t) => ObjectCopyWith(v, $identity, t),
    (v) => call(countsByLevelFloor: v),
  );
  @override
  $R call({
    int? totalCount,
    int? dueCount,
    int? waitingCount,
    int? addedTodayCount,
    Object? nextDueAt = $none,
    Map<double, int>? countsByLevelFloor,
  }) => $apply(
    FieldCopyWithData({
      if (totalCount != null) #totalCount: totalCount,
      if (dueCount != null) #dueCount: dueCount,
      if (waitingCount != null) #waitingCount: waitingCount,
      if (addedTodayCount != null) #addedTodayCount: addedTodayCount,
      if (nextDueAt != $none) #nextDueAt: nextDueAt,
      if (countsByLevelFloor != null) #countsByLevelFloor: countsByLevelFloor,
    }),
  );
  @override
  LocalVocabularyOverview $make(CopyWithData data) => LocalVocabularyOverview(
    totalCount: data.get(#totalCount, or: $value.totalCount),
    dueCount: data.get(#dueCount, or: $value.dueCount),
    waitingCount: data.get(#waitingCount, or: $value.waitingCount),
    addedTodayCount: data.get(#addedTodayCount, or: $value.addedTodayCount),
    nextDueAt: data.get(#nextDueAt, or: $value.nextDueAt),
    countsByLevelFloor: data.get(
      #countsByLevelFloor,
      or: $value.countsByLevelFloor,
    ),
  );

  @override
  LocalVocabularyOverviewCopyWith<$R2, LocalVocabularyOverview, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _LocalVocabularyOverviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

