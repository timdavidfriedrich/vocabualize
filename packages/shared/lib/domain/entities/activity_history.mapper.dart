// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'activity_history.dart';

class ActivityHistoryMapper extends ClassMapperBase<ActivityHistory> {
  ActivityHistoryMapper._();

  static ActivityHistoryMapper? _instance;
  static ActivityHistoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ActivityHistoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ActivityHistory';

  static Set<DateTime> _$activeDays(ActivityHistory v) => v.activeDays;
  static const Field<ActivityHistory, Set<DateTime>> _f$activeDays = Field(
    'activeDays',
    _$activeDays,
  );
  static DateTime _$today(ActivityHistory v) => v.today;
  static const Field<ActivityHistory, DateTime> _f$today = Field(
    'today',
    _$today,
  );

  @override
  final MappableFields<ActivityHistory> fields = const {
    #activeDays: _f$activeDays,
    #today: _f$today,
  };

  static ActivityHistory _instantiate(DecodingData data) {
    return ActivityHistory(
      activeDays: data.dec(_f$activeDays),
      today: data.dec(_f$today),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ActivityHistory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ActivityHistory>(map);
  }

  static ActivityHistory fromJson(String json) {
    return ensureInitialized().decodeJson<ActivityHistory>(json);
  }
}

mixin ActivityHistoryMappable {
  String toJson() {
    return ActivityHistoryMapper.ensureInitialized()
        .encodeJson<ActivityHistory>(this as ActivityHistory);
  }

  Map<String, dynamic> toMap() {
    return ActivityHistoryMapper.ensureInitialized().encodeMap<ActivityHistory>(
      this as ActivityHistory,
    );
  }

  ActivityHistoryCopyWith<ActivityHistory, ActivityHistory, ActivityHistory>
  get copyWith =>
      _ActivityHistoryCopyWithImpl<ActivityHistory, ActivityHistory>(
        this as ActivityHistory,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ActivityHistoryMapper.ensureInitialized().stringifyValue(
      this as ActivityHistory,
    );
  }

  @override
  bool operator ==(Object other) {
    return ActivityHistoryMapper.ensureInitialized().equalsValue(
      this as ActivityHistory,
      other,
    );
  }

  @override
  int get hashCode {
    return ActivityHistoryMapper.ensureInitialized().hashValue(
      this as ActivityHistory,
    );
  }
}

extension ActivityHistoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ActivityHistory, $Out> {
  ActivityHistoryCopyWith<$R, ActivityHistory, $Out> get $asActivityHistory =>
      $base.as((v, t, t2) => _ActivityHistoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ActivityHistoryCopyWith<$R, $In extends ActivityHistory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({Set<DateTime>? activeDays, DateTime? today});
  ActivityHistoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ActivityHistoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ActivityHistory, $Out>
    implements ActivityHistoryCopyWith<$R, ActivityHistory, $Out> {
  _ActivityHistoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ActivityHistory> $mapper =
      ActivityHistoryMapper.ensureInitialized();
  @override
  $R call({Set<DateTime>? activeDays, DateTime? today}) => $apply(
    FieldCopyWithData({
      if (activeDays != null) #activeDays: activeDays,
      if (today != null) #today: today,
    }),
  );
  @override
  ActivityHistory $make(CopyWithData data) => ActivityHistory(
    activeDays: data.get(#activeDays, or: $value.activeDays),
    today: data.get(#today, or: $value.today),
  );

  @override
  ActivityHistoryCopyWith<$R2, ActivityHistory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ActivityHistoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

